cwlVersion: cwl:draft-3
class: CommandLineTool
hints:
  - class: DockerRequirement
    dockerPull: blast
baseCommand: blastn
arguments: ["-db", "/home/ubuntu/contam-dbs/contam_in_euks/contam_in_euks.fa", "-outfmt", "6", "-best_hit_overhang", "0.1", "-best_hit_score_edge", "0.1", "-dust", "yes", "-evalue", "1E-9", "-gapextend", "2", "-gapopen", "4", "-penalty", "-4", "-perc_identity", "95", "-reward", "3", "-soft_masking", "true", "-task", "megablast", "-template_length", "18", "-template_type", "coding", "-window_size", "120", "-word_size", "12", "-xdrop_gap", "20", "-no_greedy"]
stdout: output.txt
inputs:
  - id: query
    type: File
    inputBinding:
      position: 2
      prefix: -query

outputs:
  - id: output
    type: File
    outputBinding:
      glob: output.txt
