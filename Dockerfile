FROM node:20 AS build
WORKDIR /usr/local/app

COPY package*.json ./

RUN npm install

COPY ./ /usr/local/app/

RUN npm cache clean --force
RUN npm run build

FROM nginx:latest

COPY --from=build /usr/local/app/dist/crud-app /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]


