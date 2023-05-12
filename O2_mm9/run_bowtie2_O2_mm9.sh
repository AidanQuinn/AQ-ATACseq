#!/bin/bash
#SBATCH -c 8                    	# Request num cores
#SBATCH -t 0-04:00            		# Runtime in D-HH:MM format
#SBATCH -p short             		# Partition to run in
#SBATCH --mem=6G                	# Memory total in GB (for all cores)
#SBATCH -o Run_Bowtie2_%A_%a.out        # File to which STDOUT will be written, including job ID (%j)
#SBATCH -e Run_Bowtie2_%A_%a.err        # File to which STDERR will be written, including job ID (%j)
#SBATCH --mail-user=StuartAi@BroadInstitute.org
#SBATCH --mail-type=ALL
#SBATCH --array=1-6

#####################################################################################################
# User params:

WORKING_DIR="/n/data1/dfci/pedonc/kadoch/Aidan/202304_mOrg_Brca1_ATAC_reExp"
IN_DIR="${WORKING_DIR}/fastq_trimmed"
OUT_DIR="${WORKING_DIR}/aligned"
SAMPLE_SHEET="${WORKING_DIR}/scripts/samples.txt"
GENOME_REF="/n/data1/dfci/pedonc/kadoch/alignmentScripts/bowtie/bt2_mm9/mm9"

####################################################################################################
# Set working directory
cd ${WORKING_DIR}

module load gcc/6.2.0 python/2.7.12
module load samtools/0.1.19
module load bowtie2/2.2.9

# Get sample name from sample sheet
SAMPLE=$(cat "${SAMPLE_SHEET}" | sed -n "${SLURM_ARRAY_TASK_ID}"p)

bowtie2 \
	--threads 8 \
        --very-sensitive \
        --maxins 2000 \
        --no-discordant \
        --no-mixed \
        -x $GENOME_REF \
        -1 ${IN_DIR}/${SAMPLE}_trimmed_R1.fq.gz \
        -2 ${IN_DIR}/${SAMPLE}_trimmed_R2.fq.gz | samtools view -bS - -o ${OUT_DIR}/${SAMPLE}_mm9.bam
