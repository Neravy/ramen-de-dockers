#!/bin/bash
set -e

# ============================================
# Script de Configuración de la Réplica
# ============================================

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}🔄 Configurando réplica desde cero...${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# Variables
REPLICATION_USER="${REPLICATION_USER:-replicator}"
REPLICATION_PASSWORD="${REPLICATION_PASSWORD:-replicator_pass}"

# ============================================
# PASO 1: Eliminar slot si existe
# ============================================
echo ""
echo -e "${CYAN}📋 Paso 1/7: Verificando y limpiando slots de replicación anteriores...${NC}"

docker exec postgres-primary psql -U postgres -c \
  "SELECT pg_drop_replication_slot('replica_slot');" 2>/dev/null &&
  echo -e "${GREEN}✅ Slot anterior eliminado${NC}" ||
  echo -e "${YELLOW}ℹ️  No hay slots previos (esto es normal)${NC}"

# ============================================
# PASO 2: Detener réplica
# ============================================
echo ""
echo -e "${CYAN}📋 Paso 2/7: Deteniendo contenedor de réplica...${NC}"

docker stop postgres-replica 2>/dev/null || echo -e "${YELLOW}ℹ️  Réplica no estaba corriendo${NC}"

echo -e "${GREEN}✅ Réplica detenida${NC}"

# ============================================
# PASO 3: Limpiar datos de réplica
# ============================================
echo ""
echo -e "${CYAN}📋 Paso 3/7: Limpiando datos anteriores de la réplica...${NC}"

docker run --rm -v replicacion-postgres_replica-data:/data alpine sh -c "rm -rf /data/*"

echo -e "${GREEN}✅ Datos de réplica limpiados${NC}"

# ============================================
# PASO 4: Hacer basebackup
# ============================================
echo ""
echo -e "${CYAN}📋 Paso 4/7: Realizando pg_basebackup desde el primario...${NC}"
echo -e "${YELLOW}⏳ Este proceso puede tardar algunos minutos...${NC}"
echo ""

docker run --rm \
  --network replicacion-postgres_postgres-network \
  -v replicacion-postgres_replica-data:/backup \
  -e PGPASSWORD="$REPLICATION_PASSWORD" \
  postgres:16-alpine \
  pg_basebackup \
  -h postgres-primary \
  -D /backup \
  -U $REPLICATION_USER \
  -v \
  -P \
  -R \
  -X stream \
  -C -S replica_slot

echo ""
echo -e "${GREEN}✅ Backup base completado${NC}"

# ============================================
# PASO 5: Configurar standby mode
# ============================================
echo ""
echo -e "${CYAN}📋 Paso 5/7: Configurando modo standby...${NC}"

# Asegurar que existe standby.signal
docker run --rm -v replicacion-postgres_replica-data:/data alpine touch /data/standby.signal

echo -e "${GREEN}✅ Archivo standby.signal creado${NC}"

# ============================================
# PASO 6: Verificar configuración
# ============================================
echo ""
echo -e "${CYAN}📋 Paso 6/7: Verificando configuración de conexión...${NC}"
echo ""

echo -e "${YELLOW}Contenido de postgresql.auto.conf:${NC}"
docker run --rm -v replicacion-postgres_replica-data:/data alpine cat /data/postgresql.auto.conf

echo ""
echo -e "${GREEN}✅ Configuración verificada${NC}"

# ============================================
# PASO 7: Iniciar réplica
# ============================================
echo ""
echo -e "${CYAN}📋 Paso 7/7: Iniciando contenedor de réplica...${NC}"

docker start postgres-replica

echo -e "${GREEN}✅ Contenedor iniciado${NC}"

# ============================================
# Esperar a que la réplica esté lista
# ============================================
echo ""
echo -e "${YELLOW}⏳ Esperando a que la réplica esté lista...${NC}"

echo -n "Verificando disponibilidad"
for i in {1..30}; do
  if docker exec postgres-replica pg_isready -U postgres >/dev/null 2>&1; then
    echo ""
    echo -e "${GREEN}✅ Réplica está lista y aceptando conexiones${NC}"
    break
  fi
  echo -n "."
  sleep 1
done
echo ""

# ============================================
# Verificar conexión de replicación
# ============================================
echo ""
echo -e "${CYAN}📋 Verificando conexión de replicación...${NC}"
echo ""

echo -e "${YELLOW}Estado de replicación en el primario:${NC}"
docker exec postgres-primary psql -U postgres -x -c \
  "SELECT application_name, client_addr, state, sync_state FROM pg_stat_replication;" ||
  echo -e "${RED}❌ No se pudo verificar el estado${NC}"

echo ""
echo -e "${YELLOW}Estado de recovery en la réplica:${NC}"
docker exec postgres-replica psql -U postgres -c \
  "SELECT pg_is_in_recovery();" ||
  echo -e "${RED}❌ No se pudo verificar el estado${NC}"

# ============================================
# Resumen final
# ============================================
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ Configuración de réplica completada${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${CYAN}💡 Usa 'make verify' para verificar el estado de replicación${NC}"
echo -e "${CYAN}💡 Usa 'make test' para probar la replicación insertando datos${NC}"
echo ""
