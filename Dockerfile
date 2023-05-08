FROM node:latest AS build
WORKDIR /app

COPY package*.json .
RUN npm ci
COPY . ./

RUN npm run dev

FROM nginx:1.21.5-alpine as release
COPY --from=build /app/build /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]