# Set the base image to Ubuntu
FROM ubuntu:16.04

# File Author / Maintainer
#MAINTAINER Dan Rausch <dan.rausch@gmail.com>

# Setup packages
USER root
RUN apt-get -y -m update && apt-get install -y wget unzip zip libgsl-dev libgsl2 bzip2 build-essential git python

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

# get and setup vecscreen applications
RUN wget ftp://ftp.ncbi.nlm.nih.gov/blast/demo/vecscreen
RUN chmod 775 vecscreen
RUN mv vecscreen /home/ubuntu/bin/.

RUN wget ftp://ftp.ncbi.nlm.nih.gov/pub/kitts/VSlistTo1HitPerLine.awk
RUN chmod 775 VSlistTo1HitPerLine.awk
RUN mv VSlistTo1HitPerLine.awk /home/ubuntu/bin/.

# ENV VAR VALUE - add the blast bin directory to the path
ENV PATH /home/ubuntu/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV HOME /home/ubuntu

# setup contamination screening blast dbs
RUN mkdir -p /home/ubuntu/contam-dbs/
WORKDIR /home/ubuntu/contam-dbs/

# contam_in_euks
WORKDIR /home/ubuntu/contam-dbs/
RUN mkdir -p contam_in_euks
WORKDIR /home/ubuntu/contam-dbs/contam_in_euks/
RUN wget ftp://ftp.ncbi.nlm.nih.gov/pub/kitts/contam_in_euks.fa.gz
RUN gunzip contam_in_euks.fa.gz
RUN makeblastdb -in contam_in_euks.fa -dbtype nucl

# contam_in_prok
WORKDIR /home/ubuntu/contam-dbs/
RUN mkdir -p contam_in_prok
WORKDIR /home/ubuntu/contam-dbs/contam_in_prok/
RUN wget ftp://ftp.ncbi.nlm.nih.gov/pub/kitts/contam_in_prok.fa
RUN makeblastdb -in contam_in_prok.fa -dbtype nucl

# adaptors_for_screening_euks
WORKDIR /home/ubuntu/contam-dbs/
RUN mkdir -p adaptors_for_screening_euks
WORKDIR /home/ubuntu/contam-dbs/adaptors_for_screening_euks/
RUN wget ftp://ftp.ncbi.nlm.nih.gov/pub/kitts/adaptors_for_screening_euks.fa
RUN makeblastdb -in adaptors_for_screening_euks.fa -dbtype nucl

# adaptors_for_screening_proks
WORKDIR /home/ubuntu/contam-dbs/
RUN mkdir -p adaptors_for_screening_proks
WORKDIR /home/ubuntu/contam-dbs/adaptors_for_screening_proks/
RUN wget ftp://ftp.ncbi.nlm.nih.gov/pub/kitts/adaptors_for_screening_proks.fa
RUN makeblastdb -in adaptors_for_screening_proks.fa -dbtype nucl

# mito
WORKDIR /home/ubuntu/contam-dbs/
RUN mkdir -p mito
WORKDIR /home/ubuntu/contam-dbs/mito/
RUN wget ftp://ftp.ncbi.nlm.nih.gov/blast/db/FASTA/mito.nt.gz
RUN gunzip mito.nt.gz
RUN makeblastdb -in mito.nt -dbtype nucl

# rRNA
WORKDIR /home/ubuntu/contam-dbs/
RUN mkdir -p rrna
WORKDIR /home/ubuntu/contam-dbs/rrna/
RUN wget ftp://ftp.ncbi.nlm.nih.gov/pub/kitts/rrna.gz
RUN gunzip rrna.gz
RUN makeblastdb -in rrna -dbtype nucl

# UniVec
WORKDIR /home/ubuntu/contam-dbs/
RUN mkdir -p UniVec
WORKDIR /home/ubuntu/contam-dbs/UniVec/
RUN wget ftp://ftp.ncbi.nlm.nih.gov/pub/UniVec/UniVec 
RUN makeblastdb -in UniVec -dbtype nucl

# clone the ContaminationScreening github repo
WORKDIR /home/ubuntu
RUN GIT_COMMIT=${GIT_COMMIT} git clone https://github.com/NCBI-Hackathons/ContaminationScreen.git
RUN chmod 775 ContaminationScreen/scripts/*
RUN cp ContaminationScreen/scripts/* /home/ubuntu/bin/.


WORKDIR /home/ubuntu
CMD ["/bin/bash"]

