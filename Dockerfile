FROM node:16-slim
WORKDIR /usr/src/app

COPY package*.json ./
COPY yarn.lock ./

RUN yarn install

COPY . .

RUN yarn build


ENV PORT=3000
EXPOSE ${PORT}

CMD yarn start