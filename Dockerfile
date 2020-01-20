FROM node:alpine as build

ARG API_URL

WORKDIR /build
COPY package.json package-lock.json /build/
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:alpine

COPY --from=build /build/public /usr/share/nginx/html