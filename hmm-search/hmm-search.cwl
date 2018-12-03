class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - hmmsearch
inputs:
  - id: fasta
    type: File
    inputBinding:
      position: 2
  - id: hmm
    type: File
    inputBinding:
      position: 1
outputs:
  - id: domtblout
    type: File
    outputBinding:
      glob: '*.domtbl'
arguments:
  - position: 0
    prefix: '--domtblout'
    valueFrom: $(inputs.fasta.basename).domtbl
hints:
  - class: DockerRequirement
    dockerPull: 'git.imp.fu-berlin.de:5000/bzfgonop/tara-ocean-analysis/hmm-search'
