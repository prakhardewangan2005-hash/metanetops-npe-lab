FROM python:3.12-slim

WORKDIR /app
COPY app.py /app/app.py

ENV EXPORTER_PORT=9109
EXPOSE 9109

CMD ["python", "/app/app.py"]
