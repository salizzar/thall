FROM node:19.8-alpine

EXPOSE 8000

WORKDIR /app

COPY app /app

RUN yarn install && \
    yarn cache clean

CMD ["node", "src/main.js"]
