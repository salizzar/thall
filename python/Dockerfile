FROM python:3.11.2-alpine3.17

EXPOSE 8000

WORKDIR /app

COPY app /app

RUN apk add e2fsprogs=1.46.6-r0 --no-cache && \
    pip3 install --no-cache-dir --upgrade pip==23.0.1 && \
    pip3 install --no-cache-dir --requirement requirements.txt && \
    rm -rf /var/cache/apk/*

CMD ["python", "main.py"]
