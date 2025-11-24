#!/bin/bash

# ============================================
# Script de Verificación de Replicación
# ============================================

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}🔍 Verificación Completa de Replicación${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# ============================================
# Verificar que los contenedores estén corriendo
# ============================================
echo ""
echo -e "${CYAN}📊 Estado de Contenedores:${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

if docker ps --format "table {{.Names}}\t{{.Status}}" | grep -E "postgres-primary|postgres-replica"; then
  echo -e "${GREEN}✅ Contenedores en ejecución${NC}"
else
  echo -e "${RED}❌ Algunos contenedores no están corriendo${NC}"
  exit 1
fi

# ============================================
# Verificar estado de replicación en el primario
# ============================================
echo ""
echo -e "${CYAN}📊 Estado de Replicación en PRIMARIO:${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

REPLICATION_STATUS=$(docker exec postgres-primary psql -U postgres -tAc \
  "SELECT COUNT(*) FROM pg_stat_replication;")

if [ "$REPLICATION_STATUS" -gt 0 ]; then
  echo -e "${GREEN}✅ Réplica conectada al primario${NC}"
  echo ""
  docker exec postgres-primary psql -U postgres -x -c \
    "SELECT
        application_name,
        client_addr,
        client_hostname,
        state,
        sync_state,
        sent_lsn,
        write_lsn,
        flush_lsn,
        replay_lsn,
        write_lag,
        flush_lag,
        replay_lag
      FROM pg_stat_replication;"
else
  echo -e "${RED}❌ No hay réplicas conectadas${NC}"
fi

# ============================================
# Verificar slots de replicación
# ============================================
echo ""
echo -e "${CYAN}📊 Slots de Replicación:${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

docker exec postgres-primary psql -U postgres -x -c \
  "SELECT
    slot_name,
    slot_type,
    active,
    restart_lsn,
    confirmed_flush_lsn
  FROM pg_replication_slots;"

# ============================================
# Verificar que la réplica está en recovery mode
# ============================================
echo ""
echo -e "${CYAN}📊 Estado de la RÉPLICA (debe estar en recovery mode):${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

IS_RECOVERY=$(docker exec postgres-replica psql -U postgres -tAc "SELECT pg_is_in_recovery();")

if [ "$IS_RECOVERY" = "t" ]; then
  echo -e "${GREEN}✅ Réplica está en modo recovery (correcto)${NC}"
else
  echo -e "${RED}❌ Réplica NO está en modo recovery (problema)${NC}"
fi

echo ""
docker exec postgres-replica psql -U postgres -c \
  "SELECT pg_is_in_recovery() as in_recovery_mode, pg_last_wal_receive_lsn(), pg_last_wal_replay_lsn();"

# ============================================
# Comparar datos entre primario y réplica
# ============================================
echo ""
echo -e "${CYAN}📊 Comparación de Datos:${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

echo ""
echo -e "${YELLOW}Datos en PRIMARIO:${NC}"
PRIMARY_DATA=$(docker exec postgres-primary psql -U postgres -d testdb -tAc "SELECT COUNT(*) FROM test_replication;")
echo "Total de registros: $PRIMARY_DATA"
docker exec postgres-primary psql -U postgres -d testdb -c \
  "SELECT id, data, created_at FROM test_replication ORDER BY id DESC LIMIT 5;"

echo ""
echo -e "${YELLOW}Datos en RÉPLICA:${NC}"
REPLICA_DATA=$(docker exec postgres-replica psql -U postgres -d testdb -tAc "SELECT COUNT(*) FROM test_replication;")
echo "Total de registros: $REPLICA_DATA"
docker exec postgres-replica psql -U postgres -d testdb -c \
  "SELECT id, data, created_at FROM test_replication ORDER BY id DESC LIMIT 5;"

# ============================================
# Verificar sincronización
# ============================================
echo ""
echo -e "${CYAN}📊 Resultado de Sincronización:${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

if [ "$PRIMARY_DATA" = "$REPLICA_DATA" ]; then
  echo -e "${GREEN}✅ Los datos están sincronizados (Primario: $PRIMARY_DATA, Réplica: $REPLICA_DATA)${NC}"
else
  echo -e "${RED}❌ Los datos NO están sincronizados (Primario: $PRIMARY_DATA, Réplica: $REPLICA_DATA)${NC}"
fi

# ============================================
# Lag de replicación
# ============================================
echo ""
echo -e "${CYAN}📊 Lag de Replicación:${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

docker exec postgres-primary psql -U postgres -c \
  "SELECT
    application_name,
    COALESCE(write_lag::text, 'N/A') as write_lag,
    COALESCE(flush_lag::text, 'N/A') as flush_lag,
    COALESCE(replay_lag::text, 'N/A') as replay_lag
  FROM pg_stat_replication;" || echo -e "${YELLOW}⚠️  No hay información de lag disponible${NC}"

# ============================================
# Resumen final
# ============================================
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ Verificación completada${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
