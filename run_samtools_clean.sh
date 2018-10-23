#!/bin/bash

cd /data/scratch/2018/20180612_NMe_ATACseq_LB

for s in `cat ./samples.txt`; do
    echo "Cleaning up alignment ${s}:"
    # sort by name
    echo "Sorting ${s}..."
    samtools sort -n -@ 24 -m 10G -o ./aligned/${s}_mm10_nsorted.bam ./aligned/${s}_mm10.bam
    echo "Fixing mate-pair flags ${s}..."
    samtools fixmate -@ 24 -r ./aligned/${s}_mm10_nsorted.bam ./aligned/${s}_mm10_nsorted_fixed.bam
    echo "Rmoving PCR duplicates ${s}..."
    samtools rmdup -S ./aligned/${s}_mm10_nsorted_fixed.bam ./aligned/${s}_mm10_nsorted_fixed_dedup.bam
    echo "Sorting by coordinate ${s}..."
    samtools sort -@ 24 -m 10G -o ./aligned/${s}_mm10_nsorted_fixed_dedup_psorted.bam ./aligned/${s}_mm10_nsorted_fixed_dedup.bam
    echo "Removing intermediate files ${s}..."
    rm -f ./aligned/${s}_mm10.bam
    rm -f ./aligned/${s}_mm10_nsorted.bam
    rm -f ./aligned/${s}_mm10_nsorted_fixed.bam
    rm -f ./aligned/${s}_mm10_nsorted_fixed_dedup.bam
    echo "Indexing ${s}_mm10_nsorted_fixed_dedup_psorted.bam..."
    samtools index ./aligned/${s}_mm10_nsorted_fixed_dedup_psorted.bam
done
