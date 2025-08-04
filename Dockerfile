FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV WEBKIT_DISABLE_SANDBOX=1

# Création de l'utilisateur non-root
RUN useradd -ms /bin/bash browseruser

# Installation des dépendances
RUN apt update && \
    apt install -y software-properties-common && \
    add-apt-repository universe && \
    apt update && \
    apt install -y \
    epiphany-browser \
    dbus-x11 \
    fluxbox \
    x11vnc \
    xvfb \
    supervisor \
    wget \
    net-tools \
    git \
    novnc \
    websockify && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Ajout aux groupes vidéo/audio
RUN usermod -aG video,audio browseruser

# Propriétaire du home (utile si volume monté ou logs)
RUN chown -R browseruser:browseruser /home/browseruser

RUN chmod u+s /usr/bin/bwrap

# Copie du fichier supervisord
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Exposer le port noVNC
EXPOSE 6080

CMD ["/usr/bin/supervisord"]
