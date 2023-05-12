#!/bin/bash

cd /data/scratch/2018/20180612_NMe_ATACseq_LB

bam_dir="/data/scratch/2018/20180612_NMe_ATACseq_LB/aligned"
out_dir="/data/scratch/2018/20180612_NMe_ATACseq_LB/macs_out"

echo "Running MACS2 in BAMPE mode with SPMR pileup generation"

for s in `cat ./samples.txt`; do
    echo "Running MACS2 for sample: ${s}"
    macs2 callpeak \
        -t ${bam_dir}/${s}_mm10_nsorted_fixed_dedup_psorted.bam \
        -f BAMPE \
        -g mm \
        --outdir ${out_dir} \
        --name ${s} \
        --SPMR &
done
wait
echo "done running MACS2"


