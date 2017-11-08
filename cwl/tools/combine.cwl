cwlVersion: v1.0
#cwlVersion: cwl:draft-3
class: CommandLineTool
hints:
  - class: DockerRequirement
    dockerPull: blast
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
  - id: input_mito
    type: [File]
    inputBinding:
      position: 3
      prefix: --mitos
outputs:
  - id: output
    type: File
    outputBinding:
      glob: "combined_hits.gff"
