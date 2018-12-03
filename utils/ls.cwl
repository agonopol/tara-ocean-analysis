class: CommandLineTool
cwlVersion: v1.0
id: ls
requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.directory)
      - entry: $(inputs.directory)
        entryname: $(inputs.directory.basename)
        writable: true
baseCommand:
  - ls
inputs:
  - id: directory
    type: Directory
    inputBinding:
      position: 0
outputs:
  - id: files
    type: 'File[]?'
    outputBinding:
      glob: $(inputs.directory.path)/*.fasta.gz
