#!/bin/bash

cd /data/scratch/2018/20181022_Phf6_HSPC_ATACseq_AW

for s in `cat ./samples.txt`; do
    echo "Cleaning up alignment ${s}:"
    # sort by name
    echo "Sorting ${s}..."
    samtools sort -n -@ 10 -m 10G -o ./aligned/${s}_mm10_nsorted.bam ./aligned/${s}_mm10.bam
    echo "Fixing mate-pair flags ${s}..."
    samtools fixmate -@ 23 -r ./aligned/${s}_mm10_nsorted.bam ./aligned/${s}_mm10_nsorted_fixed.bam
    echo "Rmoving PCR duplicates ${s}..."
    samtools rmdup -S ./aligned/${s}_mm10_nsorted_fixed.bam ./aligned/${s}_mm10_nsorted_fixed_dedup.bam
    echo "Sorting by coordinate ${s}..."
    samtools sort -@ 10 -m 10G -o ./aligned/${s}_mm10_nsorted_fixed_dedup_psorted.bam ./aligned/${s}_mm10_nsorted_fixed_dedup.bam
    if [ -e ./aligned/${s}_mm10_nsorted_fixed_dedup.bam ]; then
        echo "Removing intermediate files ${s}..."
        rm -f ./aligned/${s}_mm10_nsorted.bam
        rm -f ./aligned/${s}_mm10_nsorted_fixed.bam
        rm -f ./aligned/${s}_mm10_nsorted_fixed_dedup.bam
        echo "Indexing ${s}_mm10_nsorted_fixed_dedup_psorted.bam..."
        samtools index -@ 23 ./aligned/${s}_mm10_nsorted_fixed_dedup_psorted.bam
    else
        echo "Failed to create files, removed nothing. Check logs."
    fi
done
