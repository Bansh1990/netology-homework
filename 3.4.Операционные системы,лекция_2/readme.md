# 3.4. Операционные системы, лекция 2
1. ```bash
    root@vagrant:/home/vagrant# systemctl edit node_exporter --full
    [Unit]
    Description=node_exporter
    After=remote-fs.target nss-user-lookup.target

    [Service]
    EnvironmentFile=-/etc/node_exporter.conf
    ExecStart=/usr/bin/node_exporter $EXTRA_OPTS
    Restart=on-failure

    [Install]
    WantedBy=multi-user.target
    ```
    ```bash
    echo "EXTRA_OPTS=' --web.listen-address=\":9100\"'" > /etc/node_exporter.conf
    service node_exporter start
    systemctl enable node_exporter
    ```
   после ребута поднимается
2.  *  node_filesystem
     *  node_netstat
     *  node_cpu
     *  node_disk
     *  node_memory
     *  node_network
    * process_*
    
3. done

_ps: O_o сразу же установил на парочке машин на работе._ 

4. можно 
    ```bash 
    vagrant@vagrant:~$ cat /var/log/dmesg | grep virtual
    [    0.001184] kernel: CPU MTRRs all blank - virtualized system.
    [    0.069398] kernel: Booting paravirtualized kernel on KVM
    [    2.558002] systemd[1]: Detected virtualization oracle.
    ```
5. ```bash
   vagrant@vagrant:~$ sysctl -n fs.nr_open
    1048576
    ``` 
   это лимит на количество отрытых файлов
 но достигнуть этого числа не получится изза ограничения 
   ```shell
    vagrant@vagrant:~$ ulimit -a | grep open
    open files                      (-n) 1024
    ```
   
6.  ```bash 
    vagrant@vagrant ~> sudo unshare -f -p --mount-proc sleep 1h
    vagrant@vagrant ~> sudo ps aux | grep sleep
    root        2540  0.0  0.0   8076   592 pts/0    S    12:43   0:00 sleep 1h
    vagrant     3121  0.0  0.0   8900   732 pts/0    S+   12:48   0:00 grep --color=auto sleep
    vagrant@vagrant ~> sudo nsenter --target 2540 --pid --mount
    root@vagrant:/# ps aux
    USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
    root           1  0.0  0.0   8076   592 pts/0    S    12:43   0:00 sleep 1h
    root          13  0.0  0.1   9836  4024 pts/0    S    12:49   0:00 -bash
    root          22  0.0  0.1  11492  3308 pts/0    R+   12:49   0:00 ps aux
    ```
    
7. Прикольное название "форк-бомба") 
    помогло ограничение на количество процессов. 
   
    ```[ 5168.440384] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-3.scope```

    чтобы изменить разрешенное количество процессов добавил в ``/etc/security/limits.conf``
   
   ```vagrant         hard    nproc           500```
    
     это помогло