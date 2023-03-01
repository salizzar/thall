FROM python:3.10.10-alpine

EXPOSE 8000

WORKDIR /app

COPY requirements.txt /app/requirements.txt
COPY app /app/app

RUN pip3 install --no-cache-dir --upgrade pip==23.0.1 && \
    pip3 install --no-cache-dir --requirement requirements.txt && \
    rm -rf /var/cache/apk/*

CMD ["python", "app/main.py"]
