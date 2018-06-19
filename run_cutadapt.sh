#!/bin/bash

cd /data/scratch/2018/20180612_NMe_ATACseq_LB

for s in `cat ./samples.txt`; do
    echo "Trimming Nextera Transposase Adapters for ${s}:"
    cutadapt \
        -j 20 \
        -a CTGTCTCTTATACACATCTCCGAGCCCACGAGACTA \
        -A CTGTCTCTTATACACATCTGACGCTGCCGACGAGT \
        --minimum-length=30 --pair-filter=both \
        -o ./fastq/${s}_trimmed_R1.fastq.gz -p ./fastq/${s}_trimmed_R2.fastq.gz \
        ./fastq/${s}_R1.fastq.gz ./fastq/${s}_R2.fastq.gz
done
