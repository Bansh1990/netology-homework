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
   our_services = {"services": {}}
   
   for i in sys.argv[1:]:
       serv_ip = socket.gethostbyname(i)
       our_services["services"].update({i: serv_ip})
   
   with open('services.json', 'w') as jsn:
       jsn.write(json.dumps(our_services, indent=4))
   with open('services.yml', 'w') as yml:
       yml.write(yaml.dump(our_services))
   
   while 1:
       for i in our_services["services"]:
           if our_services["services"][i] != socket.gethostbyname(i):
               print(f'[ERROR] {i} IP mismatch: {our_services["services"][i]} {socket.gethostbyname(i)}')
               serv_ip = socket.gethostbyname(i)
               new_ip = {i: serv_ip}
               our_services["services"].update(new_ip)
               with open('services.json', 'w') as jsn:
                   jsn.write(json.dumps(our_services, indent=4))
               with open('services.yml', 'w') as yml:
                   yml.write(yaml.dump(our_services))
           else:
               print(f'{i}: {our_services["services"][i]}')
           time.sleep(1)

    ```