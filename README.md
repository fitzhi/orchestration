# Orchestration
Orchestration of the Fitzhi containers

# Installation on server

## Installation of the Docker ecosystem on ubuntu

Follow the instructions listed on the reference below.

https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository

## Installation of a test server for nginx
```bash
sudo docker pull nginxdemos/hello
```

## The test server will answer on port 8081
```bash
sudo docker run -p 8081:80 -d nginxdemos/hello
```
