library(shiny)
library(leaflet)

ui <- fluidPage(
  tags$head(
    # Custom CSS for the navbar and other elements
    tags$style(HTML("
      .navbar-custom {
        background-color: #f8f9fa; /* Light background color for the navbar */
        border: none; /* Remove border from navbar */
        padding: 0; /* Remove padding from navbar */
        height: 80px; /* Adjust the height of the navbar */
      }
      
      .navbar-brand img {
        height: 60px; /* Set the logo height */
        width: auto; /* Maintain aspect ratio */
        vertical-align: middle; /* Align logo vertically */
      }
      
      .navbar-nav {
        margin-left: auto; /* Align navbar items to the right */
        margin-right: auto; /* Align navbar items to the left */
        height: 80px; /* Match the navbar height */
        display: flex;
        align-items: center; /* Vertically center the navbar items */
      }
      
      .leaflet-container {
        margin-top: 40px; /* Add margin to push the map down */
        z-index: 1; /* Ensure the map is behind other elements */
      }
      
      .panel {
        z-index: 1000; /* Ensure the control panel appears on top of the map */
      }
    ")),
    # Add favicon
    tags$link(rel = "icon", type = "image/png", href = "Logo_ESCALA-Completo.png")
  ),
  
  # Wrap the navbarPage inside a div with the custom class
  tags$div(class = "navbar-custom", 
           navbarPage(
             title = div(
               img(src = 'Logo_ESCALA-Completo.png', style = "height: 60px; width: auto;"), # Set height for logo and maintain aspect ratio
               style = "display: flex; align-items: center; margin-left: 10px;" # Align logo in the center
             ),
             id = "nav",
             
             tabPanel(
               title = div(
                 "Bogota",
                 style = "display: flex; align-items: center;" # Align logo and text in the center
               ),
               div(
                 class = "outer",
                 
                 tags$head(
                   includeCSS("style.css") # Ensure your custom CSS file is included
                 ),
                 
                 leafletOutput("map_bogota", width = "100%", height = "100%"),
                 
                 absolutePanel(
                   id = "controls_bogota", class = "panel panel-default", fixed = TRUE,
                   draggable = TRUE, top = 120, left = "auto", right = 20, bottom = "auto", # Adjusted top position
                   width = 330, height = "auto",
                   h2("Informality Explorer"),
                   
                   selectInput(
                     "variable_bogota", "Select Variable:",
                     choices = c(
                       "Pr(Informal)" = "density",
                       "Pr(Sin Acueducto)" = "perc_sin_acueducto",
                       "Pr(Sin Alcantarillado)" = "perc_sin_alcantarillado",
                       "Pr(Deficit Cuantitativo)" = "perc_cuanti",
                       "Pr(Deficit Cualitativo)" = "perc_cuali",
                       "Pr(En Proceso de Legalizacion)" = "ilegal"
                     )
                   )
                 ),
                 
                 tags$footer(
                   id = "cite_bogota",
                   'Data compiled for ', tags$em('ESCALA')
                 )
               )
             ),
             
             # Add the Barranquilla tabPanel back
             tabPanel(
               title = div(
                 "Barranquilla",
                 style = "display: flex; align-items: center;" # Align logo and text in the center
               ),
               div(
                 class = "outer",
                 
                 tags$head(
                   includeCSS("style.css") # Ensure your custom CSS file is included
                 ),
                 
                 leafletOutput("map_barranquilla", width = "100%", height = "100%"),
                 
                 absolutePanel(
                   id = "controls_barranquilla", class = "panel panel-default", fixed = TRUE,
                   draggable = TRUE, top = 120, left = "auto", right = 20, bottom = "auto", # Adjusted top position
                   width = 330, height = "auto",
                   h2("Informality Explorer"),
                   
                   selectInput(
                     "variable_barranquilla", "Select Variable:",
                     choices = c(
                       "Pr(Informal)" = "density",
                       "Pr(Sin Acueducto)" = "perc_sin_acueducto",
                       "Pr(Sin Alcantarillado)" = "perc_sin_alcantarillado",
                       "Pr(Deficit Cuantitativo)" = "perc_cuanti",
                       "Pr(Deficit Cualitativo)" = "perc_cuali",
                       "Pr(En Proceso de Legalizacion)" = "ilegal"
                     )
                   )
                 ),
                 
                 tags$footer(
                   id = "cite_barranquilla",
                   'Data compiled for ', tags$em('ESCALA')
                 )
               )
             )
           )
  )
)

