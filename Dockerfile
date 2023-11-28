FROM node:20.10-slim

WORKDIR /myapp

COPY package.json .


RUN npm install

COPY . .

CMD ["node", "app.js"]

