library(dplyr)
library(rlang)

#df<-master_events #for testing
fxn_fix_column_names <- function(df) {
  
  current_col_names<-colnames(df)
  
  if ('BIRTH' %in% current_col_names){
    df<-df%>%
      rename(BDAT = BIRTH)
  }
  
  if ('FRSH' %in% current_col_names){
    df<-df%>%
      rename(FDAT = FRSH)
  }
  
  if ('BREED' %in% current_col_names){
    df<-df%>%
      rename(CBRD = BREED)
  }
  
  if ('PGCK' %in% current_col_names){
    df<-df%>%
      rename(PODAT = PGCK)
  }
  
  if ('BRDHT' %in% current_col_names){
    df<-df%>%
      rename(HDAT = BRDHT)
  }
  
  # Known substitutions: incorrect or alternate names → correct names
 
  return(df)
}
