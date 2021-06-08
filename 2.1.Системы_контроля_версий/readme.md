# Домашнее задание к занятию «2.1. Системы контроля версий.»

* добавлен в игнор .idea
* добавлен terraform и создан .gitignore

Список игнорируемых файлов
```gitignore
**/.terraform/* # все папки .terraform и все вложенное в нее
*.tfstate #все файлы с расширением .tfstate
*.tfstate.* # например .tfstate.dsfsdf
crash.log # crash.log 
*.tfvars # все файлы с расширением .tfvars
override.tf # override.tf
override.tf.json # override.tf.json
*_override.tf # например dslkfjdsljk_override.tf
*_override.tf.json # например hdjfhjkg_override.tf.json
.terraformrc # .terraformrc
terraform.rc # terraform.rc
```