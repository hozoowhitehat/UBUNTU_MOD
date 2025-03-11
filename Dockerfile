FROM dorowu/ubuntu-desktop-lxde-vnc:latest

# Update package list dan tambahkan public key yang hilang
RUN apt-get update --allow-releaseinfo-change && apt-get install -y \
    wget gnupg2 software-properties-common 

# Jika repository Google Chrome tidak dibutuhkan, bisa dinonaktifkan
RUN rm -f /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update

# Install pulseaudio untuk dukungan suara
RUN apt-get install -y pulseaudio \
    && rm -rf /var/lib/apt/lists/*

# Download wallpaper
RUN wget -O /usr/share/lxde/wallpaper.jpg "https://c4.wallpaperflare.com/wallpaper/702/677/218/anime-anime-girls-sword-red-fan-art-hd-wallpaper-preview.jpg"

# Set wallpaper saat startup
RUN echo 'pcmanfm --set-wallpaper=/usr/share/lxde/wallpaper.jpg' >> /etc/xdg/lxsession/LXDE/autostart

# Expose port noVNC
EXPOSE 8080

# Start the VNC server
CMD ["/startup.sh"]
