# Используем базовый образ Python
FROM python:3.12-alpine

# Устанавливаем зависимости
COPY requirements.txt /main/requirements.txt
RUN pip install --no-cache-dir -r /main/requirements.txt

# Копируем исходный код приложения в контейнер
COPY . /main
WORKDIR /main

# Запускаем приложение
CMD ["python", "main.py"]
