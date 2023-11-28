FROM node:lts-slim
WORKDIR /myapp

COPY package.json .


RUN npm install

COPY . .

CMD ["node", "app.js"]

