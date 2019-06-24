
### Base image from which we’ll start building the container
FROM centos:7

#Set the author field for images
MAINTAINER Aashi Manak Bohara <boharaaashi@gmail.com>


# Install Apache: 2.4.x and deltarpm
RUN yum install httpd deltarpm -y


# Node.js Yum Repository
RUN curl -sL https://rpm.nodesource.com/setup_10.x | bash -


# Install NodeJS: v10.13.0 and NPM: 6.4.1
RUN yum install -y npm nodejs


# Advanced package management software for Node.js applications
RUN npm install yarn -g


# Instructions to install MongoDB Yum Repository
RUN echo -e "\
[mongodb-org-4.0]\n\
name=MongoDB Repository\n\
baseurl=https://repo.mongodb.org/yum/amazon/2013.03/mongodb-org/4.0/x86_64/\n\
gpgcheck=1\n\
enabled=1\n\
gpgkey=https://www.mongodb.org/static/pgp/server-4.0.asc\n" >> /etc/yum.repos.d/mongodb.repo


# Install MongoDB: 4.0
RUN yum update -y && yum install mongodb-org -y


# Set up directory requirements
RUN mkdir -p /data/mongodb /var/log/mongodb /var/run/mongodb
VOLUME ["/data/mongodb", "/var/log/mongodb"]


# Expose port 27017 from the container to the host--> mongodb port
EXPOSE 27017


# Exposes the container’s port to host the system (outside world)
EXPOSE 3000


# Start mongodb and httpd service
ENTRYPOINT ["/usr/bin/mongod"]
CMD ["httpd -DFOREGROUND","--port", "27017", "--dbpath", "/data/mongodb", "--pidfilepath", "/var/run/mongodb/mongod.pid"]


# Starts the mongod instance in the container
#CMD ["mongod", "--smallfiles"]

