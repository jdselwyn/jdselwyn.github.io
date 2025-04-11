library(tidyverse)
library(qpdf)

# Directory containing the PDF files
pdf_dir <- getwd()
output_dir <- file.path(pdf_dir, "First Pages")

# Create output directory if it doesn't exist
if (!dir.exists(output_dir)) dir.create(output_dir)

# List all PDF files in the directory
pdf_files <- list.files(pdf_dir, pattern = "\\.pdf$", full.names = TRUE) %>%
  str_subset('CV', negate = TRUE) %>%
  str_subset('Dissertation|Thesis', negate = TRUE)

# Extract first page from each PDF
for (pdf in pdf_files) {
  output_pdf <- file.path(output_dir, paste0(tools::file_path_sans_ext(basename(pdf)), "_firstpage.pdf"))
  
  pdf_subset(input = pdf, 
             pages = 1, 
             output = output_pdf)
  
  cat("Saved first page of", basename(pdf), "as", basename(output_pdf), "\n")
}
