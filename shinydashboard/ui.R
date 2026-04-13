# ---- dashboardHeader ----
header <- dashboardHeader(
  
  # title ----
  title = "Fish Creek Watershed Lake Monitoring",
  titleWidth = 400
  
) # END header 

# ---- dashboardSidebar ----
sidebar <- dashboardSidebar(
  
  # sidebarMenu ----
  sidebarMenu(
    
    menuItem(text = "Welcome", tabName = "welcome", icon = icon("star")),
    menuItem(text = "Dashboard", tabName = "dashboard", icon = icon("gauge"))
    
  ) # END sidebarMenu
) # END dashboardSidebar

# ---- dashboardBody ----
body <- dashboardBody(
  
  # define color theme
  use_theme("dashboard-fresh-theme.css"),
  
  # tabItems ----
  tabItems(
    
    # welcome tabItem ----
    tabItem(
      tabName = "welcome",
      
      # left-hand column ----
      column(width = 6,
             
             # background box ----
             box(width = NULL,
                 
                 title = tagList(icon("pencil"), strong("Introduction")),
                 includeMarkdown("text/intro.md"),
                 tags$img(src = "FishCreekWatershedSiteMap_2020.jpg",
                          alt = "A map of northern Alaska, showing Fish Creek Watershed located within the National Petroleum Preserve.",
                          style = "max-width: 100%"
                 ), # END background box 
                 tags$p(tags$em("Map Source: ", tags$a(href = "http://www.fishcreekwatershed.org/", "FCWO")),
                        style = "text-align: center;"))
             ), # END left-hand column
             
             # right-hand column ----
             column(width = 6,
                    
                    # data source box ----
                    box(width = NULL,
                        
                        title = tagList(icon("water"), strong("Data Citation")),
                        
                        includeMarkdown("text/citation.md")
                        
                    ), # END data source box
                    
                    # disclaimer box ----
                    box(width = NULL,
                        
                        title = tagList(icon("heart"), strong("Disclaimer")),
                        
                        includeMarkdown("text/disclaimer.md")
                        
                    ) # END disclaimer box
             ) # END right-hand column
      ), # END welcome tabItem
      
      # dashboard tabItem ----
      tabItem(
        tabName = "dashboard",
        
        # input box ----
        box(width = 4,
            
            title = tags$strong("Adjust lake parameter ranges:"),
            
            # sliderInputs ----
            sliderInput(inputId = "elevation_slider_input",
                        label = "Elevation (meters above SL):",
                        min = min(lake_data$Elevation),
                        max = max(lake_data$Elevation),
                        value = c(min(lake_data$Elevation), max(lake_data$Elevation))
            ),
            
            sliderInput(inputId = "avg_depth_slider_input",
                        label = "Avg Depth (meters):",
                        min = min(lake_data$AvgDepth),
                        max = max(lake_data$AvgDepth),
                        value = c(min(lake_data$AvgDepth), max(lake_data$AvgDepth))
            ),
            
            sliderInput(inputId = "avg_temp_slider_input",
                        label = "Avg Temp (C)",
                        min = min(lake_data$AvgTemp),
                        max = max(lake_data$AvgTemp),
                        value = c(min(lake_data$AvgTemp), max(lake_data$AvgTemp))
            ) # END sliderInput
        ), # END input box
        
        # leaflet box ----
        box(width = 8,
            
            leafletOutput(outputId = "lake_map_output") %>% 
              withSpinner(type = 1, color = "blue")
            
        ) # END leaflet box
      ) # END dashboard tabItem 
    ) # END tabItems
  ) # END dashboardBody
  
  # ---- combine all into dashboardPage ----
  dashboardPage(header, sidebar, body)