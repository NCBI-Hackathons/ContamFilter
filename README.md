# ContamFilter: Genome Contamination Screening Pipeline Implemented in CWL for External Users

## 
![ContamFilter Logo](https://raw.githubusercontent.com/NCBI-Hackathons/ContaminationScreen/master/doc/ContamFilter_Logo.png?sanitize=true)

## Introduction 
Both technical and biological contaminants may appear in raw, assembled, and annotated sequence data.  Contaminants may include ‘technical’ sequences such as vector and adapter sequence or ‘biological’ sequences derived from commensal or parasitic DNA isolated with the parent samples, or may result from mislabeling of read data. These may include mitochondrial sequence, rRNA, and can be viral, microbial, or eukaryotic derived sequence.  Legitimate (non-contaminating) may be present in genomic read data or assemblies, representing horizontal gene transfer events.

NCBI implements a contamination-screening pipeline for screening of technical and biological contamination in genomic data (Fig. 1).  The NCBI Internal implementation, called FSCR (currently at version 3.0), uses the GPipe Workflow Framwork and is implemented mainly in C++, using binary data structures (ASN.1) for improved performance. 

The goal of this project is to implement an externalized version of the pipeline and provide functionality for searches using user-defined contamination files and taxonomic subsets. This pipeline uses the Common Workflow Language (CWL) with Docker, and aims to incorporate the original algorithms in a more accessible runtime environment. 

## Planned Pipeline
![Planned workflow](https://raw.githubusercontent.com/NCBI-Hackathons/ContaminationScreen/master/doc/ContamFilter_workflow.png?sanitize=true)

## Currently Implemented Pipeline
![Currently implemented workflow](https://raw.githubusercontent.com/NCBI-Hackathons/ContaminationScreen/master/doc/graph.png?sanitize=true)

The above image was generated from the workflow in this GitHub project, via the [Common Workflow Language Viewer](https://view.commonwl.org/workflows/github.com/NCBI-Hackathons/ContamFilter/blob/master/cwl/workflow/contam_euk.cwl).

## How to run

### Installing Docker
Follow instructions to install Docker on the system: https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-docker-ce-1

```bash
# Get the ContamFilter Repo
git clone https://github.com/NCBI-Hackathons/ContamFilter.git

# Go to the docker dirctory
cd ContamFilter/docker/blast

# Build the Docker image
docker build -t blast .

# See that the Docker image is available
docker images

# Run an individual command to see if the image is working
docker run blast echo "hello!"

# Print a list of applications loaded on this image
docker run blast ls /home/ubuntu/bin/
```

### Running CWL
```bash
# Create a Python envionment with a CWL runner.
virtualenv venv
. venv/bin/activate
pip install cwlref-runner
git clone https://github.com/NCBI-Hackathons/ContamFilter.git

# Edit the input parameters to provide the path to your sequence data
vi ContamFilter/cwl/workflow/contam_euk.yml

# Run the pipeline
cwl-runner ContamFilter/cwl/workflow/contam_euk.cwl ContamFilter/cwl/workflow/contam_euk.yml
```
## Results
combined_hits.gff

```
##gff-version 3
Contig117697.1  .   region  1   37  .   .   .   Note=vecscreen_adaptors
Contig240124.2  .   region  37660   37707   .   .   .   Note=vecscreen_adaptors
Contig267453.2  .   region  5380    5428    .   .   .   Note=vecscreen_adaptors
Contig283602.1  .   region  110935  110984  .   .   .   Note=vecscreen_adaptors
Contig291655.1  .   region  47763   47805   .   .   .   Note=vecscreen_adaptors
Contig296353.2  .   region  21931   21963   .   .   .   Note=vecscreen_adaptors
Contig308584.2  .   region  4404    4441    .   .   .   Note=vecscreen_adaptors
Contig319333.1  .   region  19503   19535   .   .   .   Note=vecscreen_adaptors
Contig320691.1  .   region  9558    9590    .   .   .   Note=vecscreen_adaptors
Contig322210.1  .   region  19475   19522   .   .   .   Note=vecscreen_adaptors
Contig324115.2  .   region  10214   10246   .   .   .   Note=vecscreen_adaptors
Contig324115.2  .   region  10525   10557   .   .   .   Note=vecscreen_adaptors
Contig324115.2  .   region  63877   63921   .   .   .   Note=vecscreen_adaptors
Contig328006.2  .   region  20001   20036   .   .   .   Note=vecscreen_adaptors
Contig332010.1  .   region  37268   37303   .   .   .   Note=vecscreen_adaptors
Contig338096.1  .   region  52109   52156   .   .   .   Note=vecscreen_adaptors
Contig339890.2  .   region  2540    2575    .   .   .   Note=vecscreen_adaptors
Contig341351.1  .   region  10544   10602   100.000 .   .   Note=common_contam
Contig341351.1  .   region  10545   10602   .   .   .   Note=vecscreen_adaptors
Contig344819.2  .   region  24014   24057   .   .   .   Note=vecscreen_adaptors
Contig346119.1  .   region  7802    7859    .   .   .   Note=vecscreen_adaptors
Contig346119.1  .   region  7802    7860    100.000 .   .   Note=common_contam
Contig348759.1  .   region  51447   51496   .   .   .   Note=vecscreen_adaptors
Contig349176.2  .   region  58275   58322   .   .   .   Note=vecscreen_adaptors
Contig89794.1   .   region  21267   21299   .   .   .   Note=vecscreen_adaptors
```

## Key tasks, current roadblocks.
Current status: 
CWL set up to run BLAST using test genomic sequence dataset against reference contaminant sequence files, providing output listing putative contaminant sequence hits, representing minimum functionality of NCBI internal contamination workflow.

Contamination sequence files include:

1. a common contaminants database that contains vector sequences, bacterial insertion sequences, E. coli and phage genomes

2. a database of adaptors linkers and primers

3. a database of mitochondrial genomes

4. the chromosomes of unrelated organisms

Roadblocks: NCBI Internal pipeline C++ code and toolkit is not accessible externally; mitigated by obtaining original shell scripts.  Contamination sequence databases are not documented; creating doi's for contaminant database contents.  Input data such as chromosome sequence is very large; currently using a subset contaminant database. Implementation of Docker ongoing.

## Motivation
Implement a sequence contamination screening pipeline using Common Workflow Language (CWL) 

Why CWL:
1. An emerging standard with no clear alternative winner for workflow languages at this time.
2. Has the most backend support: 13 products aim to support CWL, at least 3 good candidates available currently.
3. CWL will provide increased accessibility for the external community.
4. A simple model of computation with files on input, files on output, command line apps, and some notions of resources (memory, CPU) for job scheduling. This model has value on its own merits.
5. Existence of tooling such as graphical editors (very new) and repositories for publishing reusable workflow components.

Caveats for CWL:
1. Inadequate documentation: reference documentation is formal to the level of being obtuse, user guide is incomplete.
2. The simple model of computation does not match well to complex orchestrated processes such as collaborating microservices.
3. Significant constraints on inputs/outputs and difficulty of interacting with databases. Example: difficulty dealing with BLAST databases. 
4. Existing repositories of workflows are anemic in content; for example, BLAST is not among the set of tools/workflow in the repositories.

Why Docker:
1. Natively supported by numerous tools, unlike alternatives such as Singularity. This may change in the future, but there is cost for delaying benefits.
2. Fine-grained isolation so we can know the dependencies of each of our processes. Compare with attempts to run GPipe pipelines in the QA environment, with months to identify what resources are needed, but NOT where they are used.
3. Reproducibility, both for reasons of scientific research and software testability.

Caveats for Docker:
1. Security concerns are valid.
2. Alternatives such as Singularity may gain traction and support in tooling, but that day is not today.

Why Contamination Screening as a tool for the external community:
1. Long-standing requests from submitters.
2. Faster feedback hence turnaround for submissions.
3. Lack of transparency: Documentation for the existing production process lacks full details and may have diverged from what is actually performed.
4. Savings on computational costs: Could use a signature to sign submissions which have been pre-screened.

Main impediments during this Hackathon:
1. The production screening pipeline is C++/ASN.1 and even basic tools are not available publicly.
3. Data objects, such as screening databases, are not available in public repositories: sequences not submitted to ID/Genbank, FASTA files are on private FTP rather than public repositories (e.g. Zenodo).
2. CWL documentation is inadequate.

Take home lessons:
1. Need to make our internal tools more accessible. Python tools are available via simple 'pip install'. The Core Toolkit is hard to install, and tools like alignment filtering/sorting/formatting (align_filter, align_sort, align_format) are not public.
2. Importance of understanding dependencies, including infrastructure dependencies.
3. Focused effort on one task. Creating a screening tool for public consumption has been long-requested task but never implemented.

References for the existing contamination process:
https://www.ncbi.nlm.nih.gov/tools/vecscreen/contam/
##
