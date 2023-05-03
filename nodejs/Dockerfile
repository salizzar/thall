FROM node:19-alpine

EXPOSE 8000

WORKDIR /app

COPY app /app

RUN yarn install && \
    yarn cache clean

CMD ["node", "src/main.js"]
