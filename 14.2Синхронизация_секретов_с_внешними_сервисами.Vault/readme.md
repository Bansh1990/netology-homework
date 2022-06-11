# Домашнее задание к занятию "14.2 Синхронизация секретов с внешними сервисами. Vault"

## Задача 1: Работа с модулем Vault

Запустить модуль Vault конфигураций через утилиту kubectl в установленном minikube

```
kubectl apply -f 14.2/vault-pod.yml
```
```bash
root@node1:~/14.2# kubectl get po
NAME                  READY   STATUS    RESTARTS   AGE
14.2-netology-vault   1/1     Running   0          52s
```

Получить значение внутреннего IP пода

```
kubectl get pod 14.2-netology-vault -o json | jq -c '.status.podIPs'
```
```bash
root@node1:~/14.2# kubectl get pod 14.2-netology-vault -o json | jq -c '.status.podIPs'
[{"ip":"10.233.64.4"}]
```
Примечание: jq - утилита для работы с JSON в командной строке

Запустить второй модуль для использования в качестве клиента

```
kubectl run -i --tty fedora --image=fedora --restart=Never -- sh
```

Установить дополнительные пакеты

```
dnf -y install pip
pip install hvac
```
```bash

root@node1:~/14.2# kubectl run -i --tty fedora --image=fedora --restart=Never -- sh
If you don't see a command prompt, try pressing enter.
sh-5.1# dnf -y install pip
Fedora 36 - x86_64                                                                                                                           1.7 MB/s |  81 MB     00:46    
Fedora 36 openh264 (From Cisco) - x86_64                                                                                                     2.0 kB/s | 2.5 kB     00:01    
Fedora Modular 36 - x86_64                                                                                                                   980 kB/s | 2.4 MB     00:02    
Fedora 36 - x86_64 - Updates                                                                                                                 1.6 MB/s |  17 MB     00:10    
Fedora Modular 36 - x86_64 - Updates                                                                                                         1.6 MB/s | 2.2 MB     00:01    
Dependencies resolved.
=============================================================================================================================================================================
 Package                                         Architecture                        Version                                       Repository                           Size
=============================================================================================================================================================================
Installing:
 python3-pip                                     noarch                              21.3.1-2.fc36                                 fedora                              1.8 M
Installing weak dependencies:
 libxcrypt-compat                                x86_64                              4.4.28-1.fc36                                 fedora                               90 k
 python3-setuptools                              noarch                              59.6.0-2.fc36                                 fedora                              936 k

Transaction Summary
=============================================================================================================================================================================
Install  3 Packages

Total download size: 2.8 M
Installed size: 14 M
Downloading Packages:
(1/3): libxcrypt-compat-4.4.28-1.fc36.x86_64.rpm                                                                                             217 kB/s |  90 kB     00:00    
(2/3): python3-setuptools-59.6.0-2.fc36.noarch.rpm                                                                                           946 kB/s | 936 kB     00:00    
(3/3): python3-pip-21.3.1-2.fc36.noarch.rpm                                                                                                  1.0 MB/s | 1.8 MB     00:01    
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                                        1.4 MB/s | 2.8 MB     00:02     
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                                                                     1/1 
  Installing       : python3-setuptools-59.6.0-2.fc36.noarch                                                                                                             1/3 
  Installing       : libxcrypt-compat-4.4.28-1.fc36.x86_64                                                                                                               2/3 
  Installing       : python3-pip-21.3.1-2.fc36.noarch                                                                                                                    3/3 
  Running scriptlet: python3-pip-21.3.1-2.fc36.noarch                                                                                                                    3/3 
  Verifying        : libxcrypt-compat-4.4.28-1.fc36.x86_64                                                                                                               1/3 
  Verifying        : python3-pip-21.3.1-2.fc36.noarch                                                                                                                    2/3 
  Verifying        : python3-setuptools-59.6.0-2.fc36.noarch                                                                                                             3/3 

Installed:
  libxcrypt-compat-4.4.28-1.fc36.x86_64                     python3-pip-21.3.1-2.fc36.noarch                     python3-setuptools-59.6.0-2.fc36.noarch                    

Complete!
sh-5.1# pip install hvac
Collecting hvac
  Downloading hvac-0.11.2-py2.py3-none-any.whl (148 kB)
     |████████████████████████████████| 148 kB 1.3 MB/s            
Collecting six>=1.5.0
  Downloading six-1.16.0-py2.py3-none-any.whl (11 kB)
Collecting requests>=2.21.0
  Downloading requests-2.28.0-py3-none-any.whl (62 kB)
     |████████████████████████████████| 62 kB 2.0 MB/s             
Collecting charset-normalizer~=2.0.0
  Downloading charset_normalizer-2.0.12-py3-none-any.whl (39 kB)
Collecting urllib3<1.27,>=1.21.1
  Downloading urllib3-1.26.9-py2.py3-none-any.whl (138 kB)
     |████████████████████████████████| 138 kB 9.8 MB/s            
Collecting idna<4,>=2.5
  Downloading idna-3.3-py3-none-any.whl (61 kB)
     |████████████████████████████████| 61 kB 7.5 MB/s             
Collecting certifi>=2017.4.17
  Downloading certifi-2022.5.18.1-py3-none-any.whl (155 kB)
     |████████████████████████████████| 155 kB 15.8 MB/s            
Installing collected packages: urllib3, idna, charset-normalizer, certifi, six, requests, hvac
Successfully installed certifi-2022.5.18.1 charset-normalizer-2.0.12 hvac-0.11.2 idna-3.3 requests-2.28.0 six-1.16.0 urllib3-1.26.9
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
```

