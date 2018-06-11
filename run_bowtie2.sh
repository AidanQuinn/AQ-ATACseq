#!/bin/bash

cd /data/scratch/2018/20180606_NMe_ATACseq_LB

data_dir="/data/scratch/2018/20180606_NMe_ATACseq_LB/fastq"
out_dir="/data/scratch/2018/20180606_NMe_ATACseq_LB/aligned"
hg38="/data/shares/ref/bowtie2/hg38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.bowtie_index"



for s in `cat ./samples.txt`; do
    echo "Aligning ${s}"
    bowtie2 \
        --threads 24 \
        --very-sensitive \
        --maxins 2000 \
        --no-discordant \
        --no-mixed \
        -x $hg38 \
        -1 ${data_dir}/${s}_trimmed_R1.fastq.gz \
        -2 ${data_dir}/${s}_trimmed_R2.fastq.gz | samtools view -bS - -o ${out_dir}/${s}_hg38_sorted.bam
done
