FROM httpd:2.4
RUN rm /usr/local/apache2/htdocs/index.html
COPY ./content /usr/local/apache2/htdocs
COPY ./includes /usr/local/apache2/htdocs
COPY ./htaccess /usr/local/apache2/htdocs
COPY ./index.php /usr/local/apache2/htdocs
