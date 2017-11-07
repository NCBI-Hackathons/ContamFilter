cwlVersion: v1.0
#cwlVersion: cwl:draft-3
class: CommandLineTool
baseCommand: [awk, "($3>=98.0 && $4>=50)||($3>=94.0 && $4>=100)||($3>=90.0 && $4>=200)"]
inputs:
  - id: input_file
    type: [File]
    inputBinding:
      position: 1
outputs: []
