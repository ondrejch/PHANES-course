"""Educational steady single-stream heat balance, not a reactor safety model."""
import argparse
from datetime import datetime,timezone
import json
import math
from pathlib import Path

def calculate(power_W,mass_flow_kg_s,cp_J_kg_K,inlet_K):
    values={'power_W':power_W,'mass_flow_kg_s':mass_flow_kg_s,'cp_J_kg_K':cp_J_kg_K,'inlet_K':inlet_K}
    if not all(math.isfinite(x) for x in values.values()):
        raise ValueError('All inputs must be finite.')
    if power_W < 0 or mass_flow_kg_s <= 0 or cp_J_kg_K <= 0 or inlet_K <= 0:
        raise ValueError('Require nonnegative power, positive flow, positive cp and positive inlet Kelvin.')
    rise=power_W/(mass_flow_kg_s*cp_J_kg_K)
    outlet=inlet_K+rise
    if not all(math.isfinite(x) for x in (rise,outlet)):
        raise ValueError('The result is nonfinite; check input magnitudes.')
    return {'status':'ok','inputs':values,'delta_T_K':rise,'outlet_K':outlet,'units':{'delta_T_K':'K','outlet_K':'K'},'assumptions':['steady','constant cp','no losses'],'tool_version':'1.0','created_utc':datetime.now(timezone.utc).isoformat()}

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    for name in ['power-W','mass-flow-kg-s','cp-J-kg-K','inlet-K']:
        p.add_argument('--'+name,type=float,required=True)
    p.add_argument('--output',type=Path)
    args=p.parse_args()
    try:
        result=calculate(args.power_W,args.mass_flow_kg_s,args.cp_J_kg_K,args.inlet_K)
        serialized=json.dumps(result,indent=2,allow_nan=False)+'\n'
        if args.output:
            # Exclusive create avoids silently overwriting a previous case.
            with args.output.open('x') as f:f.write(serialized)
        print(serialized,end='')
    except (ValueError,OverflowError,ZeroDivisionError,OSError) as error:
        print(json.dumps({'status':'error','message':str(error)}))
        raise SystemExit(2)
