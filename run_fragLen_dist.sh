#!/bin/bash

cd /data/scratch/2018/20180612_NMe_ATACseq_LB

mkdir /data/scratch/2018/20180612_NMe_ATACseq_LB/fragLenDist

for s in `cat ./samples.txt`; do
    echo "Computing fragment length distribution ${s}:"
    # picard collect insert sizes
    java -Xmx10g -jar /data/shares/bin/picard.jar \
        CollectInsertSizeMetrics \
        I=./aligned/${s}_mm10_nsorted_fixed_dedup_psorted.bam \
        O=./fragLenDist/${s}_mm10_nsorted_fixed_dedup_psorted.txt \
        H=./fragLenDist/${s}_mm10_nsorted_fixed_dedup_psorted.pdf
done
