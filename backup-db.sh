#!/bin/bash
# Отключаем все ловушки, чтобы избежать вызова crond из внешних скриптов
trap '' DEBUG

set -e

LOGFILE="/opt/backup/backup.log"

# Загружаем секреты
source /opt/.db-secrets

# Убедимся, что папка существует
mkdir -p /opt/backup

# Имя файла дампа
BACKUP_FILE="/opt/backup/backup_$(date +%Y%m%d_%H%M%S).sql"

# Функция логирования
log() {
  echo "[$(date --rfc-3339=seconds)] $*" | tee -a "$LOGFILE"
}

log "Начало бэкапа"

# Запускаем mysqldump
docker run --rm \
  --network shvirtd-example-python_backend \
  -v /opt/backup:/backup \
  schnitzler/mysqldump \
  --host "$MYSQL_HOST" \
  --port "$MYSQL_PORT" \
  --user "$MYSQL_USER" \
  --password="$MYSQL_PASSWORD" \
  --databases "$MYSQL_DATABASE" \
  > "$BACKUP_FILE"

log "Бэкап сохранён: $BACKUP_FILE"

