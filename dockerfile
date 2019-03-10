FROM centos:7
#time to install httpd
RUN yum install httpd php -y
#copying index.php page to document root
COPY index.php /var/www/html/
COPY httpd.conf /etc/httpd/conf/
#exposing a port number
EXPOSE 8080

#starting service
ENTRYPOINT httpd -DFOREGROUND
