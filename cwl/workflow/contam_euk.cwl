#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

inputs:
  - id: sequence
    type: File

outputs:
  - id: result
    type: File
    outputSource: combine/output

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
    out: [output]

#  - id: blast_common
#    run: ../tools/blast_euk.cwl
#    in:
#      query: sequence
#    out: [output]

  - id: combine
    run: ../tools/concatenate.cwl
    in:
      input_common: filter_common/output
    out: [output]
