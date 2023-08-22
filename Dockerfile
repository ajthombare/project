FROM httpd:latest
COPY index.html /usr/share/apache2/htdocs
EXPOSE 80

