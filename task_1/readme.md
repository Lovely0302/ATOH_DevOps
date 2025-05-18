### **Как проверить задание**

#### **1. Убедитесь, что Ansible установлен**
```bash
ansible --version
```

#### **2. Запустите плейбук**
```bash
cd ~/ATOH/ATOH_DevOps/task_1
ansible-playbook playbook.yml > playbook_output.txt 2>&1
```

#### **3. Проверьте, что порт 80 слушается**
```bash
sudo ss -tuln | grep 80 > ss_output.txt
```
- **Ожидаемый вывод:**
  ```
  tcp6 0 0 *:80 *:* LISTEN
  ```

#### **4. Проверьте редирект с HTTP на HTTPS**
```bash
curl -v http://localhost
```
- **Ожидаемый результат:**
  ```
  < HTTP/1.1 301 Moved Permanently
  < Location: https://localhost/
  ```
