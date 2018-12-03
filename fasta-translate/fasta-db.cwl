#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: /opt/app/translate.py
requirements:
  EnvVarRequirement:
    envDef:
      PYTHONPATH: /biopython
hints:
  DockerRequirement:
    dockerPull: git.imp.fu-berlin.de:5000/bzfgonop/tara-ocean-analysis/fasta-translate
inputs:
  fasta:
    type: File
    inputBinding:
      prefix: --fasta
outputs:
  translated:
    type: File    
    outputBinding:
      glob:  *.db.fasta
stdout: stdout.txt
