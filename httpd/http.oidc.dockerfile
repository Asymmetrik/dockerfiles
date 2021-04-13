FROM centos:centos7

RUN yum update -y && yum install -y httpd mod_ssl mod_auth_openidc

# launch apache
CMD exec /usr/sbin/httpd -D FOREGROUND