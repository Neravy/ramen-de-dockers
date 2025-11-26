FROM postgres:18.1

# Variables de entorno por defecto
ENV POSTGRES_DB=sys_gen_contracts
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres

# Copiar scripts de inicialización
COPY 00-init/ /docker-entrypoint-initdb.d/

COPY 06-backups/dump-sys_gen_contracts-202511232021.sql /docker-entrypoint-initdb.d/01-restore-backup.sql

# Health check
HEALTHCHECK --interval=10s --timeout=5s --start-period=5s --retries=3 \
  CMD pg_isready -U postgres -d sys_gen_contracts || exit 1

EXPOSE 5432
