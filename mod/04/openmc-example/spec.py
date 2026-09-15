"""Public, idealized classroom geometry. Lengths are cm."""
PITCH = 1.26
RADII = (0.4096, 0.4180, 0.4750)
WATER_SITES = (2, 5, 8, 11, 14)
ASSEMBLY_PITCH = 17 * PITCH
CORE_HALF = 1.5 * ASSEMBLY_PITCH

def validate(pitch=PITCH, radii=RADII, reflector=20., particles=1000,
             batches=40, inactive=10):
    if not (0 < radii[0] < radii[1] < radii[2] < pitch / 2):
        raise ValueError('Require 0 < fuel < gap < clad < pitch/2')
    if reflector <= 0 or particles <= 0 or not 0 <= inactive < batches:
        raise ValueError('Invalid reflector or run controls')
    return {'fuel_pins_per_assembly': 17**2-len(WATER_SITES)**2,
            'fuel_pins_in_core': 9*(17**2-len(WATER_SITES)**2)}
