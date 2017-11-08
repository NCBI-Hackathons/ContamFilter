cwlVersion: v1.0
#cwlVersion: cwl:draft-3
class: CommandLineTool
hints:
  - class: DockerRequirement
    dockerPull: blast
baseCommand: VSlistTo1HitPerLine.awk
arguments: ["suspect=0", "weak=0"]
stdout: output.txt
inputs:
  - id: input_file
    type: [File]
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    outputBinding:
      glob: output.txt
