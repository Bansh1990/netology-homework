#!/bin/bash
array_ip=(localhost 173.194.222.113 87.250.250.242)
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
  echo "===============================" >> log.log