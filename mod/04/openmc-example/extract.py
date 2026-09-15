"""Extract the manifest-named statepoint; never infer a result from a log."""
import argparse
import hashlib
import json
from pathlib import Path
import openmc

def digest(path): return hashlib.sha256(path.read_bytes()).hexdigest()
p = argparse.ArgumentParser(description=__doc__)
p.add_argument('run_directory',type=Path)
a = p.parse_args()
m = json.loads((a.run_directory/'manifest.json').read_text())
for name,expected in m['xml_sha256'].items():
    if digest(a.run_directory/name)!=expected:
        raise SystemExit(f'Input changed since build: {name}')
path = a.run_directory/m['expected_statepoint']
with openmc.StatePoint(path) as sp:
    tally = sp.get_tally(name='fission-map')
    means,stds = tally.mean.ravel(),tally.std_dev.ravel()
    total = float(means.sum())
    result = {'status':'extracted_acceptance_pending',
        'statepoint':path.name,'statepoint_sha256':digest(path),
        'manifest_sha256':digest(a.run_directory/'manifest.json'),
        'keff_mean':float(sp.keff.nominal_value),'keff_std':float(sp.keff.std_dev),
        'fission_mean_per_source':means.tolist(),'fission_std_per_source':stds.tolist(),
        'fission_fraction_point_estimate':(means/total).tolist() if total>0 else None,
        'normalization_note':'Fractions cover the tally mesh only. Ratio uncertainty requires covariance-aware analysis.',
        'acceptance_checks_required':['geometry','lost particles','source convergence',
                                      'tally precision','nuclear data identity','independent review']}
with (a.run_directory/'result.json').open('x') as f: json.dump(result,f,indent=2)
