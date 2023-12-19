#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


#Shiny Visualization
library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Histogram of Players' Composite Scores"),
  sidebarLayout(
    sidebarPanel(
      selectInput("selected_stat", 
                  "Select Statistic:",
                  choices = c('PER_playoffs', 
                              'Offensive_win_shares_playoffs_per_season', 
                              'Offensive_rating_playoffs', 
                              'VORP_playoffs_per_season', 
                              'Box_plus_minus_playoffs', 
                              'Number_of_Championships', 
                              'Win_shares_per_48_playoffs', 
                              'Defensive_win_shares_playoffs_per_season'))
    ),
    mainPanel(
      plotOutput("compositeHistogram")
    )
  )
)
server <- function(input, output) {
  output$compositeHistogram <- renderPlot({
    selected_data <- nba_data[, c("Player", input$selected_stat)]
    ggplot(selected_data, aes_string(x = "Player", y = input$selected_stat)) +
      geom_histogram(stat = "identity") +
      theme_minimal() +
      coord_flip() +
      xlab("Player") +
      ylab("Composite Score")
  })
}

shinyApp(ui = ui, server = server)
