#!/bin/bash
set -e

# ============================================
# Script de Inicialización del Nodo Primario
# ============================================

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔧 Configurando nodo PRIMARIO para replicación..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Esperar a que PostgreSQL esté completamente iniciado
until pg_isready -U "$POSTGRES_USER"; do
  echo "⏳ Esperando a que PostgreSQL esté listo..."
  sleep 2
done

echo "✅ PostgreSQL está listo"
echo ""

# ============================================
# Crear usuario de replicación
# ============================================
echo "📋 Creando usuario de replicación..."

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    -- Crear usuario de replicación si no existe
    DO \$\$
    BEGIN
        IF NOT EXISTS (
            SELECT FROM pg_catalog.pg_roles WHERE rolname = '${REPLICATION_USER}'
        ) THEN
            CREATE ROLE ${REPLICATION_USER} WITH
                REPLICATION
                LOGIN
                PASSWORD '${REPLICATION_PASSWORD}';
            RAISE NOTICE 'Usuario de replicación creado: ${REPLICATION_USER}';
        ELSE
            RAISE NOTICE 'Usuario de replicación ya existe: ${REPLICATION_USER}';
        END IF;
    END
    \$\$;

    -- Crear slot de replicación físico
    SELECT pg_create_physical_replication_slot('replica_slot');

    -- Mostrar slots creados
    SELECT slot_name, slot_type, active, restart_lsn
    FROM pg_replication_slots;
EOSQL

echo "✅ Usuario de replicación configurado"
echo ""

# ============================================
# Crear base de datos de prueba
# ============================================
echo "📋 Creando base de datos de prueba..."

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    -- Crear tabla de prueba para demostrar replicación
    CREATE TABLE IF NOT EXISTS test_replication (
        id SERIAL PRIMARY KEY,
        data TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

    -- Crear índice
    CREATE INDEX IF NOT EXISTS idx_test_replication_created
    ON test_replication(created_at DESC);

    -- Insertar datos iniciales
    INSERT INTO test_replication (data) VALUES
        ('Dato inicial 1 - desde primario'),
        ('Dato inicial 2 - desde primario'),
        ('Dato inicial 3 - desde primario'),
        ('Dato inicial 4 - desde primario'),
        ('Dato inicial 5 - desde primario');

    -- Grant permisos al usuario de replicación
    GRANT SELECT ON ALL TABLES IN SCHEMA public TO ${REPLICATION_USER};
    GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO ${REPLICATION_USER};

    -- Crear función para actualizar updated_at
    CREATE OR REPLACE FUNCTION update_updated_at_column()
    RETURNS TRIGGER AS \$\$
    BEGIN
        NEW.updated_at = NOW();
        RETURN NEW;
    END;
    \$\$ language 'plpgsql';

    -- Crear trigger
    DROP TRIGGER IF EXISTS update_test_replication_updated_at ON test_replication;
    CREATE TRIGGER update_test_replication_updated_at
        BEFORE UPDATE ON test_replication
        FOR EACH ROW
        EXECUTE FUNCTION update_updated_at_column();

    -- Mostrar datos insertados
    SELECT COUNT(*) as total_registros FROM test_replication;
EOSQL

echo "✅ Base de datos de prueba creada"
echo ""

# ============================================
# Configurar pg_hba.conf para permitir replicación
# ============================================
echo "📋 Configurando pg_hba.conf para replicación..."

cat >>"$PGDATA/pg_hba.conf" <<EOF

# ============================================
# Configuración de Replicación
# Agregado automáticamente por init-primary.sh
# ============================================

# Permitir conexiones de replicación desde la réplica
host    replication     ${REPLICATION_USER}     postgres-replica        scram-sha-256
host    replication     ${REPLICATION_USER}     172.16.0.0/12           scram-sha-256
host    replication     ${REPLICATION_USER}     0.0.0.0/0               scram-sha-256

# Permitir conexiones normales desde cualquier host
host    all             all                     0.0.0.0/0               scram-sha-256
host    all             all                     ::/0                    scram-sha-256
EOF

echo "✅ pg_hba.conf configurado"
echo ""

# ============================================
# Recargar configuración
# ============================================
echo "📋 Recargando configuración de PostgreSQL..."

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "SELECT pg_reload_conf();"

echo "✅ Configuración recargada"
echo ""

# ============================================
# Verificación final
# ============================================
echo "📋 Verificando configuración..."

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    -- Verificar configuración de WAL
    SHOW wal_level;
    SHOW max_wal_senders;
    SHOW max_replication_slots;
    SHOW hot_standby;

    -- Verificar usuario de replicación
    SELECT rolname, rolreplication FROM pg_roles WHERE rolname = '${REPLICATION_USER}';

    -- Verificar slot de replicación
    SELECT slot_name, slot_type, active FROM pg_replication_slots;
EOSQL

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Nodo PRIMARIO configurado exitosamente"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
