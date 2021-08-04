#!/usr/bin/env python3
import socket
import time
import sys
our_services = {}
for i in sys.argv[1:]:
    serv_ip = socket.gethostbyname(i)
    our_services.update({i: serv_ip})
while 1:
    for i in our_services:
        if our_services[i] != socket.gethostbyname(i):
            print(f'[ERROR] {i} IP mismatch: {our_services[i]} {socket.gethostbyname(i)}')
            serv_ip = socket.gethostbyname(i)
            new_ip = {i: serv_ip}
            our_services.update(new_ip)
        else:
            print(f'{i}: {our_services[i]}')
        time.sleep(1)





