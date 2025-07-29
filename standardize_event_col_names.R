library(dplyr)
library(rlang)

fxn_fix_column_names <- function(df) {
  # Known substitutions: incorrect or alternate names → correct names
  fix_map <- c(
    BIRTH = "BDAT",
    FRSH = "FDAT",
    CBRD = 'BREED',
    DDAT = 'DRYDT',
    PODAT = 'PGCK',
    DIM = 'DNM'
    # Add other known substitutions here as needed
  )
  
  # Create renaming list only for columns actually present in df
  rename_list <- fix_map[names(fix_map) %in% names(df)]
  
  if (length(rename_list) > 0) {
    # Convert to rename-compatible format: new_name = old_name
    rename_args <- set_names(names(rename_list), rename_list)
    
    df <- df %>% rename(!!!rename_args)
    
    message("Renamed columns: ", paste(rename_list, collapse = ", "))
  } else {
    message("No column names needed renaming.")
  }
  
  return(df)
}
