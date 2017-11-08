cwlVersion: v1.0
class: CommandLineTool
baseCommand: cat
stdout: output.txt
inputs:
  - id: input_common
    type: [File]
    inputBinding:
      position: 1
  - id: input_mito
    type: [File]
    inputBinding:
      position: 2
  - id: input_adaptor
    type: [File]
    inputBinding:
      position: 3
outputs:
  - id: output
    type: File
    outputBinding:
      glob: output.txt
