#!/bin/bash

# Масив з URL вебсайтів для перевірки
websites=("https://google.com" "https://facebook.com" "https://twitter.com")

# Ім'я файлу логів
log_file="website_status.log"

# Очищення файлу логів перед записом нових даних
> "$log_file"

# Перевірка кожного сайту зі списку
for website in "${websites[@]}"; do
  # Використання curl для перевірки HTTP статусу з опцією -L для слідування за переадресацією
  http_status=$(curl -o /dev/null -s -w "%{http_code}\n" -L "$website")
  
  # Перевірка чи статус код 200 (успішна відповідь)
  if [ "$http_status" -eq 200 ]; then
    echo "<$website> is UP" | tee -a "$log_file"
  else
    echo "<$website> is DOWN" | tee -a "$log_file"
  fi
done

# Виведення повідомлення про завершення перевірки
echo "Results have been logged to $log_file"


