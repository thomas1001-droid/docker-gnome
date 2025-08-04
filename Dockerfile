FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

RUN apt update && apt install -y \
    epiphany-browser \
    dbus-x11 \
    x11vnc \
    xvfb \
    supervisor \
    fluxbox \
    wget \
    && apt clean

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 5900

CMD ["/usr/bin/supervisord"]
