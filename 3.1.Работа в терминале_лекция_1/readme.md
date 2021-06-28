# Домашнее задание к занятию "3.1. Работа в терминале, лекция 1"

5. 2 ядра, 1 ГБ ОЗУ, 4мб видеопамяти, 64 гб ЖД
6.  в файле vargrant добавить строчки
```shell
Vagrant.configure("2") do |config|
        config.vm.box = "bento/ubuntu-20.04"
        config.vm.provider "virtualbox" do |v|
               v.memory = 2048
               v.cpus = 4
        end
 end
```    
8. а) HISTSIZE 851 строчка
   
    б) команды выполненные с пробелом или повторяющиеся команды в историю записаны не будут
   
9. используется для списка. 256 строчка
10. ````shell
    touch test_{1..100000}.txt
    -bash: /usr/bin/touch: Argument list too long
    ````
80000 еще создает а 90к и более уже не хочет. слишком длинный список аргументов для тач

11. проверяет существование папки /tmp

12. ````shell
    vagrant@vagrant:~$ cp /bin/bash /tmp/new_path_directory/
    vagrant@vagrant:~$ export PATH=/tmp/new_path_directory:$PATH
    vagrant@vagrant:~$ sudo cp /bin/bash /usr/local/bin/
    vagrant@vagrant:~$ type -a bash
    bash is /tmp/new_path_directory/bash
    bash is /usr/local/bin/bash
    bash is /usr/bin/bash
    bash is /bin/bash
    ````
    
13. at выполняет команду в заданное время
    batch выполняется в зависимости от заданного времени и загрузки процессора
    
