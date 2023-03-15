# Load the dplyr package
library("dplyr")

# Get working directory
current_dir <- getwd()

# Set the path to the folder containing data files
folder_path <- file.path(current_dir, "data")

# Get a list of all the .csv files in that folder
file_list <- list.files(folder_path, pattern = "*.csv")

df_names <- c() # Create an empty vector to store data frame names

# Loop through each file and save them as data frames
for (i in seq_along(file_list)) {
    # Get the full path of the current file
    file_path <- file.path(folder_path, file_list[i])

    # Extract year and month from the file name
    year_part <- substr(file_list[i], 1, 4)
    month_part <- substr(file_list[i], 5, 6)
    # Create a name for the data frame
    df_name <- paste("df", year_part, month_part, sep = "_")
    # Read the CSV file and save it as a data frame with the given name
    assign(df_name, read.csv(file_path))
    # Add the name of the new data frame to the vector
    df_names[i] <- df_name
}

# Define a function that checks if all data frames have the same column names
compare_colnames <- function(names) {
  # Get the column names of each data frame and store them in a list
  col_names_list <- lapply(names,
    function(x) colnames(get(x)))
  # Check if all the column names are identical
  all_identical <- all(sapply(2:length(col_names_list),
    function(i) identical(col_names_list[[1]], col_names_list[[i]])))
  # Return the result
  return(all_identical)
}
# Check if all data frames have the same column names
colnames_match <- compare_colnames(df_names)

if (colnames_match) {
  # Get all the data frames and store them in a list
  df_list <- lapply(df_names, function(x) get(x))
  # Combine all data frames into one using dplyr's bind_rows function
  merged_df <- bind_rows(df_list)
}

# Remove the unnecessary columns, which will not be helpful on our analysis
unnecessary_columns <- c("ride_id", "start_station_name", "start_station_id",
  "end_station_name", "end_station_id")

merged_df <- select(merged_df, -all_of(unnecessary_columns))

write.csv(merged_df, "merged_data.csv", row.names = FALSE)
