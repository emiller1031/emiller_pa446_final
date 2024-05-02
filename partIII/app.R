#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(datasets)
library(plotly)
data <- as_tibble(iris)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel(textOutput("nameOutput")),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            textInput("name",
                      "What is your name?"),
            textInput("rows",
                      "Number of rows to show in the table"),
            selectizeInput("yaxis",
                           "Y-Axis",
                           choice = c("Sepal Length" = "Sepal.Length",
                                      "Sepal Width" = "Sepal.Width",
                                      "Petal Length" = "Petal.Length",
                                      "Petal Width" = "Petal.Width",
                                      "Species" = "Species")),
            selectizeInput("xaxis",
                           "X-Axis",
                           choice = c("Sepal Length" = "Sepal.Length",
                                      "Sepal Width" = "Sepal.Width",
                                      "Petal Length" = "Petal.Length",
                                      "Petal Width" = "Petal.Width",
                                      "Species" = "Species")),
        ),

        # Show a plot of the generated graph
        mainPanel(
          tabsetPanel(
            tabPanel("Plot", plotOutput("distPlot")),
            tabPanel("Table", tableOutput("table"))
        )
    )
)
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$distPlot <- renderPlotly({
    irisgraph <- data %>%
      ggplot() +
      geom_point(aes_string(
        x = input$xaxis,
        y = input$yaxis)) +
      ggtitle("Iris Data Plot")
    ggplotly(irisgraph)
  })
  
  output$table <- renderTable({
    head(data, n = as.numeric(input$rows))
  })
  
  output$namOutput <- renderText({
    paste("Hello", input$name)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
