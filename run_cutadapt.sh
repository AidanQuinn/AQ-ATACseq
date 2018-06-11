#!/bin/bash

cd /data/scratch/2018/20180606_NMe_ATACseq_LB

for s in `cat ./samples.txt`; do
    echo "Trimming Nextera Transposase Adapters for ${s}:"
    cutadapt \
        -j 20 \
        -a CTGTCTCTTATACACATCTGACGCTGCCGACGA \
        -A CTGTCTCTTATACACATCTCCGAGCCCACGAGAC \
        -o ./fastq/${s}_trimmed_R1.fastq.gz -p ./fastq/${s}_trimmed_R2.fastq.gz \
        ./fastq/${s}_1.fastq.gz ./fastq/${s}_1.fastq.gz
done
