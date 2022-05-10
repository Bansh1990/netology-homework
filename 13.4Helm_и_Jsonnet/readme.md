# Домашнее задание к занятию "13.4 инструменты для упрощения написания конфигурационных файлов. Helm и Jsonnet"

В работе часто приходится применять системы автоматической генерации конфигураций. Для изучения нюансов использования разных инструментов нужно попробовать упаковать приложение каждым из них.

## Задание 1: подготовить helm чарт для приложения

Необходимо упаковать приложение в чарт для деплоя в разные окружения. Требования:

* каждый компонент приложения деплоится отдельным deployment’ом/statefulset’ом;
* в переменных чарта измените образ приложения для изменения версии.

## Задание 2: запустить 2 версии в разных неймспейсах

Подготовив чарт, необходимо его проверить. Попробуйте запустить несколько копий приложения:

* одну версию в namespace=app1;
* вторую версию в том же неймспейсе;
* третью версию в namespace=app2.


```bash
bansh@bansh-VirtualBox ~/netology/netology_homework/13.4Helm_и_Jsonnet $ helm upgrade --install app1 --namespace app1 --create-namespace  test-helm
WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /home/bansh/.kube/config
WARNING: Kubernetes configuration file is world-readable. This is insecure. Location: /home/bansh/.kube/config
Release "app1" does not exist. Installing it now.
NAME: app1
LAST DEPLOYED: Tue May 10 21:00:15 2022
NAMESPACE: app1
STATUS: deployed
REVISION: 1
TEST SUITE: None
bansh@bansh-VirtualBox ~/netology/netology_homework/13.4Helm_и_Jsonnet $ helm upgrade --install app2 --namespace app1 --create-namespace  test-helm
WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /home/bansh/.kube/config
WARNING: Kubernetes configuration file is world-readable. This is insecure. Location: /home/bansh/.kube/config
Release "app2" does not exist. Installing it now.
NAME: app2
LAST DEPLOYED: Tue May 10 21:00:24 2022
NAMESPACE: app1
STATUS: deployed
REVISION: 1
TEST SUITE: None
bansh@bansh-VirtualBox ~/netology/netology_homework/13.4Helm_и_Jsonnet $ helm upgrade --install app3 --namespace app2 --create-namespace  test-helm
WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /home/bansh/.kube/config
WARNING: Kubernetes configuration file is world-readable. This is insecure. Location: /home/bansh/.kube/config
Release "app3" does not exist. Installing it now.
NAME: app3
LAST DEPLOYED: Tue May 10 21:00:34 2022
NAMESPACE: app2
STATUS: deployed
REVISION: 1
TEST SUITE: None
bansh@bansh-VirtualBox ~/netology/netology_homework/13.4Helm_и_Jsonnet $ kubectl get po --namespace app1
NAME                             READY   STATUS    RESTARTS   AGE
backend-app1-68d65dbcd6-j7pt7    1/1     Running   0          29s
backend-app2-68d65dbcd6-6s8cx    1/1     Running   0          20s
frontend-app1-6bb8d4778c-kfrq4   1/1     Running   0          28s
frontend-app2-6bb8d4778c-xkwbw   1/1     Running   0          20s
bansh@bansh-VirtualBox ~/netology/netology_homework/13.4Helm_и_Jsonnet $ kubectl get po --namespace app2
NAME                             READY   STATUS    RESTARTS   AGE
backend-app3-68d65dbcd6-9mpnl    1/1     Running   0          13s
frontend-app3-6bb8d4778c-5nl2c   1/1     Running   0          13s

```
## Задание 3 (*): повторить упаковку на jsonnet

Для изучения другого инструмента стоит попробовать повторить опыт упаковки из задания 1, только теперь с помощью инструмента jsonnet.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
