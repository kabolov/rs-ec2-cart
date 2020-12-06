FROM node:12-alpine

WORKDIR /rs-cart

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

USER node
ENV PORT=8080
EXPOSE 8080

CMD ["node", "dist/main.js"]