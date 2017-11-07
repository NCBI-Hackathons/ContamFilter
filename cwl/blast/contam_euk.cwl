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

hints:
  - class: DockerRequirement
    dockerPull: blast

steps:
  - id: blast_euk
    run: blast.cwl
    in:
      query: genome
    out: [output]
  - id: filter
    run: awk.cwl
    in:
      input_file: blast_euk/output
    out: [filtered_hits]
