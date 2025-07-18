# === Build stage ===
FROM python:3.11-slim AS build

WORKDIR /app
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt
COPY . .

# === Final stage ===
FROM python:3.11-slim

WORKDIR /app

# Копіюємо requirements.txt і встановлюємо залежності
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Копіюємо проєкт
COPY --from=build /app /app

EXPOSE 8080

CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]
