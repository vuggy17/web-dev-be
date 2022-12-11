FROM node:14 as builder
WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build


FROM node:14
WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/package*.json ./
RUN npm install --only=production

COPY --from=builder /usr/src/app/dist/ ./

ENV PORT=3000
EXPOSE ${PORT}

CMD node index.js