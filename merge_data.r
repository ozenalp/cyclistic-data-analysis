# Load the dplyr package
library(tidyverse)
source("functions.R")

# Set the path to the folder containing data files
folder_path <- file.path(getwd(), "data")

# Get a list of all the .csv files in that folder
file_list <- list.files(folder_path, pattern = "*.csv")

# Read in all CSV files and store them in a list
df_list <- file_list %>%
  map(~ read_csv(file.path(folder_path, .)))
# Check if all data frames have the same column names
colnames_and_types_match <- check_consistency(df_list)

if (colnames_and_types_match) {
  # Combine all data frames into one using dplyr's bind_rows function
  merged_df <- bind_rows(df_list)
  write_csv(merged_df, "merged_data.csv", progress = show_progress())
}