#!/bin/bash

# Запуск Rust сервера
cd /rust_server
./RustDedicated \
    -batchmode \
    +server.port 28015 \
    +server.identity "my_server" \
    +server.seed 12345 \
    +server.worldsize 4000 \
    +server.maxplayers 100 \
    +server.hostname "My Rust Server" \
    +server.description "Welcome to my Rust server!" \
    +server.url "https://myrustserver.com" \
    +server.headerimage "https://myrustserver.com/logo.png" \
    +rcon.port 28016 \
    +rcon.password "your_password" \
    +server.saveinterval 600
