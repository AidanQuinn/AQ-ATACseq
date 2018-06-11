################################################################################
# 2018-06-11                                                       Aidan Quinn #
# Pipeline for ATACseq data analysis                                           #
#                                                                              #
# Inputs:                                                                      #
#   (1) fastq files (paird-ed format)                                          #
#                                                                              #
# Outputs:                                                                     #
#   (1) aligned, sorted bam files                                              #
#   (2) QC report (PCRdup/alignment rate ...)                                  #
#   (3) fragment length distribution                                           #
#   (3) open-chromatin peaks w/ scores (Homer)                                 #
#                                                                              #
################################################################################

# Collect vars needed for shell scripts:
working_dir     <- "" # get from cmd line / parameters sheet

genome_name     <- "" # get from cmd line / parameters sheet
genome_dir      <- "" # get from cmd line / parameters sheet

sample_sheet    <- "" # get from cmd line / parameters sheet
samples         <- sample_sheet[,1]

aligned_out_dir <- paste0(working_dir, "/aligned")


# Run bowtie2 alignment:
bowtie2 <- paste(
  "./scripts/run_bowtie2", 
  samples
)
sys.call(bowtie2)


