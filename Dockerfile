FROM dorowu/ubuntu-desktop-lxde-vnc:latest

# Fix missing public key issue
RUN apt-get update --allow-releaseinfo-change && apt-get install -y gnupg2 \
    && mkdir -p /etc/apt/keyrings \
    && wget -qO- https://dl.google.com/linux/linux_signing_key.pub | tee /etc/apt/keyrings/google-linux-signing-key.pub \
    | apt-key add - 

# Install dependencies
RUN apt-get update && apt-get install -y \
    pulseaudio \
    wget \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Download and set wallpaper
RUN wget -O /usr/share/lxde/wallpaper.jpg "https://c4.wallpaperflare.com/wallpaper/702/677/218/anime-anime-girls-sword-red-fan-art-hd-wallpaper-preview.jpg" \
    && echo 'pcmanfm --set-wallpaper=/usr/share/lxde/wallpaper.jpg' >> /etc/xdg/lxsession/LXDE/autostart

# Expose VNC port
EXPOSE 8080

# Start the VNC server
CMD ["/startup.sh"]
