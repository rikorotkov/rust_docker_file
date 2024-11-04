FROM ubuntu:22.04

# Обновляем зеркала, обновляем систему и устанавливаем необходимые пакеты
RUN sed -i 's|archive.ubuntu.com|mirrors.edge.kernel.org|g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget curl libc6 lib32gcc-s1 lib32stdc++6 && \
    apt-get clean -y

# Устанавливаем SteamCMD для загрузки сервера Rust
RUN mkdir -p /steamcmd && \
    cd /steamcmd && \
    wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
    tar -xvzf steamcmd_linux.tar.gz && \
    rm steamcmd_linux.tar.gz

# Создаем директорию для Rust сервера
RUN mkdir -p /rust_server

# Определяем переменные для работы сервера
ENV STEAMCMD /steamcmd/steamcmd.sh
ENV RUST_SERVER_DIR /rust_server
ENV RUST_APP_ID 258550

# Загружаем Rust сервер через SteamCMD
RUN $STEAMCMD +login anonymous +force_install_dir $RUST_SERVER_DIR +app_update $RUST_APP_ID validate +quit

# Порт, на котором будет работать сервер Rust
EXPOSE 28015/udp 28016/udp

# Копируем скрипт запуска в контейнер
COPY start_rust.sh /start_rust.sh
RUN chmod +x /start_rust.sh

# Указываем команду для запуска сервера
CMD ["/start_rust.sh"]
