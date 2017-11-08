# ContamFilter: Genome Contamination Screening Pipeline Implemented in CWL for External Users

## 
![ContamFilter Logo](https://raw.githubusercontent.com/NCBI-Hackathons/ContaminationScreen/master/doc/ContamFilter_Logo.png?sanitize=true)

## Introduction 
Both technical and biological contaminants may appear in raw, assembled, and annotated sequence data.  Contaminants may include ‘technical’ sequences such as vector and adapter sequence or ‘biological’ sequences derived from commensal or parasitic DNA isolated with the parent samples, or may result from mislabeling of read data. These may include mitochondrial sequence, rRNA, and can be viral, microbial, or eukaryotic derived sequence.  Legitimate (non-contaminating) may be present in genomic read data or assemblies, representing horizontal gene transfer events.

NCBI implements a contamination-screening pipeline for screening of technical and biological contamination in genomic data  (Fig. 1).  Internal implementation uses Gpipe (FSCR 3.0), C++. 

The goal of this project is to implement an externalized version of the pipeline and provide functionality for searches using user-defined contamination files and taxonomic subsets. Pipeline uses Common Workflow Language (CWL) with Docker, incorporating the original . 

## Planned Pipeline
![Planned workflow](https://raw.githubusercontent.com/NCBI-Hackathons/ContaminationScreen/master/doc/ContamFilter_workflow.png?sanitize=true)

## Currently Implemented Pipeline
![Currently implemented workflow](https://raw.githubusercontent.com/NCBI-Hackathons/ContaminationScreen/master/doc/graph.png?sanitize=true)
The above image was generated from the workflow in this GitHub project, via [ViewCWL](https://view.commonwl.org/workflows/github.com/NCBI-Hackathons/ContaminationScreen/blob/master/cwl/workflow/contam_euk.cwl).

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
