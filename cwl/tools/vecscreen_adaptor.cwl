cwlVersion: cwl:draft-3
class: CommandLineTool
hints:
  - class: DockerRequirement
    dockerPull: blast
baseCommand: vecscreen
arguments: ["-f3", "-d", "/home/ubuntu/contam-dbs/adaptors_for_screening_euks/adaptors_for_screening_euks.fa"]
stdout: output.txt
inputs:
  - id: query
    type: File
    inputBinding:
      position: 2
      prefix: -i
outputs:
  - id: output
    type: File
    outputBinding:
      glob: output.txt

