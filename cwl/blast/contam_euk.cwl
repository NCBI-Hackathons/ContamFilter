#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

inputs:
  - id: genome
    type: File

outputs:
  - id: result
    type: File
    outputSource: blast_euk/output

hints:
  - class: DockerRequirement
    dockerPull: blast

steps:
  - id: blast_euk
    run: blast.cwl
    in:
      query: genome
    out: [output]
