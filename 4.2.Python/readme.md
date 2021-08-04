# 4.2. Использование Python для решения типовых DevOps задач
 
1. 
   * ничего будет ошибка.
   * ```c = str(a) + str(b)```
   * ```c = int(a) + int(b)```

2. ```python
   #!/usr/bin/env python3
   
   import os
   import sys
   
   scrypt_path = "cd "+os.getcwd()
   bash_command = [str(scrypt_path), "git status"]
   result_os = os.popen(' && '.join(bash_command)).read()
   for result in result_os.split('\n'):
       if result.find('изменено') != -1 or result.find('modified:') != -1:
           prepare_result = result.replace('\tизменено:      ', '').replace('\tmodified:      ', '')
           print(os.getcwd()+"/"+prepare_result)
    ```
   
3. ```python
   #!/usr/bin/env python3

   import os
   import sys
   
   if len(sys.argv) >= 2:
       repopath = sys.argv[1]
       if repopath[-1] != "/":
           repopath = repopath+"/"
       scrypt_path = "cd "+repopath
       if os.path.exists(repopath+".git"):
           bash_command = [str(scrypt_path), "git status"]
           result_os = os.popen(' && '.join(bash_command)).read()
           for result in result_os.split('\n'):
               if result.find('изменено') != -1 or result.find('modified:') != -1:
                   prepare_result = result.replace('\tизменено:      ', '').replace('\tmodified:      ', '')
                   print(repopath + prepare_result)
       else:
           print("в этой папке нет репозитория")
   
   elif os.path.exists('.git'):
       scrypt_path = "cd " + os.getcwd()
       bash_command = [str(scrypt_path), "git status"]
       result_os = os.popen(' && '.join(bash_command)).read()
       for result in result_os.split('\n'):
           if result.find('изменено') != -1 or result.find('modified:') != -1:
               prepare_result = result.replace('\tизменено:      ', '').replace('\tmodified:      ', '')
               print(os.getcwd() + "/" + prepare_result)
   
   else:
       print("ERR: Укажите путь или запустите из директории локального репозитория")
   ```
   

4. Домены вводятся как аргументы через пробел 
   ```python
   #!/usr/bin/env python3
   import socket
   import time
   import sys
   our_services = {}
   for i in sys.argv[1:]:
       serv_ip = socket.gethostbyname(i)
       our_services.update({i: serv_ip})
   while 1:
       for i in our_services:
           if our_services[i] != socket.gethostbyname(i):
               print(f'[ERROR] {i} IP mismatch: {our_services[i]} {socket.gethostbyname(i)}')
               serv_ip = socket.gethostbyname(i)
               new_ip = {i: serv_ip}
               our_services.update(new_ip)
           else:
               print(f'{i}: {our_services[i]}')
           time.sleep(1)
   ```