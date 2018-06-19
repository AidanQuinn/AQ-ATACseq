#!/bin/bash

cd /data/scratch/2018/20180612_NMe_ATACseq_LB

data_dir="/data/scratch/2018/20180612_NMe_ATACseq_LB/fastq"
out_dir="/data/scratch/2018/20180612_NMe_ATACseq_LB/aligned"
mm10="/data/shares/ref/bowtie2/mm10/mm10"

for s in `cat ./samples.txt`; do
    echo "Aligning ${s}"
    bowtie2 \
        --threads 24 \
        --very-sensitive \
        --maxins 2000 \
        --no-discordant \
        --no-mixed \
        -x $mm10 \
        -1 ${data_dir}/${s}_trimmed_R1.fastq.gz \
        -2 ${data_dir}/${s}_trimmed_R2.fastq.gz | samtools view -bS - -o ${out_dir}/${s}_mm10.bam
done
