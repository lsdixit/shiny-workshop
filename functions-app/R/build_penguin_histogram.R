build_penguin_histogram <- function(input) {
  
  # filter penguin species (histogram) ----
  filtered_spp_histogram_df <- reactive ({
    
    penguins |>
      filter(species %in% input$penguin_spp_histogram_input)
    
  })
  
  # render the histogram output ----
  renderPlot({
    
    ggplot(na.omit(filtered_spp_histogram_df()),
           aes(x = flipper_length_mm, fill = species)) +
      geom_histogram(alpha = 0.5, position = "identity") +
      scale_fill_manual(values = c("Adelie" = "darkorange", 
                                   "Chinstrap" = "purple", 
                                   "Gentoo" = "cyan4")) +
      labs(x = "Flipper length (mm)", 
           y = "Frequency",
           fill = "Penguin species")
    
  })
  
}