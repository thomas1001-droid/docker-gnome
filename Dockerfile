FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

RUN apt update && apt install -y \
    epiphany-browser \
    fluxbox \
    x11vnc \
    xvfb \
    supervisor \
    wget \
    net-tools \
    git \
    novnc \
    websockify \
    && apt clean

# Copier le fichier supervisord.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Exposer le port noVNC
EXPOSE 6080

CMD ["/usr/bin/supervisord"]
