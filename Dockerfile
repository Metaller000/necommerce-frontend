FROM node:lts AS build
WORKDIR /app
COPY package.json ./
# RUN npm ci
RUN npm i
COPY . .
RUN NODE_OPTIONS=--openssl-legacy-provider npm run build

FROM nginx
WORKDIR /app
COPY --from=build /app/build .
COPY nginx.conf.template /etc/nginx/templates/default.conf.template
