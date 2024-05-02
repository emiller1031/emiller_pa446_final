library(shiny)
library(datasets)
library(plotly)
library(shinythemes)

data <- as_tibble(iris)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # select theme
  theme = shinytheme("united"),
  
  # title with greeting 
  titlePanel(textOutput("nameOutput")),
  
  # sidebar with inputs and main panel with tabs
  sidebarLayout(
    sidebarPanel(
      textInput("name", "What is your name?"),
      textInput("rows", "Number of rows to show in the table"),
      selectizeInput("yaxis", "Y-Axis", choice = c(
        "Sepal Length" = "Sepal.Length",
        "Sepal Width" = "Sepal.Width",
        "Petal Length" = "Petal.Length",
        "Petal Width" = "Petal.Width",
        "Species" = "Species"
      )),
      selectizeInput("xaxis", "X-Axis", choice = c(
        "Sepal Length" = "Sepal.Length",
        "Sepal Width" = "Sepal.Width",
        "Petal Length" = "Petal.Length",
        "Petal Width" = "Petal.Width",
        "Species" = "Species"
      ))
    ),
    
    # Main panel with tabs for plot and table
    mainPanel(
      tabsetPanel(
        tabPanel("Plot", plotlyOutput("irisPlot")),
        tabPanel("Table", tableOutput("table"))
      )
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # Render the greeting message
  output$nameOutput <- renderText({
    paste("Hello", input$name)
  })
  
  # Render the plot
  output$irisPlot <- renderPlotly({
    irisgraph <- data %>%
      ggplot() +
      geom_point(aes_string(
        x = input$xaxis,
        y = input$yaxis)) +
      ggtitle("Iris Data Plot")
    ggplotly(irisgraph)
    print(irisgraph)
  })
  
  # Render the table
  output$table <- renderTable({
    head(data, n = as.numeric(input$rows))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)