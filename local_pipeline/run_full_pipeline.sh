#!/bin/bash

date
echo "Running AQ-ATAC Pipeline on LB NMe in /data/scratch/2018/20180612_NMe_ATACseq_LB"
cd "/data/scratch/2018/20180612_NMe_ATACseq_LB/scripts"
echo ""
echo ""

date
echo "Running Cutadapt (step 1 of 4):"
./run_cutadapt.sh
echo ""


date 
echo "Running bowtie2 align (step 2 of 4):"
./run_bowtie2.sh
echo ""


date
echo "Running samtools cleanup (step 3 of 4):"
./run_samtools_clean.sh
echo ""

date
echo "Running fragLenDist (step 4 of 4):"
./run_fragLen_dist.sh
echo ""

date
echo "Running MACS2 for peaks and pileup"
./run_MACS.sh
echo "AQ-ATAC pipeline finished."
