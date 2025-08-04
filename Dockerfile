FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

RUN useradd -ms /bin/bash browseruser

RUN apt update && \
    apt install -y software-properties-common && \
    add-apt-repository universe && \
    apt update && \
    apt install -y \
    epiphany-browser \
    fluxbox \
    x11vnc \
    xvfb \
    supervisor \
    wget \
    net-tools \
    git \
    novnc \
    websockify && \
    apt clean

RUN usermod -aG video,audio browseruser

# Copier le fichier supervisord.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chown -R browseruser:browseruser /home/browseruser

# Exposer le port noVNC
EXPOSE 6080

CMD ["/usr/bin/supervisord"]
