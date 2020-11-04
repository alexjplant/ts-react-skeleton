FROM node:14.15.0-alpine3.10 AS build

WORKDIR /app
COPY package.json ./
RUN npm install

COPY src ./src
COPY public ./public
COPY *.json ./
RUN npm run build

FROM nginx:1.19.3-alpine

COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80