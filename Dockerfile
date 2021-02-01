FROM ubuntu:bionic
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install mysql-server wget systemd nano nginx php7.2-cli php7.2-fpm php7.2-mysql php7.2-json php7.2-opcache php7.2-mbstring php7.2-xml php7.2-gd php7.2-curl php-zip unzip -y

RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN sed -i -e "s/;\?daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.2/fpm/php-fpm.conf
#COPY FILE
#COPY . /var/www/html/
RUN cd /var/www/html && wget http://wordpress.org/latest.zip && unzip latest.zip
# Nginx config
RUN rm /etc/nginx/sites-enabled/default
ADD ./wordpress.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/wordpress.conf /etc/nginx/sites-enabled/wordpress.conf
RUN nginx -t

RUN chmod -R 775 /var/www/html/ && chown -R root:www-data /var/www/html
RUN chmod -R 775 /var/www/html/* && chown -R root:www-data /var/www/html/*

RUN ln -s /var/lib/mysql/mysql.sock /tmp/mysql.sock
RUN service mysql restart

EXPOSE 82
# RUN PHP and NGINX
CMD service php7.2-fpm start && nginx

