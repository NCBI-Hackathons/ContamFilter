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

  - id: vecscreen_adaptor
    run: ../tools/vecscreen_adaptor.cwl
    in:
      query: sequence
    out: [output]
  - id: filter_adaptor
    run: ../tools/filter_adaptor.cwl
    in:
      input_file: vecscreen_adaptor/output
    out: [output]

  - id: combine
    run: ../tools/combine.cwl
    in:
      input_common: filter_common/output
      input_adaptor: filter_adaptor/output
      output_file: combined_output.gff
    out: [output]
