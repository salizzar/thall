FROM node:current-alpine3.16

EXPOSE 8000

WORKDIR /app

COPY app /app

RUN yarn install && \
    yarn cache clean

CMD ["node", "main.js"]
