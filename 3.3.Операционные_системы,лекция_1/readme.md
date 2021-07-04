# 3.3. Операционные системы, лекция 1

1. ```shell
    chdir("/tmp")                           = 0
    ```
2. ```shell
    openat(AT_FDCWD, "/etc/magic", O_RDONLY) = 3
    openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3
    ```
3. ```shell
   cat /dev/null > /proc/<PID>/fd/{$file}
   ```
4. Зомби не занимают памяти, но блокируют записи в таблице процессов, количество которых ограничено.
5. ```shell
    vagrant@vagrant:~$ sudo opensnoop-bpfcc
    PID    COMM               FD ERR PATH
    810    vminfo              4   0 /var/run/utmp
    610    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
    610    dbus-daemon        18   0 /usr/share/dbus-1/system-services
    610    dbus-daemon        -1   2 /lib/dbus-1/system-services
    610    dbus-daemon        18   0 /var/lib/snapd/dbus-1/system-services/
    810    vminfo              4   0 /var/run/utmp
    610    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
    610    dbus-daemon        18   0 /usr/share/dbus-1/system-services
    610    dbus-daemon        -1   2 /lib/dbus-1/system-services
    610    dbus-daemon        18   0 /var/lib/snapd/dbus-1/system-services/
    ```
6. не получилось разобоаться

7.  * с ``;`` команды выполняются последовательно вне зависимости от кодов выхода предыдущей
    * с ``&&`` каждая последующая команда выполняется если у предыдущей код выхода 0
    * нет смысла. функционал дублируется
    
8. ``-e`` - прерывает скрипт если хоть одна команда завершилась ошибкой 
   
    ``-u`` - пустые переменные считать ошибкой
   
   ``-x`` - выводит команды перед выполннением
   
   ``-o pipefail`` - предотвращает маскировку ошибок в скрипте. если какая-либо команда в скрипте фэйлится, ее код завершения
   будет использоваться как код завершения скрипта.
   
9. ```shell
    root@vagrant:/home/vagrant# ps ax  -o stat | cut -c1 | sort -h | uniq -c | sort -h
      1 R
      1 T
     56 I
     72 S
    ```