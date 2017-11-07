cwlVersion: cwl:draft-3
class: CommandLineTool
hints:
  - class: DockerRequirement
    dockerPull: blast
baseCommand: vecscreen
arguments: ["-d", "/home/ubuntu/contam-dbs/adaptors_for_screening_euks/adaptors_for_screening_euks.fa", "-f3"]
inputs:
  - id: query
    type: File
    inputBinding:
      position: 1
      prefix: -i

outputs:
  - id: output
    type: File
    outputBinding:
      position: 2
      glob: output.txt
      prefix: -o
