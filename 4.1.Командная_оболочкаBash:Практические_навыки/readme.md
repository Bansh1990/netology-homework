# 4.1. Командная оболочка Bash: Практические навыки

1. ```shell
    a=1
    b=2
    c=a+b         #значение с будет равно строке "a+b" (не указано что складываются значения переменных)
    d=$a+$b       #значение d будет равно строке "1+2" (по умолчанию в переменные считаются строками)
    e=$(($a+$b))  #значение e будет равно числу 3 (скобки говорят о том что нужно воспринимать значения перемекнных как целые числа)
    ```
2. пропущена закрывающая скобка`)` и не было операторы выхода из цикла `break`
    
    конечный итог будет выглядеть так:
    ```shell
        while ((1==1))
        do
                curl https://localhost:4757
                if (($? != 0))
                        then
                                date >> curl.log
                        else
                                break
                fi
        done
    ```
3. ```shell
   #!/bin/bash
   array_ip=(192.168.0.1 173.194.222.113 87.250.250.242)
     for ip in ${array_ip[@]}
     do
         errors_count=0
         for i in {1..5}
         do
             curl ${ip}:80 -m 3
             errors_count=$(( $? + $errors_count ))
         done
       if (( $errors_count != 0 ))
         then
           echo "`date` сервис ${ip} недоступен" >> log.log
         else
           echo "`date` сервис ${ip} доступен" >> log.log
       fi
     done
   ```
   
4. ```shell
   #!/bin/bash
   array_ip=(192.168.0.1 173.194.222.113 87.250.250.242)
   while ((1==1))
     do
     for ip in ${array_ip[@]}
     do
         errors_count=0
         for i in {1..5}
         do
             curl ${ip}:80 -m 3 2>/dev/null 1>/dev/null
             errors_count=$(( $? + $errors_count ))
         done
       if (( $errors_count != 0 ))
         then
           echo "`date` сервис ${ip} недоступен" >> log.log
           break 2
       fi
   
     done
     done
     ```