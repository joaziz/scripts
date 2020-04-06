
echo '#!/bin/bash

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Not running as root"
    exit
fi



clear
echo ""
echo "#################################################"
echo "#################################################"
echo "####                                         ####"
echo "####                welcome                  ####"
echo "####          here is VHOST installer        ####"
echo "####                                         ####"
echo "####                                JOE AZIZ ####"
echo "#################################################"
echo "#################################################"
echo ""

#clear

read -p "please enter url : " url
read -p "please enter dir path : " vpath
echo ""
echo "create Vhost entry in /etc/hosts file ... "
echo ""
echo '127.0.0.1	' ${url} >> /etc/hosts;



echo "create Vhost file in /etc/apache2/sites-available/$url.conf ... "
echo ""
echo "<VirtualHost *:80>
        ServerName  $url
        DocumentRoot  $vpath
        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

        <Directory $vpath>
                 AllowOverride All
                 Require all granted
        </Directory>
</VirtualHost>"  >> /etc/apache2/sites-available/$url.conf; 




echo "enabling $url website"
echo ""
a2ensite ${url}
echo " restart apache server"
echo ""
service apache2 restart' >> /usr/local/bin/create_vhost
chmod +x  /usr/local/bin/create_vhost





echo '#!/bin/bash

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Not running as root"
    exit
fi



clear
echo ""
echo "#################################################"
echo "#################################################"
echo "####                                         ####"
echo "####                welcome                  ####"
echo "####          here is Proxy installer        ####"
echo "####                                         ####"
echo "####                                JOE AZIZ ####"
echo "#################################################"
echo "#################################################"
echo ""

#clear

read -p "please enter local url: " url
read -p "please enter proxy url  : " proxy
echo ""
echo "create proxy entry in /etc/hosts file ... "
echo ""
echo '127.0.0.1	' ${url} >> /etc/hosts;



echo "create Vhost file in /etc/apache2/sites-available/$url.proxy.conf ... "
echo ""
echo "<VirtualHost *:80>
        ServerName $url
        ProxyRequests on
        RequestHeader set Host "$url"
        ProxyPreserveHost On
        ProxyPass / $proxy/
        ProxyPassReverse / $proxy/
</VirtualHost>"  >> /etc/apache2/sites-available/$url.proxy.conf; 




echo "enabling $url website"
echo ""
a2ensite ${url}.proxy
echo " restart apache server"
echo ""
service apache2 restart' >> /usr/local/bin/create_proxy
chmod +x  /usr/local/bin/create_proxy




echo '#!/bin/bash

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Not running as root"
    exit
fi



clear
echo ""
echo "#################################################"
echo "#################################################"
echo "####                                         ####"
echo "####                welcome                  ####"
echo "####          here is Proxy installer        ####"
echo "####                                         ####"
echo "####                                JOE AZIZ ####"
echo "#################################################"
echo "#################################################"
echo ""

#clear

read -p "please enter local url: " url
read -p "please enter proxy url  : " proxy
echo ""
echo "create proxy entry in /etc/hosts file ... "
echo ""
echo '127.0.0.1	' ${url} >> /etc/hosts;



echo "create Vhost file in /etc/apache2/sites-available/$url.proxy.conf ... "
echo ""
echo "<Proxy balancer://$url>
            # Define back-end servers:

            # Server 1
                BalancerMember $proxy

      </Proxy>

      <VirtualHost *:80>
            # Apply VH settings as desired
            # However, configure ProxyPass argument to
            # use mycluster to balance the load
        
        ServerName $url

        ProxyRequests on
        RequestHeader set Host "$url"
        ProxyPreserveHost On


        ProxyPass / balancer://$url/

      </VirtualHost>"  >> /etc/apache2/sites-available/$url.proxy.conf; 




echo "enabling $url website"
echo ""
a2ensite ${url}.proxy
echo " restart apache server"
echo ""
service apache2 restart' >> /usr/local/bin/create_balancer
chmod +x  /usr/local/bin/create_balancer



