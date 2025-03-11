FROM dorowu/ubuntu-desktop-lxde-vnc:latest

# Install dependensi
RUN apt-get update && apt-get install -y \
    pulseaudio \
    wget \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Download wallpaper
RUN wget -O /usr/share/lxde/wallpaper.jpg "https://c4.wallpaperflare.com/wallpaper/702/677/218/anime-anime-girls-sword-red-fan-art-hd-wallpaper-preview.jpg"

# Set wallpaper
RUN echo 'pcmanfm --set-wallpaper=/usr/share/lxde/wallpaper.jpg' >> /etc/xdg/lxsession/LXDE/autostart

# Install bash (Windows 10 subsystem bash)
RUN apt-get update && apt-get install -y bash

# Expose port untuk noVNC
EXPOSE 8080

# Jalankan VNC server
CMD ["/startup.sh"]
