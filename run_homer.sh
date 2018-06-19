#!/bin/bash

cd /data/scratch/2018/20180612_NMe_ATACseq_LB

bam_dir="/data/scratch/2018/20180612_NMe_ATACseq_LB/aligned"
tag_dir="/data/scratch/2018/20180612_NMe_ATACseq_LB/tagDir"

for s in `cat ./samples.txt`; do
    echo "Generating Tag Directories"
    makeTagDirectory \
        ${tag_dir}/${s} \
        ${bam_dir}/${s}_mm10_nsorted_fixed_dedup_psorted.bam &
done

wait
echo "done making tag directories"

# Normalize and generate UCSC tracks (bedgraph) 
echo "Generating UCSC files (normalizing coverage)"
for s in `cat ./samples.txt`; do
    echo "Generating Tag Directories"
    makeUCSCfile \
        ${tag_dir}/${s} \
        -skipChr chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 chr13 chr14 chr16 chr17 chr18 chr19 chr20 chrM chrX chrY \
        -o ./UCSCfiles/${s}_mm10_chr15 &
done

wait
echo "done with UCSC file generation"
