cwlVersion: cwl:draft-3
class: CommandLineTool
hints:
  - class: DockerRequirement
    dockerPull: blast
baseCommand: vecscreen
arguments: ["-f3"]
inputs:
  - id: database
    type: string
    inputBinding:
      position: 1
      prefix: -d
  - id: query
    type: File
    inputBinding:
      position: 2
      prefix: -i
  - id: outputfile
    type: string
    inputBinding:
      position: 3
      prefix: -o
outputs:
  - id: output
    type: File
    outputBinding:
      glob: $(inputs.outputfile)

