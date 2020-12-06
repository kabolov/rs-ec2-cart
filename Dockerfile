FROM node:12-alpine AS BUILD_IMAGE

WORKDIR /rs-cart

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

FROM node:12-alpine

WORKDIR /rs-cart

COPY --from=BUILD_IMAGE /rs-cart/package*.json ./
COPY --from=BUILD_IMAGE /rs-cart/dist ./dist
RUN npm install --only=prod

USER node
ENV PORT=8080
EXPOSE 8080

CMD ["node", "dist/main.js"]