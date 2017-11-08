cwlVersion: v1.0
#cwlVersion: cwl:draft-3
class: CommandLineTool
baseCommand: combine_results.py
inputs:
  - id: input_common
    type: [File]
    inputBinding:
      position: 1
      prefix: --common_contam
  - id: input_adaptor
    type: [File]
    inputBinding:
      position: 2
      prefix: --vecscreen_adaptor
outputs:
  - id: output
    type: File
    outputBinding:
      glob: "output.gff"
