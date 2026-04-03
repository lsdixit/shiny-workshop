library(DT)
DT::datatable(penguins)


filter_table <- penguins %>% 
  filter(year == c(2007, 2008))

datatable(filter_table)
