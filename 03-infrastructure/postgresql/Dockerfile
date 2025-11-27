FROM postgres:18.1

# pglogical para multi-master
RUN apt-get update && apt-get install -y \
    postgresql-18-pglogical \
    && rm -rf /var/lib/apt/lists/*

ENV POSTGRES_DB=sys_gen_contracts
ENV POSTGRES_USER=postgres

# Tu backup
COPY 06-backups/dump-sys_gen_contracts-202511232021.sql \
  /docker-entrypoint-initdb.d/01-restore.sql

EXPOSE 5432
