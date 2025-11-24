.PHONY: help start stop restart logs status verify test clean setup-replica full-setup

# Variables
DOCKER_COMPOSE = docker compose
DOCKER = docker

# Colores para output
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
BLUE = \033[0;34m
NC = \033[0m # No Color

help:
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(GREEN)  PostgreSQL Replication - Comandos Disponibles$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""
	@echo "$(YELLOW)Inicio y Configuración:$(NC)"
	@echo "  make full-setup    - Configuración completa automática (RECOMENDADO)"
	@echo "  make start         - Iniciar solo el nodo primario"
	@echo "  make setup-replica - Configurar y activar la réplica"
	@echo ""
	@echo "$(YELLOW)Control de Contenedores:$(NC)"
	@echo "  make stop          - Detener todos los contenedores"
	@echo "  make restart       - Reiniciar todos los contenedores"
	@echo "  make status        - Ver estado de contenedores"
	@echo ""
	@echo "$(YELLOW)Logs y Monitoreo:$(NC)"
	@echo "  make logs          - Ver logs de todos los contenedores"
	@echo "  make logs-primary  - Ver logs solo del primario"
	@echo "  make logs-replica  - Ver logs solo de la réplica"
	@echo ""
	@echo "$(YELLOW)Verificación y Pruebas:$(NC)"
	@echo "  make verify        - Verificar estado de replicación"
	@echo "  make test          - Probar replicación insertando datos"
	@echo ""
	@echo "$(YELLOW)Acceso a Base de Datos:$(NC)"
	@echo "  make shell-primary - Conectar a PostgreSQL primario"
	@echo "  make shell-replica - Conectar a PostgreSQL réplica"
	@echo ""
	@echo "$(YELLOW)Utilidades:$(NC)"
	@echo "  make backup        - Crear backup de la base de datos"
	@echo "  make clean         - Limpiar todo (¡cuidado!)"
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"

full-setup:
	@echo "$(GREEN)🚀 Iniciando configuración completa...$(NC)"
	@chmod +x setup-all.sh
	@./setup-all.sh

start:
	@echo "$(GREEN)🚀 Iniciando contenedores...$(NC)"
	$(DOCKER_COMPOSE) up -d postgres-primary pgadmin
	@echo "$(YELLOW)⏳ Esperando a que el primario esté listo...$(NC)"
	@sleep 15
	@echo ""
	@echo "$(GREEN)✅ Primario iniciado$(NC)"
	@echo "$(YELLOW)⚠️  IMPORTANTE: Ejecuta 'make setup-replica' para configurar la réplica$(NC)"

setup-replica:
	@echo "$(GREEN)🔧 Configurando réplica...$(NC)"
	@chmod +x scripts/configure-replica.sh
	@bash scripts/configure-replica.sh
	@echo ""
	@sleep 5
	@make verify

stop:
	@echo "$(RED)🛑 Deteniendo contenedores...$(NC)"
	$(DOCKER_COMPOSE) down

restart:
	@make stop
	@sleep 2
	@make start

logs:
	$(DOCKER_COMPOSE) logs -f

logs-primary:
	$(DOCKER) logs -f postgres-primary

logs-replica:
	$(DOCKER) logs -f postgres-replica

status:
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(GREEN)📊 Estado de Contenedores$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@$(DOCKER_COMPOSE) ps

verify:
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo "$(GREEN)🔍 Verificando Estado de Replicación$(NC)"
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"
	@echo ""
	@echo "$(YELLOW)📊 Estado en PRIMARIO:$(NC)"
	@$(DOCKER) exec postgres-primary psql -U postgres -c "SELECT application_name, state, sync_state FROM pg_stat_replication;" || echo "$(RED)❌ No hay réplicas conectadas$(NC)"
	@echo ""
	@echo "$(YELLOW)📊 Estado en RÉPLICA (debe mostrar 't'):$(NC)"
	@$(DOCKER) exec postgres-replica psql -U postgres -c "SELECT pg_is_in_recovery();" || echo "$(RED)❌ Réplica no disponible$(NC)"
	@echo ""
	@echo "$(YELLOW)📊 Datos en PRIMARIO:$(NC)"
	@$(DOCKER) exec postgres-primary psql -U postgres -d testdb -c "SELECT * FROM test_replication;" || echo "$(RED)❌ No se pudo consultar$(NC)"
	@echo ""
	@echo "$(YELLOW)📊 Datos en RÉPLICA:$(NC)"
	@$(DOCKER) exec postgres-replica psql -U postgres -d testdb -c "SELECT * FROM test_replication;" || echo "$(RED)❌ No se pudo consultar$(NC)"
	@echo ""
	@echo "$(BLUE)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(NC)"

test:
	@chmod +x scripts/test-replication.sh
	@bash scripts/test-replication.sh

clean:
	@echo "$(RED)⚠️  ¿Estás seguro? Esto eliminará TODOS los datos.$(NC)"
	@echo "$(RED)    Presiona Ctrl+C en los próximos 5 segundos para cancelar...$(NC)"
	@sleep 5
	$(DOCKER_COMPOSE) down -v
	@echo "$(GREEN)🗑️  Limpieza completada$(NC)"

shell-primary:
	@echo "$(GREEN)🐘 Conectando a PostgreSQL PRIMARIO...$(NC)"
	$(DOCKER) exec -it postgres-primary psql -U postgres -d testdb

shell-replica:
	@echo "$(GREEN)🐘 Conectando a PostgreSQL RÉPLICA...$(NC)"
	$(DOCKER) exec -it postgres-replica psql -U postgres -d testdb

backup:
	@echo "$(GREEN)💾 Creando backup...$(NC)"
	@$(DOCKER) exec postgres-primary pg_dump -U postgres testdb > backup_$$(date +%Y%m%d_%H%M%S).sql
	@echo "$(GREEN)✅ Backup creado: backup_$$(date +%Y%m%d_%H%M%S).sql$(NC)"

# Comandos adicionales útiles
ps:
	@$(DOCKER_COMPOSE) ps

top:
	@$(DOCKER_COMPOSE) top

stats:
	@$(DOCKER) stats postgres-primary postgres-replica

network:
	@$(DOCKER) network inspect replicacion-postgres_postgres-network

volumes:
	@$(DOCKER) volume ls | grep replicacion-postgres

inspect-primary:
	@$(DOCKER) inspect postgres-primary

inspect-replica:
	@$(DOCKER) inspect postgres-replica
