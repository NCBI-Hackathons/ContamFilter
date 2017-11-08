cwlVersion: v1.0
class: CommandLineTool
baseCommand: [awk, "$4>=120"]
stdout: awk_output.txt
inputs:
  - id: input_file
    type: [File]
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    outputBinding:
      glob: awk_output.txt
