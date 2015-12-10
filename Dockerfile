# Bazinis atvaizdas (Linux Debian versija Jessie).
FROM debian:jessie

# Kas atsakingas už konteinerio prieziura.
MAINTAINER "Vardenis Pavardenis" <meilas@gmail.com>

# Sudiegiame Nginx.
RUN apt-get update -y && apt-get install -y nginx

# Pridedame Nginx konfiguracijos faila i konteineri.
ADD config/laravel /etc/nginx/sites-available/laravel

# Ijungiame vhosto konfiguracija.
RUN ln -s /etc/nginx/sites-available/laravel /etc/nginx/sites-enabled/laravel && \
    rm /etc/nginx/sites-enabled/default

# Sukuriame nginx vhost'o direktorija.
RUN mkdir /data
RUN mkdir /data/www

# Paruosiame vietas failines sistemos prijungimui.
VOLUME ["/var/log", "/data"]
# /var/log - prijungsime log'u direktorija, kad galetume patogiai stebeti ka veikia serveris ir jo servisai.
# /data - nginx virtualaus host'o direktorija

# Paruosiame nginx, kad veiktu foreground'e (konteineris nesustos, vos tik paleidus nginx).
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Atveriame portus isorei.
EXPOSE 80

# Nustatome darbine direktorija.
WORKDIR /etc/nginx

# Pleidzime nginx.
ENTRYPOINT ["nginx"]
