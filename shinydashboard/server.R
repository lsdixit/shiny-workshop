server <- function(input, output) {
  
  # filter lake data ----
  filtered_lakes_df <- reactive(
    
    lake_data %>% 
      filter(Elevation >= input$elevation_slider_input[1] & 
               Elevation <= input$elevation_slider_input[2]) %>% 
      filter(AvgDepth >= input$avg_depth_slider_input[1] & 
               AvgDepth <= input$avg_depth_slider_input[2]) %>% 
      filter(AvgTemp >= input$avg_temp_slider_input[1] & 
               AvgTemp <= input$avg_temp_slider_input[2])
    
  ) # END filtered lake data
  
  # build leaflet map ----
  output$lake_map_output <- renderLeaflet({
    
    leaflet() %>% 
      
      # add tiles
      addProviderTiles(providers$Esri.WorldImagery) %>% 
      
      # set view over AK
      setView(lng = -152.048442, lat = 70.249234, zoom = 6) %>% 
      
      # add minimap
      addMiniMap(toggleDisplay = TRUE, minimized = FALSE) %>% 
      
      # add markers
      addMarkers(data = filtered_lakes_df(),
                 lng = filtered_lakes_df()$Longitude,
                 lat = filtered_lakes_df()$Latitude,
                 popup = paste0(
                   "Site Name: ", filtered_lakes_df()$Site, "<br>",
                   "Elevation: ", filtered_lakes_df()$Elevation, " meters (above SL)", "<br>",
                   "Avg Depth: ", filtered_lakes_df()$AvgDepth, " meters", "<br>",
                   "Avg Lake Bed Temperature: ", filtered_lakes_df()$AvgTemp, " C"
                 ))
  }) # END build leaflet map
} # END server