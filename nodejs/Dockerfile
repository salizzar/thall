FROM node:18.13-alpine

EXPOSE 8000

WORKDIR /app

COPY app /app

RUN yarn install && \
    yarn cache clean

CMD ["node", "main.js"]
