library(shiny)
library(tidyverse)
library(bslib)

# This app should allow the user to see the top 10 list of their choosing, be it 'Game name', 'Genre' or 'Developer' by value of sales. These are variables within the game_sales data set. 
# 
# However I can't get code to populate the visualisation. The ggplot code for all three possibilities is saved at the bottom of this screen for testing. 

# Previously all our examples have shown the user selecting a value from within a selected variable rather than selecting a variable/column name.
# 
# There are plans in the code to add a second radio button to allow the user to determine the measure used. At present it is set as 'sales' but the user should hopefully be able to select 'critic score' or 'user score' also.
# 
# The visualisation chosen is a horizontal bar chart which will allow easy comparison of results across the chosen category. 


# load in data
game_sales_data <- CodeClanData::game_sales

ui <- fluidPage(
  
  # theme
  theme = bs_theme(bootswatch = "flatly"),
  
  # title
  titlePanel(tags$h1("Video Game Data")),
  
  sidebarLayout(
    # input
    sidebarPanel(
      radioButtons(
        inputId = "top_10_input", 
        label = "Top 10 Category", 
        choices = c("Game name" = "name", "Genre" = "genre", 
                    "Developer" = "developer")
      )
      # HTML("<br>"), 
      # 
      # radioButtons(
      #   inputId = "measure_input", 
      #   label = "By measure", 
      #   choices = c("Sales" = "sales", "Critic Score" = "critic_score", 
      #               "User Score" = "user_score")
      # )
      
    ), 
    # output
    mainPanel(plotOutput("game_data_plot"))
  ),
)

server <- function(input, output, session) {

  output$game_data_plot <- renderPlot({
    
    game_sales_data %>%
      group_by(input$top_10_input) %>% 
      summarise(total_sales = sum(sales)) %>% 
      slice_max(total_sales, n = 10) %>% 
      ggplot() +
      aes(x = total_sales, y = reorder(input$top_10_input, total_sales), 
          fill = input$top_10_input) +
      geom_col(show.legend = FALSE) +
      labs(
        x = "\nsales",
        y = "name"
      )
  })
}

shinyApp(ui, server)


# test plots
########################################################################

# top 10 GENRE by sales
# game_sales_data %>%
#   group_by(genre) %>%
#   summarise(total_sales = sum(sales)) %>%
#   slice_max(total_sales, n = 10) %>%
#   ggplot() +
#   aes(x = total_sales, y = reorder(genre, total_sales), fill = genre) +
#   geom_col(show.legend = FALSE) +
#   labs(
#     x = "\nsales",
#     y = "name"
#   )

# top 10 NAMES by sales
# game_sales_data %>%
#   group_by(name) %>%
#   summarise(total_sales = sum(sales)) %>%
#   slice_max(total_sales, n = 10) %>%
#   ggplot() +
#   aes(x = total_sales, y = reorder(name, total_sales), fill = name) +
#   geom_col(show.legend = FALSE) +
#   labs(
#     x = "\nsales",
#     y = "name"
#   )

# top 10 DEVELOPERS by Sales
# game_sales_data %>%
#   group_by(developer) %>%
#   summarise(total_sales = sum(sales)) %>%
#   slice_max(total_sales, n = 10) %>% 
#   ggplot() +
#   aes(x = total_sales, y = reorder(developer, total_sales),
#       fill = developer) +
#   geom_col(show.legend = FALSE) +
#   labs(
#     x = "\nsales",
#     y = "name"
#   )