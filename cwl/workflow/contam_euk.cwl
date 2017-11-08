#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

inputs:
  - id: sequence
    type: File

outputs:
  - id: result
    type: File
    outputSource: filter_common/filtered_hits

steps:
  - id: blast_common
    run: ../tools/blast_euk.cwl
    in:
      query: sequence
    out: [output]
  - id: filter_common
    run: ../tools/filter_common.cwl
    in:
      input_file: blast_common/output
    out: [filtered_hits]
