library(shiny)
library(tidyverse)
library(janitor)

flat_prices <- CodeClanData::flatPrices %>% 
  clean_names()

all_dates <- CodeClanData::flatPrices %>% 
  clean_names() %>% 
  select(date)

ui <- fluidPage(
  
  titlePanel("Average flat prices in Edinburgh"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput(inputId = "start_date", 
                  label = "Select the start date", 
                  choices = all_dates),
      
      selectInput(inputId = "end_date", 
                  label = "Select the end date", 
                  choices = all_dates)
    ),
    
    mainPanel(plotOutput("flat_prices_plot"))
  )
)

server <- function(input, output){
  
  output$flat_prices_plot <- renderPlot(
    flat_prices %>%
      filter(date >= input$start_date) %>% 
      filter(date <= input$end_date) %>%  
      ggplot() +
      aes(x = date, y = avg_flat_price) + 
      geom_line() + 
      labs(
        x = "\ntime",
        y = "price (£)\n") +
      scale_y_continuous(labels = scales::comma)
  )
}

shinyApp(ui = ui, server = server)


# flat_prices %>%
#   filter(date >= "2016-01-01") %>%
#   filter(date <= "2019-03-01") %>%
#   ggplot() +
#   aes(x = date, y = avg_flat_price) +
#   geom_line() +
#   labs(
#     x = "\ntime",
#     y = "price (£)\n") +
#   scale_y_continuous(labels = scales::comma)
