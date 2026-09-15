"""Generate inputs only. Run transport separately after human review."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import numpy as np
import openmc
from spec import PITCH, RADII, WATER_SITES, ASSEMBLY_PITCH, CORE_HALF, validate

def digest(p):
    return hashlib.sha256(Path(p).read_bytes()).hexdigest()

def box(lower, upper, boundary='transmission'):
    region = None
    for axis, lo, hi in zip('xyz', lower, upper):
        cls = getattr(openmc, axis.upper()+'Plane')
        a = cls(**{axis+'0': lo}, boundary_type=boundary)
        b = cls(**{axis+'0': hi}, boundary_type=boundary)
        segment = +a & -b
        region = segment if region is None else region & segment
    return region

def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--mode', choices=['pin','assembly','core'], required=True)
    p.add_argument('--reflector-cm', type=float, default=20.)
    p.add_argument('--particles', type=int, default=1000)
    p.add_argument('--batches', type=int, default=40)
    p.add_argument('--inactive', type=int, default=10)
    p.add_argument('--seed', type=int, default=3407)
    p.add_argument('--out', type=Path, required=True)
    a = p.parse_args()
    counts = validate(reflector=a.reflector_cm, particles=a.particles,
                      batches=a.batches, inactive=a.inactive)
    if a.seed <= 0: p.error('seed must be positive')
    if a.out.exists(): p.error('Use a new output directory for each case')
    fuel = openmc.Material(name='fuel', temperature=900.)
    fuel.add_element('U', 1., enrichment=3.0)
    fuel.add_element('O', 2.)
    fuel.set_density('g/cm3',10.297)
    helium = openmc.Material(name='helium', temperature=600.)
    helium.add_element('He',1.)
    helium.set_density('g/cm3',.0016)
    zirconium = openmc.Material(name='elemental zirconium surrogate', temperature=600.)
    zirconium.add_element('Zr',1.)
    zirconium.set_density('g/cm3',6.55)
    water = openmc.Material(name='water', temperature=600.)
    water.add_element('H',2.)
    water.add_element('O',1.)
    water.set_density('g/cm3',.70)
    water.add_s_alpha_beta('c_H_in_H2O')
    rf, rg, rc = [openmc.ZCylinder(r=r) for r in RADII]
    pin = openmc.Universe(cells=[openmc.Cell(fill=fuel,region=-rf),
        openmc.Cell(fill=helium,region=+rf & -rg),
        openmc.Cell(fill=zirconium,region=+rg & -rc),
        openmc.Cell(fill=water,region=+rc)])
    wu = openmc.Universe(cells=[openmc.Cell(fill=water)])
    lat = openmc.RectLattice(name='idealized assembly')
    lat.pitch = (PITCH,PITCH)
    lat.lower_left = (-ASSEMBLY_PITCH/2,)*2
    u = np.full((17,17),pin,dtype=object)
    for row in WATER_SITES:
        for col in WATER_SITES: u[row,col] = wu
    lat.universes, lat.outer = u, wu
    au = openmc.Universe(cells=[openmc.Cell(fill=lat)])
    core = openmc.RectLattice(name='3 by 3 teaching core')
    core.pitch = (ASSEMBLY_PITCH,)*2
    core.lower_left = (-CORE_HALF,)*2
    core.universes, core.outer = np.full((3,3),au,dtype=object), wu
    half = {'pin':PITCH/2,'assembly':ASSEMBLY_PITCH/2,'core':CORE_HALF}[a.mode]
    zhalf = 100. if a.mode=='core' else 1.
    lower, upper = (-half,-half,-zhalf),(half,half,zhalf)
    if a.mode=='core':
        inner = box(lower,upper)
        outer_upper = tuple(x+a.reflector_cm for x in upper)
        outer_lower = tuple(-x for x in outer_upper)
        outer = box(outer_lower,outer_upper,'vacuum')
        cells = [openmc.Cell(fill=core,region=inner),
                 openmc.Cell(fill=water,region=outer & ~inner)]
    else:
        outer_lower,outer_upper = lower,upper
        cells = [openmc.Cell(fill=pin if a.mode=='pin' else au,
                            region=box(lower,upper,'reflective'))]
    geometry = openmc.Geometry(cells)
    settings = openmc.Settings()
    settings.run_mode = 'eigenvalue'
    settings.particles,settings.batches,settings.inactive = a.particles,a.batches,a.inactive
    settings.seed = a.seed
    settings.temperature = {'method':'interpolation'}
    settings.source = openmc.IndependentSource(space=openmc.stats.Box(lower,upper),
                                               constraints={'fissionable':True})
    entropy = openmc.RegularMesh()
    entropy.lower_left,entropy.upper_right = lower,upper
    entropy.dimension = (10,10,10) if a.mode=='core' else (4,4,1)
    settings.entropy_mesh = entropy
    mesh = openmc.RegularMesh()
    mesh.lower_left,mesh.upper_right = lower,upper
    mesh.dimension = {'pin':(1,1,1),'assembly':(17,17,1),'core':(51,51,1)}[a.mode]
    tally = openmc.Tally(name='fission-map')
    tally.filters,tally.scores = [openmc.MeshFilter(mesh)],['fission']
    plots = []
    for basis,axes in [('xy',(0,1)),('xz',(0,2))]:
        plot = openmc.Plot()
        plot.basis,plot.origin = basis,(0.,0.,0.)
        plot.width = tuple(outer_upper[i]-outer_lower[i] for i in axes)
        plot.pixels,plot.color_by = (1000,1000),'material'
        plots.append(plot)
    model = openmc.Model(geometry=geometry,materials=openmc.Materials([fuel,helium,zirconium,water]),
                        settings=settings,tallies=openmc.Tallies([tally]),plots=openmc.Plots(plots))
    a.out.mkdir(parents=True)
    model.export_to_xml(directory=a.out)
    xs = os.environ.get('OPENMC_CROSS_SECTIONS')
    manifest = {'case':dict(vars(a),out=str(a.out)), 'counts':counts,
        'openmc_version':openmc.__version__,
        'source_sha256':{f:digest(Path(__file__).parent/f) for f in ('model.py','spec.py')},
        'xml_sha256':{f.name:digest(f) for f in a.out.glob('*.xml')},
        'cross_sections_path':xs,
        'cross_sections_index_sha256':digest(xs) if xs and Path(xs).is_file() else None,
        'data_release':os.environ.get('OPENMC_DATA_RELEASE','UNRECORDED'),
        'expected_statepoint':f'statepoint.{a.batches}.h5',
        'status':'inputs_built_not_run'}
    (a.out/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
    print(f'Inputs built at {a.out}; review geometry, nuclear data and budget before transport.')

if __name__=='__main__': main()
