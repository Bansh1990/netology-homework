# Ansible EK configuring
This playbook install Elasticsearch and Kibana on ubuntu servers.

Before use:
* change ip addresses in `playbook/inventory/prod.yml`
* run ```ansible-playbook -i inventory/prod.yml  site.yml```

## This playbook use tags
* `kibana`
* `elastic`

Example: for just kibana install use command
```bash
ansible-playbook -i inventory/prod.yml  site.yml --tags=kibana
```