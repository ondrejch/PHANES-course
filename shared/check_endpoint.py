"""Read model metadata, then send one small public completion request."""
import json
import os
import ssl
import urllib.error
import urllib.request

base=os.environ['PHANES_BASE_URL'].rstrip('/')
model=os.environ['PHANES_MODEL']
context=ssl.create_default_context(cafile=os.environ.get('PHANES_CA_FILE') or None)
headers={'Authorization':'Bearer '+os.environ['PHANES_API_KEY'],'Content-Type':'application/json'}

class NoRedirect(urllib.request.HTTPRedirectHandler):
    def redirect_request(self,req,fp,code,msg,hdrs,newurl):
        raise urllib.error.HTTPError(req.full_url,code,'Unexpected redirect; check endpoint URL.',hdrs,fp)

opener=urllib.request.build_opener(NoRedirect(),urllib.request.HTTPSHandler(context=context))
def request(route,payload=None):
    req=urllib.request.Request(base+route,headers=headers,data=None if payload is None else json.dumps(payload).encode())
    with opener.open(req,timeout=180) as response:
        return json.load(response)

try:
    available=request('/models')
    ids=[entry['id'] for entry in available.get('data',[])]
    if model not in ids:
        raise SystemExit('Requested model alias is absent from /v1/models. Check the instructor-issued alias.')
    print('TLS, authentication and served-model lookup: passed.')
    completion=request('/chat/completions',{'model':model,'messages':[{'role':'user','content':'Reply with the single word READY.'}],'max_tokens':512})
    choices=completion.get('choices',[])
    if not choices:
        raise SystemExit('Completion did not return a choices list.')
    message=choices[0].get('message',{})
    if not message.get('content'):
        raise SystemExit('No final content returned. Inspect reasoning/output budget and template settings.')
    print('Completion returned final content. Tool-use validation is still required in OpenCode.')
    print('Reply:',message['content'])
except urllib.error.HTTPError as e:
    raise SystemExit(f'HTTP {e.code}: check URL, authorization and server status. No credential is printed.')
except (urllib.error.URLError,TimeoutError,json.JSONDecodeError) as e:
    raise SystemExit(f'Endpoint check failed ({type(e).__name__}). Check server, TLS trust and network access.')
