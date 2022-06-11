# Домашнее задание к занятию "14.3 Карты конфигураций"

## Задача 1: Работа с картами конфигураций через утилиту kubectl в установленном minikube

Выполните приведённые команды в консоли. Получите вывод команд. Сохраните
задачу 1 как справочный материал.

### Как создать карту конфигураций?

```
kubectl create configmap nginx-config --from-file=nginx.conf
kubectl create configmap domain --from-literal=name=netology.ru
```
```bash
root@node1:~/14.2/clokub-homeworks/14.3# kubectl create configmap nginx-config --from-file=nginx.conf
configmap/nginx-config created
root@node1:~/14.2/clokub-homeworks/14.3# kubectl create configmap domain --from-literal=name=netology.ru
configmap/domain created
```

### Как просмотреть список карт конфигураций?

```
kubectl get configmaps
kubectl get configmap
```
```bash
root@node1:~/14.2/clokub-homeworks/14.3# kubectl get configmaps
NAME               DATA   AGE
domain             1      97s
kube-root-ca.crt   1      147m
nginx-config       1      103s
```


### Как просмотреть карту конфигурации?

```
kubectl get configmap nginx-config
kubectl describe configmap domain
```
```bash
root@node1:~/14.2/clokub-homeworks/14.3# kubectl describe configmaps nginx-config 
Name:         nginx-config
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
nginx.conf:
----
server {
    listen 80;
    server_name  netology.ru www.netology.ru;
    access_log  /var/log/nginx/domains/netology.ru-access.log  main;
    error_log   /var/log/nginx/domains/netology.ru-error.log info;
    location / {
        include proxy_params;
        proxy_pass http://10.10.10.10:8080/;
    }
}


BinaryData
====

Events:  <none>
root@node1:~/14.2/clokub-homeworks/14.3# kubectl describe configmap domain
Name:         domain
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
name:
----
netology.ru

BinaryData
====

Events:  <none>
```
### Как получить информацию в формате YAML и/или JSON?

```
kubectl get configmap nginx-config -o yaml
kubectl get configmap domain -o json
```
```bash
root@node1:~/14.2/clokub-homeworks/14.3# kubectl get configmap nginx-config -o yaml
kubectl get configmap domain -o json
apiVersion: v1
data:
  nginx.conf: |
    server {
        listen 80;
        server_name  netology.ru www.netology.ru;
        access_log  /var/log/nginx/domains/netology.ru-access.log  main;
        error_log   /var/log/nginx/domains/netology.ru-error.log info;
        location / {
            include proxy_params;
            proxy_pass http://10.10.10.10:8080/;
        }
    }
kind: ConfigMap
metadata:
  creationTimestamp: "2022-06-11T09:31:23Z"
  name: nginx-config
  namespace: default
  resourceVersion: "13193"
  uid: c2e68e63-a8cc-4fb9-b357-c27ab7fa48b5
{
    "apiVersion": "v1",
    "data": {
        "name": "netology.ru"
    },
    "kind": "ConfigMap",
    "metadata": {
        "creationTimestamp": "2022-06-11T09:31:29Z",
        "name": "domain",
        "namespace": "default",
        "resourceVersion": "13202",
        "uid": "b238b739-e2c4-4fd1-827c-370ed374703b"
    }
}
```
### Как выгрузить карту конфигурации и сохранить его в файл?

```
kubectl get configmaps -o json > configmaps.json
kubectl get configmap nginx-config -o yaml > nginx-config.yml
```
```bash
root@node1:~/14.2/clokub-homeworks/14.3# kubectl get configmaps -o json > configmaps.json
kubectl get configmap nginx-config -o yaml > nginx-config.yml
root@node1:~/14.2/clokub-homeworks/14.3# ls -l
total 24
-rw-r--r-- 1 root root 3240 Jun 11 09:36 configmaps.json
-rw-r--r-- 1 root root  370 Jun 11 09:28 generator.py
-rw-r--r-- 1 root root  576 Jun 11 09:28 myapp-pod.yml
-rw-r--r-- 1 root root  306 Jun 11 09:28 nginx.conf
-rw-r--r-- 1 root root  566 Jun 11 09:36 nginx-config.yml
drwxr-xr-x 2 root root 4096 Jun 11 09:28 templates
```
### Как удалить карту конфигурации?

```
kubectl delete configmap nginx-config
```

```bash
root@node1:~/14.2/clokub-homeworks/14.3# kubectl delete configmap nginx-config
configmap "nginx-config" deleted
```

### Как загрузить карту конфигурации из файла?

```
kubectl apply -f nginx-config.yml
```
```bash
root@node1:~/14.2/clokub-homeworks/14.3# kubectl apply -f nginx-config.yml
configmap/nginx-config created
```
## Задача 2 (*): Работа с картами конфигураций внутри модуля

Выбрать любимый образ контейнера, подключить карты конфигураций и проверить
их доступность как в виде переменных окружения, так и в виде примонтированного
тома

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

В качестве решения прикрепите к ДЗ конфиг файлы для деплоя. Прикрепите скриншоты вывода команды kubectl со списком запущенных объектов каждого типа (pods, deployments, configmaps) или скриншот из самого Kubernetes, что сервисы подняты и работают, а также вывод из CLI.

---