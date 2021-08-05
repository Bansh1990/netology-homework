# 4.3. Языки разметки JSON и YAML


1. ```json
    {
        "info": "Sample JSON output from our service\t",
        "elements": [
            {
                "name": "first",
                "type": "server",
                "ip": "71.75.22.43"
            },
            {
                "name": "second",
                "type": "proxy",
                "ip": "71.78.22.43"
            }
        ]
    }
    ```
   
2. запускать нужно с параметрами. в параметрах указывать домены. 
 
    например   ```./services mail.ru google.com facebook.com```
    ```python
   #!/usr/bin/env python3
   import socket
   import time
   import sys
   import yaml
   import json
   
   our_services = {}
   list_services = []
   
   for i in sys.argv[1:]:
       serv_ip = socket.gethostbyname(i)
       our_services.update({i: serv_ip})
   
   for host, ip in our_services.items():
       list_services.append({host: ip})
   all_string = {"services": list_services}
   with open('services.json', 'w') as jsn:
       jsn.write(json.dumps(all_string, indent=4))
   with open('services.yml', 'w') as yml:
       yml.write(yaml.dump(all_string))
   
   while 1:
       for i in our_services:
           if our_services[i] != socket.gethostbyname(i):
               print(f'[ERROR] {i} IP mismatch: {our_services[i]} {socket.gethostbyname(i)}')
               serv_ip = socket.gethostbyname(i)
               new_ip = {i: serv_ip}
               our_services.update(new_ip)
               list_services = []
               for host, ip in our_services.items():
                   list_services.append({host: ip})
               all_string = {"services": list_services}
               with open('services.json', 'w') as jsn:
                   jsn.write(json.dumps(all_string, indent=4))
               with open('services.yml', 'w') as yml:
                   yml.write(yaml.dump(all_string, indent=4))
           else:
               print(f'{i}: {our_services[i]}')
           time.sleep(1)
    ```