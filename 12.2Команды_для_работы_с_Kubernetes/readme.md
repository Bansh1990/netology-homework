# Домашнее задание к занятию "12.2 Команды для работы с Kubernetes"
Кластер — это сложная система, с которой крайне редко работает один человек. Квалифицированный devops умеет наладить работу всей команды, занимающейся каким-либо сервисом.
После знакомства с кластером вас попросили выдать доступ нескольким разработчикам. Помимо этого требуется служебный аккаунт для просмотра логов.

## Задание 1: Запуск пода из образа в деплойменте
Для начала следует разобраться с прямым запуском приложений из консоли. Такой подход поможет быстро развернуть инструменты отладки в кластере. Требуется запустить деплоймент на основе образа из hello world уже через deployment. Сразу стоит запустить 2 копии приложения (replicas=2). 



Требования:
 * пример из hello world запущен в качестве deployment
 * количество реплик в deployment установлено в 2
 * наличие deployment можно проверить командой kubectl get deployment
 * наличие подов можно проверить командой kubectl get pods

```bash
bansh@k3s-server:~$ kubectl get pods,deploy -n readonly
NAME                         READY   STATUS    RESTARTS   AGE
pod/nginx-7c658794b9-7s2r7   1/1     Running   0          59s
pod/nginx-7c658794b9-qk72w   1/1     Running   0          59s

NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx   2/2     2            2           59s
```

## Задание 2: Просмотр логов для разработки
Разработчикам крайне важно получать обратную связь от штатно работающего приложения и, еще важнее, об ошибках в его работе. 
Требуется создать пользователя и выдать ему доступ на чтение конфигурации и логов подов в app-namespace.

Требования: 
 * создан новый токен доступа для пользователя
 * пользователь прописан в локальный конфиг (~/.kube/config, блок users)
 * пользователь может просматривать логи подов и их конфигурацию (kubectl logs pod <pod_id>, kubectl describe pod <pod_id>)

```bash
#!/usr/bin/env bash
mkdir ~/.minikube/profiles/readonly
cd ~/.minikube/profiles/readonly
openssl genrsa -out readonly.key 2048
openssl req -new -key readonly.key -out readonly.csr -subj "/CN=readonly/O=readonlys"
openssl x509 -req -in readonly.csr -CA ~/.minikube/ca.rt -CAkey ~/.minikube/ca.key -CAcreateserial -out readonly.crt -days 500
kubectl config set-credentials readonly --client-certificate=readonly.crt --client-key=readonly.key
kubectl config set-context readonly-context --cluster=minikube --user=readonly
kubectl config view
kubectl apply -f readonly.yml
kubectl config use-context readonly-context
```



```bash
bansh@k3s-server:~/.minikube/profiles/readonly$ kubectl config use-context readonly-context
Switched to context "readonly-context".
bansh@k3s-server:~/.minikube/profiles/readonly$ kubectl get pods
Error from server (Forbidden): pods is forbidden: User "readonly" cannot list resource "pods" in API group "" in the namespace "default"
bansh@k3s-server:~/.minikube/profiles/readonly$ kubectl get pods -n readonly
NAME                     READY   STATUS    RESTARTS   AGE
nginx-7c658794b9-7s2r7   1/1     Running   0          27m
nginx-7c658794b9-qk72w   1/1     Running   0          27m
bansh@k3s-server:~/.minikube/profiles/readonly$ kubectl logs -n readonly nginx-7c658794b9-7s2r7
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/03/27 09:34:00 [notice] 1#1: using the "epoll" event method
2022/03/27 09:34:00 [notice] 1#1: nginx/1.21.6
2022/03/27 09:34:00 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6)
2022/03/27 09:34:00 [notice] 1#1: OS: Linux 5.4.0-96-generic
2022/03/27 09:34:00 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/03/27 09:34:00 [notice] 1#1: start worker processes
2022/03/27 09:34:00 [notice] 1#1: start worker process 31
2022/03/27 09:34:00 [notice] 1#1: start worker process 32
2022/03/27 09:34:00 [notice] 1#1: start worker process 33
2022/03/27 09:34:00 [notice] 1#1: start worker process 34
bansh@k3s-server:~/.minikube/profiles/readonly$ kubectl logs  nginx-7c658794b9-7s2r7
Error from server (Forbidden): pods "nginx-7c658794b9-7s2r7" is forbidden: User "readonly" cannot get resource "pods" in API group "" in the namespace "default"
```
## Задание 3: Изменение количества реплик 
Поработав с приложением, вы получили запрос на увеличение количества реплик приложения для нагрузки. Необходимо изменить запущенный deployment, увеличив количество реплик до 5. Посмотрите статус запущенных подов после увеличения реплик. 

Требования:
 * в deployment из задания 1 изменено количество реплик на 5
 * проверить что все поды перешли в статус running (kubectl get pods)

---
```bash
bansh@k3s-server:~/.minikube/profiles/readonly$ kubectl edit -n readonly deployments.apps nginx
###меняем replicas на 5 :wq
deployment.apps/nginx edited
bansh@k3s-server:~/.minikube/profiles/readonly$ kubectl get pods -n readonly
NAME                     READY   STATUS    RESTARTS   AGE
nginx-7c658794b9-7s2r7   1/1     Running   0          31m
nginx-7c658794b9-bg85x   1/1     Running   0          23s
nginx-7c658794b9-l4drb   1/1     Running   0          23s
nginx-7c658794b9-nxzww   1/1     Running   0          23s
nginx-7c658794b9-qk72w   1/1     Running   0          31m
```
### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---