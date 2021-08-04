#!/usr/bin/env python3

import os
import sys

if len(sys.argv) >= 2:
    repopath=sys.argv[1]
    if repopath[-1] != "/":
        repopath=repopath+"/"
    scrypt_path="cd "+repopath
    if os.path.exists(repopath+".git"):
        bash_command = [str(scrypt_path), "git status"]
        result_os = os.popen(' && '.join(bash_command)).read()
        for result in result_os.split('\n'):
            if result.find('изменено') != -1 or result.find('modified:') != -1:
                prepare_result = result.replace('\tизменено:      ', '').replace('\tmodified:      ', '')
                print(repopath + prepare_result)
    else:
        print("в этой папке нет репозитория")

elif os.path.exists('.git'):
    scrypt_path = "cd " + os.getcwd()
    bash_command = [str(scrypt_path), "git status"]
    result_os = os.popen(' && '.join(bash_command)).read()
    for result in result_os.split('\n'):
        if result.find('изменено') != -1 or result.find('modified:') != -1:
            prepare_result = result.replace('\tизменено:      ', '').replace('\tmodified:      ', '')
            print(os.getcwd() + "/" + prepare_result)

else:
    print("ERR: Укажите путь или запустите из директории локального репозитория")


