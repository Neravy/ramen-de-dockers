#!/bin/bash

# ============================================
# Script de Prueba de Replicación
# ============================================

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}🧪 Prueba de Replicación en Tiempo Real${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# ============================================
# Mostrar estado inicial
# ============================================
echo ""
echo -e "${CYAN}📊 Estado Inicial:${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

PRIMARY_COUNT_BEFORE=$(docker exec postgres-primary psql -U postgres -d testdb -tAc "SELECT COUNT(*) FROM test_replication;")
REPLICA_COUNT_BEFORE=$(docker exec postgres-replica psql -U postgres -d testdb -tAc "SELECT COUNT(*) FROM test_replication;")

echo -e "${YELLOW}Registros en PRIMARIO:${NC} $PRIMARY_COUNT_BEFORE"
echo -e "${YELLOW}Registros en RÉPLICA:${NC} $REPLICA_COUNT_BEFORE"

# ============================================
# Insertar datos en el primario
# ============================================
echo ""
echo -e "${CYAN}📝 Insertando Datos en el PRIMARIO:${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
TEST_DATA="Prueba de replicación - $TIMESTAMP"

echo -e "${YELLOW}Insertando:${NC} '$TEST_DATA'"
echo ""

docker exec postgres-primary psql -U postgres -d testdb -c \
  "INSERT INTO test_replication (data) VALUES ('$TEST_DATA') RETURNING id, data, created_at;"

# ============================================
# Esperar replicación
# ============================================
echo ""
echo -e "${YELLOW}⏳ Esperando 3 segundos para que se replique...${NC}"
sleep 3

# ============================================
# Verificar en la réplica
# ============================================
echo ""
echo -e "${CYAN}📊 Verificando en la RÉPLICA:${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

echo ""
echo -e "${YELLOW}Últimos 5 registros en la RÉPLICA:${NC}"
docker exec postgres-replica psql -U postgres -d testdb -c \
  "SELECT id, data, created_at FROM test_replication ORDER BY id DESC LIMIT 5;"

# ============================================
# Comparar contadores
# ============================================
echo ""
echo -e "${CYAN}📊 Comparación Final:${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

PRIMARY_COUNT_AFTER=$(docker exec postgres-primary psql -U postgres -d testdb -tAc "SELECT COUNT(*) FROM test_replication;")
REPLICA_COUNT_AFTER=$(docker exec postgres-replica psql -U postgres -d testdb -tAc "SELECT COUNT(*) FROM test_replication;")

echo ""
echo -e "${YELLOW}Estado ANTES:${NC}"
echo "  Primario: $PRIMARY_COUNT_BEFORE registros"
echo "  Réplica:  $REPLICA_COUNT_BEFORE registros"
echo ""
echo -e "${YELLOW}Estado DESPUÉS:${NC}"
echo "  Primario: $PRIMARY_COUNT_AFTER registros"
echo "  Réplica:  $REPLICA_COUNT_AFTER registros"
echo ""

# ============================================
# Resultado
# ============================================
if [ "$PRIMARY_COUNT_AFTER" = "$REPLICA_COUNT_AFTER" ]; then
  echo -e "${GREEN}✅ ¡Replicación exitosa! Los datos coinciden.${NC}"
else
  echo -e "${RED}❌ Error: Los datos NO coinciden.${NC}"
  echo -e "${YELLOW}Diferencia: $((PRIMARY_COUNT_AFTER - REPLICA_COUNT_AFTER)) registros${NC}"
fi

# ============================================
# Verificar el registro específico
# ============================================
echo ""
echo -e "${CYAN}📊 Verificando Registro Específico:${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

echo ""
echo -e "${YELLOW}¿Existe el registro en la RÉPLICA?${NC}"
FOUND=$(docker exec postgres-replica psql -U postgres -d testdb -tAc \
  "SELECT COUNT(*) FROM test_replication WHERE data = '$TEST_DATA';")

if [ "$FOUND" = "1" ]; then
  echo -e "${GREEN}✅ Sí, el registro específico fue replicado correctamente${NC}"
else
  echo -e "${RED}❌ No, el registro específico NO fue encontrado${NC}"
fi

# ============================================
# Mostrar lag de replicación
# ============================================
echo ""
echo -e "${CYAN}📊 Lag de Replicación Actual:${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

docker exec postgres-primary psql -U postgres -c \
  "SELECT
    application_name,
    state,
    sync_state,
    COALESCE(replay_lag::text, '0 seconds') as replay_lag
  FROM pg_stat_replication;" || echo -e "${YELLOW}⚠️  No hay información de lag disponible${NC}"

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ Prueba completada${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
