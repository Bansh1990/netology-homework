# Домашнее задание к занятию "12.4 Развертывание кластера на собственных серверах, лекция 2"
Новые проекты пошли стабильным потоком. Каждый проект требует себе несколько кластеров: под тесты и продуктив. Делать все руками — не вариант, поэтому стоит автоматизировать подготовку новых кластеров.

## Задание 1: Подготовить инвентарь kubespray
Новые тестовые кластеры требуют типичных простых настроек. Нужно подготовить инвентарь и проверить его работу. Требования к инвентарю:
* подготовка работы кластера из 5 нод: 1 мастер и 4 рабочие ноды;
* в качестве CRI — containerd;
* запуск etcd производить на мастере.

```bash
root@master1:/home/yc-user# kubectl get nodes,pods -o wide
NAME           STATUS   ROLES                  AGE     VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION       CONTAINER-RUNTIME
node/master1   Ready    control-plane,master   9m57s   v1.23.5   10.128.0.31   <none>        Ubuntu 18.04.6 LTS   4.15.0-112-generic   containerd://1.6.1
node/master2   Ready    control-plane,master   9m27s   v1.23.5   10.128.0.11   <none>        Ubuntu 18.04.6 LTS   4.15.0-112-generic   containerd://1.6.1
node/master3   Ready    control-plane,master   9m15s   v1.23.5   10.128.0.26   <none>        Ubuntu 18.04.6 LTS   4.15.0-112-generic   containerd://1.6.1
node/worker1   Ready    <none>                 7m43s   v1.23.5   10.128.0.4    <none>        Ubuntu 18.04.6 LTS   4.15.0-112-generic   containerd://1.6.1
node/worker2   Ready    <none>                 7m44s   v1.23.5   10.128.0.7    <none>        Ubuntu 18.04.6 LTS   4.15.0-112-generic   containerd://1.6.1
node/worker3   Ready    <none>                 7m44s   v1.23.5   10.128.0.13   <none>        Ubuntu 18.04.6 LTS   4.15.0-112-generic   containerd://1.6.1

NAME                         READY   STATUS    RESTARTS   AGE   IP             NODE      NOMINATED NODE   READINESS GATES
pod/nginx-7c658794b9-54c2j   1/1     Running   0          42s   10.233.110.2   worker1   <none>           <none>
pod/nginx-7c658794b9-g658d   1/1     Running   0          42s   10.233.98.2    master2   <none>           <none>
pod/nginx-7c658794b9-k8t4r   1/1     Running   0          42s   10.233.96.3    master3   <none>           <none>
pod/nginx-7c658794b9-lwp92   1/1     Running   0          42s   10.233.103.2   worker2   <none>           <none>
pod/nginx-7c658794b9-qqbsf   1/1     Running   0          42s   10.233.116.2   worker3   <none>           <none>
```

## Задание 2 (*): подготовить и проверить инвентарь для кластера в AWS
Часть новых проектов хотят запускать на мощностях AWS. Требования похожи:
* разворачивать 5 нод: 1 мастер и 4 рабочие ноды;
* работать должны на минимально допустимых EC2 — t3.small.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---