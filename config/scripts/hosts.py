#!/usr/bin/python 

import os 
import sys
from jinja import Environment
from yaml import load 

APP_ROOT = os.path.dirname(os.path.dirname(__file__))
APP_VERS = sys.argv[1]

if not os.path.exists("%s/hosts.yml" % APP_ROOT):
    print("hosts.yml not found")
    sys.exit(1)
    
if not os.path.exists("%s/vhost.tpl" % APP_ROOT):
    print("vhost.tpl not found")
    sys.exit(1)

with open("%s/hosts.yml" % APP_ROOT) as yml:
    tpl = ""
    with open("%s/vhost.tpl" % APP_ROOT) as t:
        tpl = t.read()
    
    for domain, server_data in load(yml.read()).items():
        
        if ('version' in server_data) and (server_data['version'] != APP_VERS):
            continue
        
        data = Environment().from_string(tpl).render(server_name=domain, data=server_data)
        
        with open('/etc/apache2/sites-available/%s.conf' % domain, 'w') as f:
            f.write(data)
            symlink = '/etc/apache2/sites-enabled/%s.conf' % domain 
            if os.path.exists(symlink):
                os.unlink(symlink)
            
            if ('enabled' in server_data) and (int(server_data['enabled']) == 1):
                os.symlink('/etc/apache2/sites-available/%s.conf' % domain, '/etc/apache2/sites-enabled/%s.conf' % domain)
            
            if not os.path.exists('/var/log/apache2/%s' % domain):
                os.makedirs('/var/log/apache2/%s' % domain)
