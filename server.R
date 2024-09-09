require(shiny)
require(leaflet)
require(sf)
require(RColorBrewer)
require(tidyverse)

bogota <- readRDS("bogota_copula.Rds")
if (is.null(bogota)) stop("Failed to load bogota_copula.Rds")

barranquilla <- readRDS("barranquilla_copula.Rds")
if (is.null(barranquilla)) stop("Failed to load barranquilla_copula.Rds")

server <- function(input, output, session) {
  
  selectedvar_bogota <- reactive({
    req(input$variable_bogota)
    bogota[[input$variable_bogota]]
  })
  
  selectedvar_barranquilla <- reactive({
    req(input$variable_barranquilla)
    barranquilla[[input$variable_barranquilla]]
  })
  
  output$map_bogota <- renderLeaflet({
    req(selectedvar_bogota())
    var_data <- selectedvar_bogota()
    
    if (!is.null(var_data) && is.list(var_data) && "upz_raster" %in% names(var_data) && "pal" %in% names(var_data)) {
      tryCatch({
        leaflet() %>%
          addTiles() %>%
          setView(lng = -74.0721, lat = 4.7110, zoom = 11) %>%
          addRasterImage(var_data$upz_raster, colors = var_data$pal, opacity = 0.8, project = TRUE)
      }, error = function(e) {
        print(paste("Error in rendering Bogota map:", e$message))
      })
    } else {
      print("Invalid data for Bogota map")
    }
  })
  
  output$map_barranquilla <- renderLeaflet({
    req(selectedvar_barranquilla())
    var_data <- selectedvar_barranquilla()
    
    if (!is.null(var_data) && is.list(var_data) && "upz_raster" %in% names(var_data) && "pal" %in% names(var_data)) {
      tryCatch({
        leaflet() %>%
          addTiles() %>%
          setView(lng = -74.7813, lat = 10.9878, zoom = 11) %>%
          addRasterImage(var_data$upz_raster, colors = var_data$pal, opacity = 0.8, project = TRUE)
      }, error = function(e) {
        print(paste("Error in rendering Barranquilla map:", e$message))
      })
    } else {
      print("Invalid data for Barranquilla map")
    }
  })
  
}

