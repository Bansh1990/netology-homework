#!/usr/bin/env bash
for i in {master1,master2,master3,worker1,worker2,worker3}; do
yc compute instance create \
    --name $i \
    --zone ru-central1-a \
    --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
    --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2004-lts \
    --ssh-key ~/.ssh/id_rsa.pub \
	--create-boot-disk size=30G --cores 4 --memory 4G
	
done