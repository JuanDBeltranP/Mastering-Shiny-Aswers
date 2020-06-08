## This app is to run all the exercises in Mastering Shiny Book
library(shiny)
library(ggplot2)
datasets <- data(package = "ggplot2")$results[c(2, 4, 10), "Item"]


ui <- fluidPage(theme = shinythemes::shinytheme("superhero"),
  titlePanel("Central limit theorem"),
  sidebarLayout(
    
    mainPanel(
      plotOutput("hist")
    ),
    sidebarPanel(
      numericInput("m", "Number of samples:", 2, min = 1, max = 100)
    )
  )
)

server <- function(input, output, session) {
  output$hist <- renderPlot({
    means <- replicate(1e4, mean(runif(input$m)))
    hist(means, breaks = 20)
  }, res = 96)
}
shinyApp(ui, server)