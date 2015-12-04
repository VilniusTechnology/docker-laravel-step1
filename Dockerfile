# Bazinis img
FROM debian:jessie

# Kas atsakingas
MAINTAINER "Vardenis Pavardenis" <meilas@gmail.com>

# Sudiegiame Nginx
RUN apt-get update -y && apt-get install -y nginx

# Sukuriame Nginx configuration
ADD config/laravel /etc/nginx/sites-available/laravel
RUN ln -s /etc/nginx/sites-available/laravel /etc/nginx/sites-enabled/laravel && \
    rm /etc/nginx/sites-enabled/default

# Sukuriame nginx vhost'o direktorija
RUN mkdir /data
RUN mkdir /data/www

# Paruosiame vietas failines sistemos prijungimui
VOLUME ["/var/log", "/data"]
# /var/log - prijungsime log'u direktorija, kad galetume patogiai stebeti ka veikia serveris
# /data - nginx virtualaus host'o direktorija

# Paruosiame nginx, kad veiktu foreground'e (konteineris nesustos, vos tik paleidus nginx).
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# PORTS
EXPOSE 80
EXPOSE 443

# Define working directory.
WORKDIR /etc/nginx

# Pleidzime nginx.
ENTRYPOINT ["nginx"]
