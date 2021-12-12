FROM nginx:1.20.1

RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bk

COPY nginx-app.conf /etc/nginx/conf.d/
RUN mv /etc/nginx/conf.d/nginx-app.conf /etc/nginx/conf.d/app.conf

ENTRYPOINT /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
