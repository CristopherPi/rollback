FROM nginx:latest

COPY index.html/ /usr/share/nginx/html/

EXPOSE 80 5000

CMD ["nginx", "-g", "daemon off;"]



