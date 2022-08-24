FROM node:18.7.0-alpine

EXPOSE 8000

WORKDIR /app

COPY app /app

RUN yarn install

CMD ["node", "main.js"]
