# 3.9. Элементы безопасности информационных систем
1. Зарегистрировался
2. включил
3. ```sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned```
```sudo apt install apache2
sudo a2enmod ssl
nano /etc/apache2/sites-enabled/000-default.conf
<VirtualHost *:443>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html
        SSLEngine on
        SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
        SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
service apache2 restart

curl https://localhost -k

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <!--
    Modified from the Debian original for Ubuntu
    Last updated: 2016-11-16
    See: https://launchpad.net/bugs/1288690
  -->
  <head> 
  ...................
          </p>
          <p>
                Please report bugs specific to modules (such as PHP and others)
                to respective packages, not to the web server itself.
          </p>
        </div>




      </div>
    </div>
    <div class="validator">
    </div>
  </body>
</html>
```

4. ```
    git clone https://github.com/drwetter/testssl.sh.git
    cd testssl.sh
    ./testssl.sh -U --sneaky https://www.mail.ru/
    ```
   
5. ```shell
    ssh-keygen
    ssh-copy-id -i ~/.ssh/id_rsa.pub user@host
    ssh user@host
    ```
   
6. ```shell
    mv ~/.ssh/id_rsa ~/.ssh/host
    nano /etc/ssh/ssh_config
         Host host
         HostName 10.0.0.2
         IdentityFile ~/.ssh/host
         User user
    ```
   
7. ```sudo tcpdump -s 0 -i enp0s3 -w test.pcap```
    открываем в wereshark