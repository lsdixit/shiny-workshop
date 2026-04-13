# ---- load pkgs ----
library(shiny)
library(tidyverse)
library(palmerpenguins)
library(DT)
library(bslib)

# ---- user interface ----
ui <- fluidPage(
  
  theme = bs_theme(
    bg = "lightpink",
    fg = "blue",
    primary = "orange",
    base_font = font_google("Pacifico")
    
  ),
  
  # app title ----
  tags$h1("My App Title"),
  
  # app subtitle ----
  h2(strong("Exploring Antarctic Penguin Data")),
  
  # body mass slider input ----
  sliderInput(inputId = "body_mass_input",
              label = "Select a range of body masses (g)",
              min = 2700, max = 6300, value = c(3000, 4000)),
  
  # body mass plot output ----
  plotOutput(outputId = "body_mass_scatterplot_output"),
  
  # data table year input ----
  checkboxGroupInput(inputId = "table_year_input",
                     label = "Select year(s)",
                     choices = c("2007", "2008", "2009"),
                     selected = c("2007", "2008")),
  
  # data table year output ----
  dataTableOutput(outputId = "table_year_output",
                  width = "auto", height = "auto")
  
)

# ---- server ----
server <- function(input, output) {
  
  # filter body masses ----
  body_mass_df <- reactive({
    
    penguins %>% 
      filter(body_mass_g %in% c(input$body_mass_input[1]:input$body_mass_input[2]))
  })
  
  output$body_mass_scatterplot_output <- # assign location of plot to outputId
    renderPlot({
      
      # code to generate plot goes here
      ggplot(na.omit(body_mass_df()), 
             aes(x = flipper_length_mm, y = bill_length_mm, 
                 color = species, shape = species)) +
        geom_point() +
        scale_color_manual(values = c("Adelie" = "darkorange", "Chinstrap" = "purple", "Gentoo" = "cyan4")) +
        scale_shape_manual(values = c("Adelie" = 19, "Chinstrap" = 17, "Gentoo" = 15)) +
        labs(x = "Flipper length (mm)", y = "Bill length (mm)", 
             color = "Penguin species", shape = "Penguin species") +
        guides(color = guide_legend(position = "inside"),
               size = guide_legend(position = "inside")) +
        theme_minimal() +
        theme(legend.position.inside = c(0.85, 0.2), 
              legend.background = element_rect(color = "white"))
    })
  
  # filter table year output ----
  filter_table_output <- reactive({
    penguins %>% 
      filter(year == c(input$table_year_input[1], input$table_year_input[2], input$table_year_input[3]))
  })
  
  # table year output ----
  output$table_year_output <- renderDT({filter_table_output()})
}

# ---- combine ui & server into an app ----
shinyApp(ui = ui, server = server)


## Notes! ##
# runApp("directory_name") in console to run the app if no run app button
# here it would be runApp("single-file-app")

# name data frames created wiht '_df' at the end to make it easier to understand

# naming all input variables with '_input' at the end to make it easier to understand
# naming all output variables with '_output' at the end to make it easier to understand

