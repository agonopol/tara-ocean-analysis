class: Workflow
cwlVersion: v1.0
id: protein_search
label: protein-search
inputs:
  - id: directory
    type: Directory
    inputBinding:
      position: 0
outputs: []
steps:
  - id: ls
    in:
      - id: directory
        source: directory
    out:
      - id: files
    run: utils/ls.cwl
    doc: fasta inputs
  - id: fasta_db
    scatter: [fasta]
    scatterMethod: dotproduct
    in:
      - id: fasta
        source: ls/files
    out:
      - id: translated
    run: fasta-translate/fasta-db.cwl
requirements: 
  - class: ScatterFeatureRequirement
