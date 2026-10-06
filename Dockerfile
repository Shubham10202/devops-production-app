FROM python:3.14-slim

WORKDIR /app

RUN mkdir -p /app/logs

COPY app/app.py .

EXPOSE 8080

CMD ["python3", "app.py"]
