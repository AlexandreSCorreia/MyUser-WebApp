FROM node:alpine AS build

COPY package.json /usr/
WORKDIR /usr
RUN npm install

COPY ./ /usr
RUN npm run build

FROM nginx:alpine

## Remove default Nginx website
RUN rm -rf /usr/share/nginx/html/*

COPY ./nginx.config /etc/nginx/nginx.conf

COPY --from=build  /usr/dist/my-user-web-app /usr/share/nginx/html

RUN echo "mainFileName=\"\$(ls /usr/share/nginx/html/main*.js)\" && \
          envsubst '\$URL_IMAGEM ' < \${mainFileName} > main.tmp && \
          mv main.tmp  \${mainFileName} && nginx -g 'daemon off;'" > run.sh

ENTRYPOINT ["sh", "run.sh"]
