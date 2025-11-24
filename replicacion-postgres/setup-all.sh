#!/bin/bash
set -e

# ============================================
# Script de Configuración Automática Completa
# Replicación PostgreSQL con Docker
# ============================================

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Variables de entorno (con valores por defecto)
REPLICATION_USER="${REPLICATION_USER:-replicator}"
REPLICATION_PASSWORD="${REPLICATION_PASSWORD:-replicator_pass}"
POSTGRES_USER="${POSTGRES_USER:-postgres}"
POSTGRES_PASSWORD="${POSTGRES_PASSWORD:-postgres}"
POSTGRES_DB="${POSTGRES_DB:-testdb}"

# Función para imprimir encabezados
print_header() {
  echo ""
  echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo -e "${GREEN}$1${NC}"
  echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# Función para imprimir pasos
print_step() {
  echo ""
  echo -e "${CYAN}📋 $1${NC}"
}

# Función para imprimir éxito
print_success() {
  echo -e "${GREEN}✅ $1${NC}"
}

# Función para imprimir advertencia
print_warning() {
  echo -e "${YELLOW}⚠️  $1${NC}"
}

# Función para imprimir error
print_error() {
  echo -e "${RED}❌ $1${NC}"
}

# Banner inicial
clear
print_header "🚀 Configuración Completa de Replicación PostgreSQL"
echo ""
echo -e "${CYAN}Este script configurará automáticamente:${NC}"
echo -e "  • Nodo PostgreSQL Primario (Master)"
echo -e "  • Nodo PostgreSQL Réplica (Standby)"
echo -e "  • PgAdmin (Interfaz Web)"
echo -e "  • Replicación Streaming"
echo ""

# ============================================
# PASO 1: Limpieza
# ============================================
print_step "Paso 1/8: Limpiando configuración anterior"

docker compose down 2>/dev/null || true
docker volume rm replicacion-postgres_replica-data 2>/dev/null || true

print_success "Limpieza completada"

# ============================================
# PASO 2: Iniciar Primario
# ============================================
print_step "Paso 2/8: Iniciando nodo primario y PgAdmin"

docker compose up -d postgres-primary pgadmin

print_success "Contenedores iniciados"

# ============================================
# PASO 3: Esperar Primario (MEJORADO)
# ============================================
print_step "Paso 3/8: Esperando a que el primario esté listo"

echo -n "Verificando disponibilidad"
RETRY_COUNT=0
MAX_RETRIES=60

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
  # Verificar que PostgreSQL está listo Y aceptando conexiones SQL
  if docker exec postgres-primary pg_isready -U postgres >/dev/null 2>&1 &&
    docker exec postgres-primary psql -U postgres -c "SELECT 1;" >/dev/null 2>&1; then
    echo ""
    print_success "Primario está listo y aceptando conexiones"
    break
  fi
  echo -n "."
  sleep 2
  RETRY_COUNT=$((RETRY_COUNT + 1))
done
echo ""

if [ $RETRY_COUNT -eq $MAX_RETRIES ]; then
  print_error "El primario no respondió después de $((MAX_RETRIES * 2)) segundos"
  echo ""
  echo "Logs del primario:"
  docker logs postgres-primary --tail 50
  exit 1
fi

# Esperar adicional para estabilización
echo "Esperando estabilización adicional (10 segundos)..."
sleep 10

# ============================================
# PASO 4: Verificar Configuración del Primario
# ============================================
print_step "Paso 4/8: Verificando configuración del primario"

echo ""
echo "Versión de PostgreSQL:"
docker exec postgres-primary psql -U postgres -c "SELECT version();"

echo ""
echo "Usuario de replicación:"
docker exec postgres-primary psql -U postgres -c "\du replicator"

echo ""
echo "Slot de replicación:"
docker exec postgres-primary psql -U postgres -c "SELECT slot_name, slot_type, active FROM pg_replication_slots;"

echo ""
echo "Conectividad de red desde contenedor temporal:"
docker run --rm --network replicacion-postgres_postgres-network alpine ping -c 3 postgres-primary

# ============================================
# PASO 5: Limpiar Slots Anteriores
# ============================================
print_step "Paso 5/8: Preparando configuración de replicación"

# Eliminar slot si existe
docker exec postgres-primary psql -U postgres -c \
  "SELECT pg_drop_replication_slot('replica_slot');" 2>/dev/null ||
  echo "No hay slots previos (esto es normal en la primera ejecución)"

print_success "Preparación completada"

# ============================================
# PASO 6: Realizar pg_basebackup (MEJORADO)
# ============================================
print_step "Paso 6/8: Copiando datos del primario a la réplica (pg_basebackup)"

echo ""
echo "Este proceso puede tardar algunos minutos dependiendo del tamaño de la base de datos..."
echo ""

# Verificar conectividad antes de pg_basebackup
echo "Verificando conectividad desde contenedor temporal..."
if ! docker run --rm \
  --network replicacion-postgres_postgres-network \
  -e PGPASSWORD="$REPLICATION_PASSWORD" \
  postgres:16-alpine \
  psql -h postgres-primary -U $REPLICATION_USER -d postgres -c "SELECT 1;" >/dev/null 2>&1; then
  print_error "No se puede conectar al primario para replicación"
  echo ""
  echo "Verificando estado del primario:"
  docker exec postgres-primary psql -U postgres -c "SELECT * FROM pg_stat_activity WHERE usename='replicator';"
  echo ""
  echo "Verificando pg_hba.conf:"
  docker exec postgres-primary cat /var/lib/postgresql/data/pg_hba.conf | grep -i replication
  exit 1
fi

print_success "Conectividad verificada"
echo ""

# Realizar pg_basebackup
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

print_success "Backup base completado"

# ============================================
# PASO 7: Configurar Modo Standby
# ============================================
print_step "Paso 7/8: Configurando modo standby en la réplica"

# Asegurar que existe standby.signal
docker run --rm -v replicacion-postgres_replica-data:/data alpine touch /data/standby.signal

# Verificar configuración
echo ""
echo "Configuración de conexión al primario:"
docker run --rm -v replicacion-postgres_replica-data:/data alpine cat /data/postgresql.auto.conf

print_success "Configuración de standby completada"

# ============================================
# PASO 8: Iniciar Réplica
# ============================================
print_step "Paso 8/8: Iniciando nodo réplica"

docker compose up -d postgres-replica

print_success "Réplica iniciada"

# Esperar a que la réplica esté lista
echo ""
echo -n "Esperando a que la réplica esté lista"
RETRY_COUNT=0
MAX_RETRIES=30

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
  if docker exec postgres-replica pg_isready -U postgres >/dev/null 2>&1; then
    echo ""
    print_success "Réplica está lista y aceptando conexiones"
    break
  fi
  echo -n "."
  sleep 2
  RETRY_COUNT=$((RETRY_COUNT + 1))
done
echo ""

if [ $RETRY_COUNT -eq $MAX_RETRIES ]; then
  print_warning "La réplica tardó en iniciar, verificando logs..."
  docker logs postgres-replica --tail 30
fi

# ============================================
# VERIFICACIÓN FINAL
# ============================================
print_header "📊 VERIFICACIÓN DE REPLICACIÓN"

echo ""
echo -e "${YELLOW}Estado de replicación en el PRIMARIO:${NC}"
docker exec postgres-primary psql -U postgres -x -c \
  "SELECT application_name, client_addr, state, sync_state, replay_lag FROM pg_stat_replication;"

echo ""
echo -e "${YELLOW}Estado de la RÉPLICA (debe mostrar 't' = en recovery mode):${NC}"
docker exec postgres-replica psql -U postgres -c "SELECT pg_is_in_recovery();"

echo ""
echo -e "${YELLOW}Datos en el PRIMARIO:${NC}"
docker exec postgres-primary psql -U postgres -d testdb -c "SELECT * FROM test_replication;"

echo ""
echo -e "${YELLOW}Datos en la RÉPLICA (deben coincidir con el primario):${NC}"
docker exec postgres-replica psql -U postgres -d testdb -c "SELECT * FROM test_replication;"

# ============================================
# PRUEBA DE REPLICACIÓN
# ============================================
print_header "🧪 PRUEBA DE REPLICACIÓN EN TIEMPO REAL"

echo ""
echo -e "${CYAN}Insertando un nuevo registro en el primario...${NC}"
docker exec postgres-primary psql -U postgres -d testdb -c \
  "INSERT INTO test_replication (data) VALUES ('Prueba automática - $(date)');"

echo ""
echo -e "${CYAN}Esperando 3 segundos para que se replique...${NC}"
sleep 3

echo ""
echo -e "${YELLOW}Verificando en la RÉPLICA (debe incluir el nuevo registro):${NC}"
docker exec postgres-replica psql -U postgres -d testdb -c \
  "SELECT * FROM test_replication ORDER BY id DESC LIMIT 5;"

# ============================================
# RESUMEN FINAL
# ============================================
print_header "✅ ¡CONFIGURACIÓN COMPLETADA EXITOSAMENTE!"

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}📊 Información de Acceso:${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${YELLOW}🔹 PostgreSQL Primario (Lectura/Escritura):${NC}"
echo -e "     Host: localhost"
echo -e "     Puerto: 5432"
echo -e "     Usuario: $POSTGRES_USER"
echo -e "     Base de datos: $POSTGRES_DB"
echo ""
echo -e "  ${YELLOW}🔹 PostgreSQL Réplica (Solo Lectura):${NC}"
echo -e "     Host: localhost"
echo -e "     Puerto: 5433"
echo -e "     Usuario: $POSTGRES_USER"
echo -e "     Base de datos: $POSTGRES_DB"
echo ""
echo -e "  ${YELLOW}🔹 PgAdmin (Interfaz Web):${NC}"
echo -e "     URL: http://localhost:5050"
echo -e "     Email: admin@admin.com"
echo -e "     Contraseña: admin"
echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}📝 Comandos Útiles:${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${YELLOW}Verificar replicación:${NC}       sudo make verify"
echo -e "  ${YELLOW}Probar replicación:${NC}          sudo make test"
echo -e "  ${YELLOW}Ver logs del primario:${NC}       sudo make logs-primary"
echo -e "  ${YELLOW}Ver logs de la réplica:${NC}      sudo make logs-replica"
echo -e "  ${YELLOW}Shell en primario:${NC}           sudo make shell-primary"
echo -e "  ${YELLOW}Shell en réplica:${NC}            sudo make shell-replica"
echo -e "  ${YELLOW}Estado de contenedores:${NC}      sudo make status"
echo -e "  ${YELLOW}Detener todo:${NC}                sudo make stop"
echo -e "  ${YELLOW}Ver todos los comandos:${NC}      sudo make help"
echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${CYAN}💡 Tip: Usa 'sudo make test' para insertar datos de prueba${NC}"
echo ""
