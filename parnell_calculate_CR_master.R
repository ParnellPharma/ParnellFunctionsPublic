library(tidyverse)



# data should be a data frame with at least 3 columns: event, date, and R (or Event, Date, R)
# to calculate conception risk call the function named fxn_create_CR_reports()  
# you may pipe your data into the function(best practice), or specify your data within the function by defining "df = my_data"
# within the function you must also specify the variables you wish to group the data: "grp_vars = c('location', 'lact_group', 'floor_date_month', 'R')"
# the function will accept any grouping variable that does not contain an "NA" value, and you must include "R" (repro outcome) as a column in the grouping
# NOTE: if your data is not dairy comp data as long as your outcome is contained in a variable named R, and you have an events column containing "BRED" events you can use it.  
# However if using non-dairy comp data or very messy dairy comp data, you may have to modify the fxn_standardize_for_CR() function to accept other values if you are getting R standard values of "ERROR"

# EXAMPLE: 
# cr_report<-my_data_bred_events%>%
#            fxn_create_CR_reports(grp_vars = c('location', 'lact_group', 'floor_date_month', 'R'))

# Note: if you are missing values the code is desinged to filter out the most recent 40 days where pregnancy status is not known.  
# If you do not like this feel free to copy this function and modify it to remove the date filter


#Standardize R for CR----------------------
fxn_standardize_for_CR<-function(df){
  df%>%
    #test<-events8%>%
    mutate(
      Rstandard = case_when(
        (is.na(R))~'Not Bred Event',
        (R %in% 'O')~'std_Open', 
        (R %in% c('A'))~'std_Abort',
        (R %in% c('P',  'E' ))~'std_Pregnant', 
        (R %in% c('R', '-',  'C', 'U', 'ABS', ' ', '_' ))~'std_Other', 
        TRUE~'ERROR')
      )
}


#CALCULATE CR---------------------
fxn_calculate_CR_main<-function(df_grouped){
  
  format_data<<-tibble(std_Open = 0, std_Pregnant = 0, std_Abort = 0, std_Other = 0, data_type = 'Format')
  
  df_grouped%>%
    summarize(ct_row = sum(n()))%>%
    ungroup()%>%
    pivot_wider(names_from = Rstandard, 
                values_from = ct_row)%>%
    #find a better solution to this---------------------
    bind_rows(format_data)%>%
    filter(!(data_type %in% 'Format'))%>%
    select(-data_type)%>%
    #-------------------------------------------
  mutate(across(where(is.numeric), ~replace_na(., 0)))%>%
  
    mutate(Open = replace_na(std_Open, 0),
           Abort = replace_na(std_Abort, 0),
           Pregnant = replace_na(std_Pregnant, 0),
           Other = replace_na(std_Other, 0))%>%
    mutate(deno = std_Open+std_Pregnant+std_Abort,
           preg = std_Pregnant+std_Abort,
           other = std_Other,
           total = std_Open+std_Pregnant+std_Abort+std_Other
           )%>%
    mutate(CR = preg/deno, 
           pct_other_old = other/deno,
           pct_other = other/total,
           Preg = preg, 
           Open = std_Open, 
           Other = other, 
           Abort = std_Abort, 
           Total = preg+std_Open+other, 
           SPC = deno/preg)

}

#Calculate Confidence intervals-------------------
#This function calcualtes the 95% confidence interval of a proportion where n = the count
#this script defines alpha as a 95% interval, this must be commented out if a different alpha is needed
#name the proprotion "pct"

# Set CI alpha level (1-alpha/2)*100%
alpha <- 0.05

# Calculate the critical z-score
z <- qnorm(1-alpha/2)

#CR<-0.2

fxn_calc_CI<-function(df){
  df%>%
    mutate(CI = z*sqrt(CR*(1-CR)/deno))%>%
    mutate(CI_lower = round((CR-CI)*100, digits = 1), 
           CI_upper = round((CR+CI)*100, digits = 1)
    )%>%
    mutate(pctConc = round(CR*100, digits = 0))
}

# Create CR warnings -------------------
fxn_create_CR_warnings<-function(df){
  df%>%
    #mutate(pct_other = other/deno)%>%
    mutate(warning_CR = case_when(
      (pct_other>0.15)~'>15% Other Outcomes',
      (deno<30)~'Very Low (<30)',
      (deno<50)~'Low (30-49)',
      (deno<100)~'Ok (50<99)',
      TRUE~'Good (>100)'
    ))
}




#Create CR reports---------------------

fxn_create_CR_reports<-function(df, grp_vars){

  if('event' %in% colnames(df)){
    df<-df%>%
    mutate(Event = event)
    }

   if('date' %in% colnames(df)){
    df<-df%>%
    mutate(Date = date)
    }

  #date_pull_max = max(df$Date)
  
  df%>%
    #filter(Event %in% 'BRED')%>%
    #filter(Date<(date_pull_max-40))%>%
    fxn_standardize_for_CR()%>%
    group_by(across(all_of(grp_vars)))%>%
    fxn_calculate_CR_main()%>%
    ungroup()%>%
    #filter(!(deno<10))%>%
    fxn_calc_CI()%>% # this must follow fxn_calculate_CR_main
    fxn_create_CR_warnings()
}









