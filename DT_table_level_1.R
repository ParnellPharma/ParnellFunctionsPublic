fxn_DT_table_options_1<-function(df){
  DT::datatable(df,
                caption = htmltools::tags$caption(
                  style = 'caption-side: top; text-align: left;',
                  htmltools::tags$div("Conception Risk Table", style = "font-size: 1.5em; font-weight: bold;")#,
                  # htmltools::tags$div("This table lists the information extracted from the remark of the BRED event",
                  #                     style = "font-size: 0.9em; color: #6c757d;")
                ),
                filter = "top",
                extensions = c('Buttons'),
                class = 'cell-border hoover compact',
                options = list(
                  #autoWidth = TRUE,
                  ordering = TRUE,
                  paging = TRUE,
                  searching = TRUE,
                  #responsive = TRUE,
                  dom = 'ftrBSip',
                  buttons = c('copy', 'csv', 'excel')
                  # columnDefs = list(
                  #   # list(width = '25%', targets = which(names(bench_sub_herd()) == "Item Name") - 1),
                  #   # list(width = '20%', targets = which(names(bench_sub_herd()) == "Rank Category") - 1),
                  #   # list(width = '10%', targets = which(names(bench_sub_herd()) == "HerdGroupId") - 1),
                  #   list(width = '15%', targets = 0, className = 'dt-left')
                  # )
                  
                ),
                # filter = list(
                #   position = 'top',
                #   clear = FALSE
                # ),
                rownames = FALSE
  )
    
    
  #IR background---------------
# DT::formatStyle(
#   'IR 1st Lact', 'IR1_vcb',
#   backgroundColor = DT::styleEqual(val_DT,
#                                    colors_DT)
# )%>%
#   DT::formatStyle(
#     'IR 2+ Lact', 'IR2_vcb',
#     backgroundColor = DT::styleEqual(val_DT,
#                                      colors_DT)
#   )%>%
#   DT::formatStyle(
#     'IR All Lact', 'IR3_vcb',
#     backgroundColor = DT::styleEqual(val_DT,
#                                      colors_DT)
#   )%>%
#   #CR background---------------
# DT::formatStyle(
#   'CR 1st Lact', 'CR1_vcb',
#   backgroundColor = DT::styleEqual(val_DT,
#                                    colors_DT)
# )%>%
#   DT::formatStyle(
#     'CR 2+ Lact', 'CR2_vcb',
#     backgroundColor = DT::styleEqual(val_DT,
#                                      colors_DT)
#   )%>%
#   DT::formatStyle(
#     'CR All Lact', 'CR3_vcb',
#     backgroundColor = DT::styleEqual(val_DT,
#                                      colors_DT)
#   )%>%
#   #PR background---------------
# DT::formatStyle(
#   'PR 1st Lact', 'PR1_vcb',
#   backgroundColor = DT::styleEqual(val_DT,
#                                    colors_DT)
# )%>%
#   DT::formatStyle(
#     'PR 2+ Lact', 'PR2_vcb',
#     backgroundColor = DT::styleEqual(val_DT,
#                                      colors_DT)
#   )%>%
#   DT::formatStyle(
#     'PR All Lact', 'PR3_vcb',
#     backgroundColor = DT::styleEqual(val_DT,
#                                      colors_DT)
#   )%>%
#   #date text colors----------------------
# DT::formatStyle(
#   'IR Date', 'IR_Date_status',
#   color = DT::styleEqual(c('Data Not Current', 'Current'),
#                          c('red', 'black'))
# )%>%
#   DT::formatStyle(
#     'CR Date', 'CR_Date_status',
#     color = DT::styleEqual(c('Data Not Current', 'Current'),
#                            c('red', 'black'))
#   )%>%
#   DT::formatStyle(
#     'PR Date', 'PR_Date_status',
#     color = DT::styleEqual(c('Data Not Current', 'Current'),
#                            c('red', 'black'))
#   )
  
}