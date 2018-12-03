class: Workflow
cwlVersion: v1.0
id: protein_search
label: protein-search
inputs:
  - id: directory
    type: Directory
    inputBinding:
      position: 0
  - id: hmm
    type: File
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
    in:
      - id: fasta
        source: ls/files
    out:
      - id: translated
    run: fasta-translate/fasta-db.cwl
    scatterMethod: dotproduct
    scatter: [fasta]
  - id: hmm_search
    in:
      - id: fasta
        source: fasta_db/translated
      - id: hmm
        source: hmm
    out:
      - id: domtblout
    run: hmm-search/hmm-search.cwl
    scatter:
      - fasta
    scatterMethod: dotproduct
  - id: hmm_html_report
    scatter:
      - fasta
      - table
    scatterMethod: dotproduct
    in:
      - id: fasta
        source: fasta_db/translated
      - id: table
        source: hmm_search/domtblout
    out:
      - id: html
    run: hmm-html-report/hmm-html-report.cwl
requirements:
  - class: ScatterFeatureRequirement
