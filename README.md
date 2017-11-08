# ContamFilter: Genome Contamination Screening Pipeline Implemented in CWL for External Users

## 
![Alt diagram](https://raw.githubusercontent.com/NCBI-Hackathons/ContaminationScreen/master/doc/ContamFilter_Logo.png?sanitize=true)
## Link to DOI

## Introduction 
Both technical and biological contaminants may appear in raw, assembled, and annotated sequence data.  Contaminants may include ‘technical’ sequences such as vector and adapter sequence or ‘biological’ sequences derived from commensal or parasitic DNA isolated with the parent samples, or may result from mislabeling of read data. These may include mitochondrial sequence, rRNA, and can be viral, microbial, or eukaryotic derived sequence.  Legitimate (non-contaminating) may be present in genomic read data or assemblies, representing horizontal gene transfer events.

NCBI implements a contamination-screening pipeline for screening of technical and biological contamination in genomic data  (Fig. 1).  Internal implementation uses Gpipe (FSCR 3.0), C++. 

The goal of this project is to implement an externalized version of the pipeline and provide functionality for searches using user-defined contamination files and taxonomic subsets. Pipeline uses Common Workflow Language (CWL) with Docker, incorporating the original . 

##
![Alt diagram](https://raw.githubusercontent.com/NCBI-Hackathons/ContaminationScreen/master/doc/ContamFilter_Workflow.png?sanitize=true)


## Key tasks, current roadblocks.
Current status: 
CWL set up to run BLAST using test genomic sequence dataset against reference contaminant sequence files, providing output listing putative contaminant sequence hits, representing minimum functionality of NCBI internal contamination workflow.

Contamination sequence files include:

1. a common contaminants database that contains vector sequences, bacterial insertion sequences, E. coli and phage genomes

2. a database of adaptors linkers and primers

3. a database of mitochondrial genomes

4. the chromosomes of unrelated organisms

Roadblocks: NCBI Internal pipeline C++ code and toolkit is not accessible externally; mitigated by obtaining original shell scripts.  Contamination sequence databases are not documented; creating doi's for contaminant database contents.  Input data such as chromosome sequence is very large; currently using a subset contaminant database. Implementation of Docker ongoing.

Overview Diagram

# How to use <this software>

## Installation options:

We provide two options for installing <this software>: Docker or directly from Github.

### Docker

The Docker image contains <this software> as well as a webserver and FTP server in case you want to deploy the FTP server. It does also contain a web server for testing the <this software> main website (but should only be used for debug purposes).

1. `docker pull ncbihackathons/<this software>` command to pull the image from the DockerHub
2. `docker run ncbihackathons/<this software>` Run the docker image from the master shell script
3. Edit the configuration files as below

### Installing <this software> from Github

1. `git clone https://github.com/NCBI-Hackathons/<this software>.git`
2. Edit the configuration files as below
3. `sh server/<this software>.sh` to test
4. Add cron job as required (to execute <this software>.sh script)

### Configuration

```Examples here```

# Testing

We tested four different tools with <this software>. They can be found in [server/tools/](server/tools/) . 

# Additional Functionality

### DockerFile

<this software> comes with a Dockerfile which can be used to build the Docker image.

  1. `git clone https://github.com/NCBI-Hackathons/<this software>.git`
  2. `cd server`
  3. `docker build --rm -t <this software>/<this software> .`
  4. `docker run -t -i <this software>/<this software>`
  
### Website

There is also a Docker image for hosting the main website. This should only be used for debug purposes.

  1. `git clone https://github.com/NCBI-Hackathons/<this software>.git`
  2. `cd Website`
  3. `docker build --rm -t <this software>/website .`
  4. `docker run -t -i <this software>/website`
  
![Alt diagram](https://raw.githubusercontent.com/NCBI-Hackathons/ContaminationScreen/master/doc/contam.svg?sanitize=true)

