#!/usr/local/bin/python

import os, warnings, argparse, gzip, tqdm, xphyle
from Bio import SeqIO
from sys import argv
from Bio.Seq import Seq
from mimetypes import guess_type
from functools import partial
from xphyle import xopen

xphyle.configure(progress=True)
xphyle.configure(threads=4)

def rreplace(s, old, new, occurrence):
    li = s.rsplit(old, occurrence)
    return new.join(li)

def translate(fasta):
    dbf = os.path.basename( rreplace(fasta, 'fasta', 'fasta.db', 1 ) )
    print('Translating...')
    with xopen(dbf, 'wt') as db:
        parser = SeqIO.parse(xopen(fasta, 'rt'), 'fasta')
        for sequence in parser:
            id, seq = sequence.description, Seq(str(sequence.seq).upper().replace('X', 'N'))
            f = (-3,-2,-1,1,2,3)
            for i in f:
                if i < 0:
                    db.write('>%s\n%s\n'%('%s_%d'%(id,i), seq.reverse_complement()[-(i+1):].translate(stop_symbol='X')))
                elif i > 0:
                    db.write('>%s\n%s\n'%('%s_+%d'%(id,i), seq[i-1:].translate(stop_symbol='X')))


if __name__ == '__main__':
    warnings.filterwarnings('ignore')
    parser = argparse.ArgumentParser(description='Translate .fasta file to fasta-db.')
    parser.add_argument('--fasta', help='input fasta file', required=True)
    args = parser.parse_args()
    translate( args.fasta )