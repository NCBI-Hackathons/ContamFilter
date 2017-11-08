#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

inputs:
  - id: genome
    type: File

outputs:
  - id: result
    type: File
    outputSource: filter/filtered_hits

steps:
  - id: blast_euk
    run: ../tools/blast.cwl
    in:
      query: genome
    out: [output]
  - id: filter
    run: ../tools/awk.cwl
    in:
      input_file: blast_euk/output
    out: [filtered_hits]
