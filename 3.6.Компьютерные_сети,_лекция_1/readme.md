# 3.6. Компьютерные сети, лекция 1
1. означает что нам пришел ответ 301 код (редирект на  https )
2. первый ответ сервера 307
* Дольше всего обрабатывался запрос https://stackoverflow.com
* ![1](3.6.Компьютерные_сети,_лекция_1/screenshot/1.png)
* ![2](3.6.Компьютерные_сети,_лекция_1/screenshot/2.png)

3. `87.117.62.43`
4. origin:         AS12389

    descr:          OJSC Rostelecom Macroregional Branch South
5. ````shell
   traceroute -A 8.8.8.8 | cut -d" " -f6
   hops
   [*]
   [AS44775]
   [AS15774/AS44775]
   [AS15774/AS44775]
   [AS44775]
   [AS20485]
   [AS20485]
   [AS20485]
   [AS15169]
   ````
6. самая большая задержка 
```10. AS15169  142.251.49.24 ``` 36 мс
7. ```shell
   dig ns dns.google
   
   ; <<>> DiG 9.16.1-Ubuntu <<>> ns dns.google
   ;; global options: +cmd
   ;; Got answer:
   ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 8567
   ;; flags: qr rd ra; QUERY: 1, ANSWER: 4, AUTHORITY: 0, ADDITIONAL: 1
   
   ;; OPT PSEUDOSECTION:
   ; EDNS: version: 0, flags:; udp: 65494
   ;; QUESTION SECTION:
   ;dns.google.			IN	NS
   
   ;; ANSWER SECTION:
   dns.google.		6751	IN	NS	ns1.zdns.google.
   dns.google.		6751	IN	NS	ns2.zdns.google.
   dns.google.		6751	IN	NS	ns4.zdns.google.
   dns.google.		6751	IN	NS	ns3.zdns.google.
   
   ;; Query time: 24 msec
   ;; SERVER: 127.0.0.53#53(127.0.0.53)
   ;; WHEN: Вс авг 01 12:53:20 MSK 2021
   ;; MSG SIZE  rcvd: 116
   
   ```
   
   ```shell
   ;; ANSWER SECTION:
   dns.google.		50	IN	A	8.8.8.8
   dns.google.		50	IN	A	8.8.4.4
   
   ```
 8.  PTR
   ```shell
   ;; ANSWER SECTION:
   4.4.8.8.in-addr.arpa.	45365	IN	PTR	dns.google.
   ;; ANSWER SECTION:
   8.8.8.8.in-addr.arpa.	33008	IN	PTR	dns.google.
   ```