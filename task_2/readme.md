## 🧾 **Задание 2: Docker-контейнер с Nginx и самоподписанным сертификатом**

### **Цель**
Настроить Nginx в Docker-контейнере:
- Работа на портах **80 (HTTP)** и **443 (HTTPS)**.
- **Редирект с HTTP на HTTPS**.
- Использование **самоподписанного сертификата**.
- Отдача **статической HTML-страницы** через volume.
- Автозапуск контейнера при перезагрузке ОС.

---

### 📁 **Структура проекта**
```bash
task_2/
├── Dockerfile
├── docker-compose.yml
├── nginx.conf
├── html/
│   └── index.html
├── curl_output.txt      # Вывод curl -vk https://localhost
├── docker_output.txt    # Логи контейнера
└── Curl_output.png      # Скриншот с TLS-соединением
```

---

### 🛠️ **Как использовать**

#### **1. Установите Docker и Docker Compose**
```bash
sudo apt update && sudo apt install docker.io docker-compose -y
```

#### **2. Перейдите в папку `task_2`**
```bash
cd ~/ATOH/ATOH_DevOps/task_2
```

#### **3. Очистите порты 80 и 443 (если заняты)**
```bash
sudo fuser -k 80/tcp
sudo fuser -k 443/tcp
sudo systemctl stop nginx
```

#### **4. Сгенерируйте самоподписанный сертификат**
```bash
mkdir -p ssl/
cd ssl/
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout self-signed.key \
  -out self-signed.crt \
  -subj "/C=RU/ST=Moscow/L=Moscow/O=DevOps/CN=localhost"
cd ..
```

#### **5. Соберите и запустите контейнер**
```bash
sudo docker-compose up -d --build
```

#### **6. Проверьте, что контейнер запущен**
```bash
sudo docker-compose ps
```
- Убедитесь, что `nginx` в статусе `Up`.

#### **7. Проверьте работу Nginx через `curl`**
```bash
curl -v http://localhost
```
- **Ожидаемый результат:**  
  ```
  < HTTP/1.1 301 Moved Permanently
  < Location: https://localhost/
  ```

```bash
curl -vk https://localhost
```
- **Ожидаемый вывод:**  
  ```html
  <h1>HTTPS работает</h1>
  ```

#### **8. Сохраните вывод в файлы**
```bash
curl -v http://localhost > curl_output.txt 2>&1
curl -vk https://localhost >> curl_output.txt 2>&1
```

```bash
sudo docker-compose logs > docker_output.txt 2>&1
```

---
