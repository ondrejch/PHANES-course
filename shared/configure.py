"""Generate a private-provider config; never write the credential itself."""
import json
import os
from pathlib import Path
from urllib.parse import urlsplit

def generate(env):
    url = env['PHANES_BASE_URL'].rstrip('/')
    parsed = urlsplit(url)
    if parsed.scheme != 'https' or not parsed.hostname or parsed.path != '/v1' or parsed.query or parsed.fragment or parsed.username or parsed.password:
        raise ValueError('PHANES_BASE_URL must be an HTTPS endpoint ending in /v1, without credentials or query parameters.')
    if parsed.hostname.endswith('example.edu'):
        raise ValueError('Replace the example hostname with the issued endpoint.')
    if env['PHANES_API_KEY'] == 'replace-with-your-issued-key' or not env['PHANES_API_KEY']:
        raise ValueError('Set the issued API key in .env.')
    model=env['PHANES_MODEL']
    if not model or any(c.isspace() for c in model):
        raise ValueError('PHANES_MODEL must be a nonempty served-model identifier.')
    context=int(env.get('PHANES_CONTEXT','262144'))
    output=int(env.get('PHANES_OUTPUT','8192'))
    if not 0 < output < context:
        raise ValueError('Require 0 < PHANES_OUTPUT < PHANES_CONTEXT.')
    return {
      '$schema':'https://opencode.ai/config.json',
      'model':f'phanes/{model}',
      'small_model':f'phanes/{model}',
      'enabled_providers':['phanes'],
      'share':'disabled',
      'autoupdate':False,
      'provider':{'phanes':{
        'npm':'@ai-sdk/openai-compatible',
        'name':'PHANES private inference',
        'options':{'baseURL':'{env:PHANES_BASE_URL}','apiKey':'{env:PHANES_API_KEY}'},
        'models':{model:{'name':model,'limit':{'context':context,'output':output}}}
      }},
      'permission':{'*':'ask','read':{'*':'allow','.env':'deny','*.env':'deny','*.env.*':'deny'},'webfetch':'deny'}
    }

if __name__=='__main__':
    try:
        config=generate(os.environ)
        output=Path(__file__).resolve().parent/'.generated/opencode.json'
        output.parent.mkdir(exist_ok=True)
        output.write_text(json.dumps(config,indent=2)+'\n')
    except (KeyError,ValueError) as error:
        raise SystemExit(f'Configuration error: {error}')
