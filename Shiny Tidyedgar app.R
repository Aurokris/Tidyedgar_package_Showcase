library(shiny)
library(ggplot2)
library(dplyr)
##############################################################
# SHINY APP: Financial Data Analysis with 'tidyedgar'
##############################################################

#---------------------USER INTERFACE--------------------------
#_____________________________________________________________
ui <- fluidPage(
  titlePanel("Financial Data Analysis with tidyedgar"),
  sidebarLayout(
    sidebarPanel(
      selectInput("companyInput", "Choose a Company:", choices = c("Apple Inc", "Google LLC", "Microsoft Corp")),
      sliderInput("yearInput", "Select Year Range:", min = 2015, max = 2023, value = c(2015, 2023)),
      actionButton("update", "Update Data")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Total Assets", plotOutput("assetsPlot")),
        tabPanel("Asset to Liability Ratio", plotOutput("ratioPlot")),
        tabPanel("Net Income", plotOutput("incomePlot")),
        tabPanel("Net Margin", plotOutput("marginPlot"))
      )
    )
  )
)

##############################################################
#---------------------SERVER----------------------------------
#____________________________________________________________
server <- function(input, output) {
  # Reactive data source
  data_reactive <- reactive({
    req(input$update)
    df_filtered <- df %>%
      filter(company_name %in% input$companyInput, year >= input$yearInput[1], year <= input$yearInput[2])
    
    # Aggregate data to summarize at annual level by company
    df_aggregated <- df_filtered %>%
      group_by(year, company_name) %>%
      summarise(
        total_assets = sum(total_assets),
        total_liabilities = sum(total_liabilities),
        net_income = sum(net_income),
        asset_to_liability_ratio = mean(total_assets / total_liabilities),
        avg_net_margin = mean((net_income / total_assets) * 100),
        .groups = 'drop'
      )
    
    return(df_aggregated)
  })
  
  # Plot for Total Assets
  output$assetsPlot <- renderPlot({
    req(data_reactive())
    ggplot(data_reactive(), aes(x = year, y = total_assets, group = company_name, color = company_name)) +
      geom_line() +
      labs(title = "Total Assets Over Time", x = "Year", y = "Total Assets (USD)")
  })
  
  # Plot for asset to Liability Ratio
  output$ratioPlot <- renderPlot({
    req(data_reactive())
    ggplot(data_reactive(), aes(x = year, y = asset_to_liability_ratio, fill = company_name)) +
      geom_bar(stat = "identity", position = position_dodge()) +
      labs(title = "Asset to Liability Ratio", x = "Year", y = "Ratio")
  })
  
  # Plot for Net-Income
  output$incomePlot <- renderPlot({
    req(data_reactive())
    ggplot(data_reactive(), aes(x = year, y = net_income, fill = company_name)) +
      geom_col(position = position_dodge()) +
      labs(title = "Net Income Over Time", x = "Year", y = "Net Income (USD)")
  })
  
  # Plot for Average Net Margin
  output$marginPlot <- renderPlot({
    req(data_reactive())
    ggplot(data_reactive(), aes(x = year, y = avg_net_margin, color = company_name, group = company_name)) +
      geom_line() +
      labs(title = "Average Net Margin Over Time", x = "Year", y = "Net Margin")
  })
}


##############################################################
#--------------------------RUNNING THE APP--------------------
#_____________________________________________________________
shinyApp(ui = ui, server = server)