Запустить интепретатор Python и выполнить следующий код, предварительно
поменяв IP и токен

```
import hvac
client = hvac.Client(
    url='http://10.233.64.4:8200',
    token='aiphohTaa0eeHei'
)
client.is_authenticated()

# Пишем секрет
client.secrets.kv.v2.create_or_update_secret(
    path='hvac',
    secret=dict(netology='Big secret!!!'),
)

# Читаем секрет
client.secrets.kv.v2.read_secret_version(
    path='hvac',
)
```

```python
>>> client = hvac.Client(
...     url='http://10.233.64.4:8200',
...     token='aiphohTaa0eeHei'
... )
>>> client.is_authenticated()
True
>>> client.secrets.kv.v2.create_or_update_secret(
...     path='hvac',
...     secret=dict(netology='Big secret!!!'),
... )
{'request_id': '49d968af-1105-95fc-feb6-55e6552b9e3a', 'lease_id': '', 'renewable': False, 'lease_duration': 0, 'data': {'created_time': '2022-06-11T07:39:12.638484256Z', 'custom_metadata': None, 'deletion_time': '', 'destroyed': False, 'version': 1}, 'wrap_info': None, 'warnings': None, 'auth': None}
>>> 
>>> 
>>> 
>>> client.secrets.kv.v2.read_secret_version(
...     path='hvac',
... )
{'request_id': '388ab9e2-740b-da48-45d7-af3c107b0f5e', 'lease_id': '', 'renewable': False, 'lease_duration': 0, 'data': {'data': {'netology': 'Big secret!!!'}, 'metadata': {'created_time': '2022-06-11T07:39:12.638484256Z', 'custom_metadata': None, 'deletion_time': '', 'destroyed': False, 'version': 1}}, 'wrap_info': None, 'warnings': None, 'auth': None}
```

## Задача 2 (*): Работа с секретами внутри модуля

* На основе образа fedora создать модуль;
* Создать секрет, в котором будет указан токен;
* Подключить секрет к модулю;
* Запустить модуль и проверить доступность сервиса Vault.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

В качестве решения прикрепите к ДЗ конфиг файлы для деплоя. Прикрепите скриншоты вывода команды kubectl со списком запущенных объектов каждого типа (pods, deployments, statefulset, service) или скриншот из самого Kubernetes, что сервисы подняты и работают, а также вывод из CLI.

---