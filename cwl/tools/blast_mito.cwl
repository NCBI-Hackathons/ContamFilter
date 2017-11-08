cwlVersion: v1.0
class: CommandLineTool
hints:
  - class: DockerRequirement
    dockerPull: blast
baseCommand: blastn
arguments: ["-db", "/home/ubuntu/contam-dbs/mito/mito.nt", "-dust", "yes", "-soft_masking", "true", "-perc_identity", "98.6", "-outfmt", "6"]
stdout: output.txt
inputs:
  - id: query
    type: File
    inputBinding:
      position: 1
      prefix: -query

outputs:
  - id: output
    type: File
    outputBinding:
      glob: output.txt
