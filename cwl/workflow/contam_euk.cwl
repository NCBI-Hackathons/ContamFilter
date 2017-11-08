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

  - id: blast_mito
    run: ../tools/blast_mito.cwl
    in:
      query: sequence
    out: [output]
  - id: filter_mito
    run: ../tools/filter_mito.cwl
    in:
      input_file: blast_mito/output
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
      input_mito: filter_mito/output
      input_adaptor: filter_adaptor/output
    out: [output]
