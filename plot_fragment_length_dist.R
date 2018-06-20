# 2018-06-20
# Aidan Quinn
#
# Script to generate aggregated fragment length plots
# run in fragment length directoy
# only files in dir (ending in .txt) should be histogram data

require(reshape2)
require(ggplot2)

# Read all files in the WD ending in txt
files <- list.files(".", pattern = ".txt")
samples <- vapply(strsplit(files, "_"), `[`, 1, FUN.VALUE=character(1))

# Function to read files & return vector from histo files
process_frag_len <- function(sample_name){
  t <- read.table(
    list.files(".", pattern = glob2rx(paste0(sample_name, "*.txt")))[1], 
    header = T, skip = 10)
  colnames(t) <- c("size", sample_name)
  return(t[,2])
}

# Aggregate vectors
histo_data <- sapply(samples, process_frag_len, USE.NAMES = T)
lengths <- unlist(lapply(histo_data, length))
histo_data <- melt(histo_data)
length_vector <- c()
for(i in lengths){
  length_vector <- c(length_vector, 27:(i+26))
}
histo_data <- cbind.data.frame(histo_data, fragment_size=length_vector)
colnames(histo_data) <- c("value", "sample", "fragment_size")

# Plot
p <- ggplot(
  histo_data, aes(x = fragment_size, y = value)
)
p + geom_line(aes(col = sample)) + 
  theme_light() + 
  labs(
    x ="Fragment Size",
    y = "Total Fragments",
    color = "Sample") +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

