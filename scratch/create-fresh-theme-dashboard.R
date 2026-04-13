library(fresh)

create_theme(
  
  adminlte_color(
    # top bar color 
    light_blue = "darkblue"
  ),
  
  adminlte_global(
    # body of dashboard color
    content_bg = "lightpink"
  ),
  
  adminlte_sidebar(
    width = "400px",
    # color of sidebar
    dark_bg = "lightblue",
    dark_hover_bg = "magenta",
    dark_color = "red"
  ),
  
  output_file = here::here("shinydashboard", "www", "dashboard-fresh-theme.css")
  
)
