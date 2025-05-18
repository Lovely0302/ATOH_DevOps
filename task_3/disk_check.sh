#!/bin/bash

# Порог занятости диск 
THRESHOLD=85

# Подгружаем .env 
source /home/rich/ATOH/ATOH_DevOps_env/.env

# Проверка, подгружены ли переменные
if [ -z "$SMTP_SERVER" ] || [ -z "$SMTP_USER" ] || [ -z "$SMTP_PASS" ]; then
  echo "Ошибка: Не все переменные из .env загружены."
  exit 1
fi

# Проверка занятости диска 
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

# Получатель уведомлений 
TO_EMAIL="${TO_EMAIL:-$SMTP_USER}"

# Проверка порога
if [ "$DISK_USAGE" -gt "$THRESHOLD" ]; then
  SUBJECT="Внимание: Диск почти заполнен"
  MESSAGE="Subject: $SUBJECT\n\nДиск / заполнен на $DISK_USAGE% (порог: $THRESHOLD%)\nПожалуйста, очистите место."

  # Отправка через swaks с TLS
  echo -e "$MESSAGE" | swaks --to "$TO_EMAIL" \
                            --from "$SMTP_USER" \
                            --server "$SMTP_SERVER:$SMTP_PORT" \
                            --auth LOGIN \
                            --auth-user "$SMTP_USER" \
                            --auth-password "$SMTP_PASS" \
                            --body "$MESSAGE" \
                            --tls
  echo " Уведомление отправлено: $TO_EMAIL"
else
  echo " Диск заполнен на $DISK_USAGE% — всё в норме."
fi
