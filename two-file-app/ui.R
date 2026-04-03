# ---- user interface ----
ui <- navbarPage(
  
  # title ----
  title = "LTER Animal Data Explorer",
  
  # (Page 1) intro tabPanel ----
  tabPanel(title = "About this App",
           
           # intro text fluidRow ----
           fluidRow(
             column(1),
             column(10, includeMarkdown("text/about.md")),
             column(1)
             
           ), # END intro text fluidRow 
           
           hr(),
           
           includeMarkdown("text/footer.md")
           
  ), # END (page 1) intro tabPanel
  
  # (Page 2) data tabPanel ---- 
  tabPanel(title = "Explore the Data",
           
           # tabsetPanel to contain tabs for dataviz ----
           tabsetPanel(
             
             # trout tabPanel ----
             tabPanel(
               
               title = "Trout",
               
               # trout sidebarLayout ----
               sidebarLayout(
                 
                 # trout sidebarPanel ----
                 sidebarPanel(
                   
                   # channel type pickerInput ----
                   pickerInput(inputId = "channel_type_input",
                               label = "Select channel type(s)",
                               choices = unique(clean_trout$channel_type),
                               selected = c("cascade", "pool"),
                               multiple = TRUE,
                               options = pickerOptions(actionsBox = TRUE)
                   ), # END channel type pickerInput
                   
                   # section checkerboxGroupButtons ----
                   checkboxGroupButtons(inputId = "section_input",
                                        label = "Select a sampling section(s):",
                                        choices = c("clear cut forest", "old growth forest"),
                                        selected = c("clear cut forest", "old growth forest"),
                                        justified = TRUE,
                                        checkIcon = list(yes = icon("check", lib = "font-awesome"),
                                                         no = icon("xmark", lib = "font-awesome")))
                   
                 ), # END trout sidebarPanel
                 
                 # trout mainPanel ----
                 mainPanel(
                   
                   # trout plotOutput
                   plotOutput(outputId = "trout_scatterplot_output")
                   
                 ) # END trout mainPanel
               ) # END trout sidebarLayout
             ), # END trout tabPanel
             
             # penguin tabPanel ----
             tabPanel(
               
               title = "Penguins",
               
               # penguin sidebarLayout ----
               sidebarLayout(
                 
                 # penguin sidebarPanel ----
                 sidebarPanel(
                   
                   # island type pickerInput ----
                   pickerInput(inputId = "penguin_island_input",
                               label = "Select an island(s):",
                               choices = unique(penguins$island),
                               selected = unique(penguins$island),
                               multiple = TRUE,
                               options = pickerOptions(actionsBox = TRUE)
                   ), # END island type pickerInput
                   
                   # bin number sliderInput ----
                   sliderInput(inputId = "bin_num_input",
                               label = "Select number of bins:",
                               min = 1, max = 100, value = 25)
                   
                 ), # END penguin sidebarPanel
                 
                 # penguin mainPanel ----
                 mainPanel(
                   
                   plotOutput(outputId = "flipper_length_histogram_output")
                 ) # END penguin mainPanel
               ), # ENDS penguin sidebarLayout
              
             ) # END penguin tabPanel
           ) # END tabsetPanel
  ), # END (Page 2) data tabPanel
) # END navbarPage