check_consistency <- function(df_list) {
  # Get the column names and types of the first data frame
  col_names <- names(df_list[[1]])
  col_types <- sapply(df_list[[1]], class)
  # Check if the column names and types are consistent in all data frames
  for (i in 2:length(df_list)) {
    if (!identical(col_names, names(df_list[[i]])) ||
        !identical(col_types, sapply(df_list[[i]], class))) {
      return(FALSE)
    }
  }
  return(TRUE)
}


# Check the structure of data
get_data_str <- function(dataframe) {
  capture.output(str(dataframe, max.level = 1))
}
