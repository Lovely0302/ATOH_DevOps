# Task 3: Мониторинг диска с уведомлениями по email

## Цель
Скрипт проверяет занятость диска и отправляет email-уведомление, если свободного места менее 15% (занято более 85%).

---

## Как использовать

1. **Установите `swaks` (SMTP-клиент)**  
   ```bash
   sudo apt update && sudo apt install swaks
   ```

2. **Создайте `.env` вне репозитория**  
   ```bash
   mkdir -p ~/ATOH/ATOH_DevOps_env
   nano ~/ATOH/ATOH_DevOps_env/.env
   ```  
   **Содержимое `.env`:**  
   ```bash
   SMTP_SERVER=smtp.yandex.ru
   SMTP_PORT=587
   SMTP_USER=your_email@yandex.ru
   SMTP_PASS=ваш_app_password
   TO_EMAIL=admin@example.com  # Получатель уведомлений (можно ваш Yandex-емейл)
   ```  
   **Установите строгие права:**  
   ```bash
   chmod 600 ~/ATOH/ATOH_DevOps_env/.env
   ```

3. **Подключите `.env` в скрипте**  
   ```bash
   # В начале `disk_check.sh` добавьте:
   source /home/rich/ATOH/ATOH_DevOps_env/.env
   ```

4. **Запустите скрипт вручную**  
   ```bash
   source ~/ATOH/ATOH_DevOps_env/.env
   ~/ATOH/ATOH_DevOps/task_3/disk_check.sh
   ```

5. **Настройте `cron` для регулярной проверки**  
   ```bash
   crontab -e
   ```  
   **Добавьте:**  
   ```cron
   */5 * * * * /bin/bash /home/rich/ATOH/ATOH_DevOps/task_3/disk_check.sh >> /home/rich/ATOH/ATOH_DevOps/task_3/disk_check.log 2>&1
   ```

6. **Проверьте логи**  
   ```bash
   cat ~/ATOH/ATOH_DevOps/task_3/disk_check.log
   ```

---

## Проверка работы

- **Запуск вручную:**  
  ```bash
  source ~/ATOH/ATOH_DevOps_env/.env
  ~/ATOH/ATOH_DevOps/task_3/disk_check.sh
  ```

- **Если диск занят более чем на 85% — получите email.**

- **Тестовая отправка через `swaks`:**  
  ```bash
  source ~/ATOH/ATOH_DevOps_env/.env
  SUBJECT="⚠️ Диск почти заполнен"
  BODY="Subject: $SUBJECT\n\nДиск / заполнен на $(df -h / | awk 'NR==2 {print $5}')%"
  echo -e "$BODY" | swaks --to "$TO_EMAIL" \
                          --from "$SMTP_USER" \
                          --server "$SMTP_SERVER:$SMTP_PORT" \
                          --auth LOGIN \
                          --auth-user "$SMTP_USER" \
                          --auth-password "$SMTP_PASS" \
                          --body "$BODY" \
                          --tls
  ```

---

## Структура проекта

```bash
ATOH_DevOps/
├── task_3/
│   ├── disk_check.sh*   # Исполняемый скрипт
│   └── README.md
├── ATOH_DevOps_env/
│   └── .env           # Не в Git, только локально
└── .gitignore
```

---

**Примечание**: Убедитесь, что пути в скриптах и командах соответствуют вашей файловой структуре. Замените `your_email@yandex.ru` и `ваш_app_password` на реальные данные в файле `.env`.Также замените `rich` на имя пользователя на вашей машине.
