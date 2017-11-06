# Set the base image to Ubuntu
FROM ubuntu:16.04

# File Author / Maintainer
#MAINTAINER Dan Rausch <dan.rausch@gmail.com>

# Setup packages
USER root
RUN apt-get -y -m update && apt-get install -y wget unzip zip libgsl-dev libgsl2 bzip2 build-essential git

# switch back to the ubuntu user so this tool (and the files written) are not owned by root
RUN groupadd -r -g 1000 ubuntu && useradd -r -g ubuntu -u 1000 ubuntu

RUN apt-get -y -m update && apt-get -y upgrade
RUN apt-get -y clean
RUN apt-get -y autoclean

# set local directories to ubuntu user
RUN mkdir -p /home/ubuntu
RUN chown ubuntu /home/ubuntu

USER ubuntu

WORKDIR /home/ubuntu

# get and setup blast applications
RUN wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/LATEST/ncbi-blast-2.7.1+-x64-linux.tar.gz
RUN tar zxvf ncbi-blast-2.7.1+-x64-linux.tar.gz
RUN mkdir -p /home/ubuntu/bin/
RUN cp ncbi-blast-2.7.1+/bin/* /home/ubuntu/bin/.

# ENV VAR VALUE - add the blast bin directory to the path
ENV PATH /home/ubuntu/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV HOME /home/ubuntu
WORKDIR /home/ubuntu

CMD ["/bin/bash"]

