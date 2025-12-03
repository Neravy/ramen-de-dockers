#!/bin/bash

set -e

echo "=== Instalación de PostgreSQL 16 + pglogical en Ubuntu 24.04 ==="

# Update sistema
sudo apt update
sudo apt upgrade -y

# Instalar herramientas necesarias
sudo apt install -y \
    curl \
    wget \
    git \
    vim \
    net-tools \
    openssh-server \
    openssh-client \
    ufw \
    htop \
    iotop \
    gnupg2 \
    lsb-release

# Agregar repositorio oficial PostgreSQL
sudo curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" | \
    sudo tee /etc/apt/sources.list.d/pgdg.list

sudo apt update

# Instalar PostgreSQL 16
sudo apt install -y postgresql-16 postgresql-contrib-16 postgresql-16-pglogical

# Instalar pglogical extension
sudo apt install -y postgresql-16-pglogical

# Iniciar PostgreSQL
sudo systemctl enable postgresql
sudo systemctl start postgresql

# Verificar instalación
sudo -u postgres psql --version

echo "✅ Instalación completada"
