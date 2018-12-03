class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - /opt/app/parser.py
inputs:
  - id: fasta
    type: File
    inputBinding:
      position: 0
      prefix: '-d'
  - id: table
    type: File
    inputBinding:
      position: 0
      prefix: '-r'
outputs:
  - id: html
    type: File
    outputBinding:
      glob: $(inputs.fasta.basename).report.html
arguments:
  - position: 0
    prefix: '-o'
    valueFrom: $(inputs.fasta.basename).report.html
hints:
  - class: DockerRequirement
    dockerPull: 'git.imp.fu-berlin.de:5000/bzfgonop/hmm-docker-cwl/hmm-html-report'
requirements:
  - class: InlineJavascriptRequirement
