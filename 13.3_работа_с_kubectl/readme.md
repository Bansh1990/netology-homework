# Домашнее задание к занятию "13.3 работа с kubectl"

## Задание 1: проверить работоспособность каждого компонента

Для проверки работы можно использовать 2 способа: port-forward и exec. Используя оба способа, проверьте каждый компонент:

* сделайте запросы к бекенду;
* сделайте запросы к фронту;
* подключитесь к базе данных.

```bash
bansh@bansh-VirtualBox ~/netology/netology_homework/13.3_работа_с_kubectl $ kubectl get pods -o wide
NAME                       READY   STATUS    RESTARTS   AGE   IP            NODE        NOMINATED NODE   READINESS GATES
backend-86c57d7f4f-8cfzd   1/1     Running   0          64s   10.42.2.55    k3s-test3   <none>           <none>
frontend-76ff98f55-cl97m   1/1     Running   0          59s   10.42.0.154   k3s-test    <none>           <none>
mysql-0                    1/1     Running   0          51s   10.42.1.52    k3s-test2   <none>           <none>

bansh@bansh-VirtualBox ~/netology/netology_homework/13.3_работа_с_kubectl $ kubectl exec backend-86c57d7f4f-8cfzd -- curl localhost
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   612  100   612    0     0   5563      0 --:--:-- --:--:-- --:--:--  5563
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>




bansh@bansh-VirtualBox ~/netology/netology_homework/13.3_работа_с_kubectl $ kubectl exec frontend-76ff98f55-cl97m -- curl localhost
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   612  100   612    0     0   119k      0 --:--:-- --:--:-- --:--:--  119k
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>


bansh@bansh-VirtualBox ~/netology/netology_homework/13.3_работа_с_kubectl $ kubectl -ti exec mysql-0 -- mysql -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 10
Server version: 8.0.29 MySQL Community Server - GPL

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.00 sec)

mysql> 



bansh@bansh-VirtualBox ~/netology/netology_homework/13.3_работа_с_kubectl $ kubectl port-forward --address localhost pods/backend-86c57d7f4f-8cfzd 8080:80
Forwarding from 127.0.0.1:8080 -> 80
Forwarding from [::1]:8080 -> 80
Handling connection for 8080

bansh@bansh-VirtualBox ~/netology/netology_homework $ curl localhost:8080
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
.........
<p><em>Thank you for using nginx.</em></p>
</body>
</html>



bansh@bansh-VirtualBox ~/netology/netology_homework/13.3_работа_с_kubectl $ kubectl port-forward --address localhost mysql-0 3306:3306
Forwarding from 127.0.0.1:3306 -> 3306
Forwarding from [::1]:3306 -> 3306
Handling connection for 3306



bansh@bansh-VirtualBox ~/netology/netology_homework $ mysql -uroot -p -h 127.0.0.1
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 11
Server version: 8.0.29 MySQL Community Server - GPL

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> 


bansh@bansh-VirtualBox ~/netology/netology_homework/13.3_работа_с_kubectl $ kubectl port-forward --address localhost pods/frontend-76ff98f55-cl97m 9090:80
Forwarding from 127.0.0.1:9090 -> 80
Forwarding from [::1]:9090 -> 80


bansh@bansh-VirtualBox ~/netology/netology_homework $ curl localhost:9090
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
............
</body>
</html>

```

## Задание 2: ручное масштабирование

При работе с приложением иногда может потребоваться вручную добавить пару копий. Используя команду kubectl scale, попробуйте увеличить количество бекенда и фронта до 3. Проверьте, на каких нодах оказались копии после каждого действия (kubectl describe, kubectl get pods -o wide). После уменьшите количество копий до 1.

```bash
bansh@bansh-VirtualBox ~/netology/netology_homework/13.3_работа_с_kubectl $ kubectl get pods -o wide
NAME                       READY   STATUS    RESTARTS   AGE   IP            NODE        NOMINATED NODE   READINESS GATES
backend-86c57d7f4f-8cfzd   1/1     Running   0          14m   10.42.2.55    k3s-test3   <none>           <none>
frontend-76ff98f55-cl97m   1/1     Running   0          14m   10.42.0.154   k3s-test    <none>           <none>
mysql-0                    1/1     Running   0          14m   10.42.1.52    k3s-test2   <none>           <none>


bansh@bansh-VirtualBox ~/netology/netology_homework/13.3_работа_с_kubectl $ kubectl scale deployment backend frontend --replicas=3
deployment.apps/backend scaled
deployment.apps/frontend scaled


bansh@bansh-VirtualBox ~/netology/netology_homework/13.3_работа_с_kubectl $ kubectl get pods -o wide
NAME                       READY   STATUS    RESTARTS   AGE   IP            NODE        NOMINATED NODE   READINESS GATES
backend-86c57d7f4f-5sgjx   1/1     Running   0          44s   10.42.0.155   k3s-test    <none>           <none>
backend-86c57d7f4f-8cfzd   1/1     Running   0          16m   10.42.2.55    k3s-test3   <none>           <none>
backend-86c57d7f4f-r7zm6   1/1     Running   0          45s   10.42.1.54    k3s-test2   <none>           <none>
frontend-76ff98f55-cl97m   1/1     Running   0          16m   10.42.0.154   k3s-test    <none>           <none>
frontend-76ff98f55-cwbdw   1/1     Running   0          44s   10.42.1.53    k3s-test2   <none>           <none>
frontend-76ff98f55-t5t99   1/1     Running   0          45s   10.42.2.56    k3s-test3   <none>           <none>
mysql-0                    1/1     Running   0          16m   10.42.1.52    k3s-test2   <none>           <none>


bansh@bansh-VirtualBox ~/netology/netology_homework/13.3_работа_с_kubectl $ kubectl scale deployment backend frontend --replicas=1
deployment.apps/backend scaled
deployment.apps/frontend scaled


bansh@bansh-VirtualBox ~/netology/netology_homework/13.3_работа_с_kubectl $ kubectl get pods -o wide
NAME                       READY   STATUS    RESTARTS   AGE   IP            NODE        NOMINATED NODE   READINESS GATES
backend-86c57d7f4f-8cfzd   1/1     Running   0          16m   10.42.2.55    k3s-test3   <none>           <none>
frontend-76ff98f55-cl97m   1/1     Running   0          16m   10.42.0.154   k3s-test    <none>           <none>
mysql-0                    1/1     Running   0          16m   10.42.1.52    k3s-test2   <none>           <none>
---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
