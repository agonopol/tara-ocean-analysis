class: Workflow
cwlVersion: v1.0
id: protein_search
label: protein-search
inputs:
  - id: fasta
    type: File
  - id: hmm
    type: File
outputs: []
steps:
  - id: fasta_db
    in:
      - id: fasta
    out:
      - id: translated
    run: fasta-translate/fasta-db.cwl
  - id: hmm_search
    in:
      - id: fasta
        source: fasta_db/translated
      - id: hmm
        source: hmm
    out:
      - id: domtblout
    run: hmm-search/hmm-search.cwl
  - id: hmm_html_report
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
