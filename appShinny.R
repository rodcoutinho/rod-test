#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)


basecredito <- read.csv("CC GENERAL (1).csv")
colunas <- names(basecredito)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # dashboard Shiny
    titlePanel("Grafico Shine"),
    
  

    # Sidebar 
    sidebarLayout(
        sidebarPanel(
          
          
          selectInput(
            "varX",
            label = "Variavel eixo X",
            choices = colunas
          ),
          selectInput(
            "varY",
            label = "Variavel eixo Y",
            choices = colunas,
            selected = colunas[6]
          ),
          
          selectInput("Color", "Color:",
                      c("darkblue" = "darkblue",
                        "green2" = "green2",
                        "gray" = "gray",
                        "orchid" = "orchid",
                        "red" = "red")),
          tableOutput("data"),
          
          numericInput("eixox", "Eixo Y",max(basecredito[, 1]), 
                       0,4000),
          
          numericInput("eixoy", "Eixo Y",max(basecredito[, 1]), 
                       0,4000)
      
        ),

        # Show a plot of the generated distribution
        mainPanel(
          plotOutput("grafico")
        )
    )
)


server <- function(input, output, session) {
  output$grafico <- renderPlot({
    ggplot(basecredito, aes(x = .data[[input$varX]], y = .data[[input$varY]])) +
      geom_point(color=input$Color)+
      lims(x= c(NA, input$eixox), y = c(NA, input$eixoy))
  })
}

shinyApp(ui, server)