library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(emmeans)
library(DT)
library(shinythemes)

# Load the nutrition dataset
data(nutrition, package = "emmeans")

ui <- dashboardPage(
  dashboardHeader(title = "Nutrition Knowledge Analysis Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Plots", tabName = "plots", icon = icon("chart-line")),
      menuItem("Data", tabName = "data", icon = icon("table")),
      selectInput("group", "Select Grouping Variable:",
                  choices = c("age", "group", "race", "None")),
      checkboxInput("jitter", "Add Jitter to Boxplot", FALSE),
      selectInput("plot_download", "Select Plot to Download:",
                  choices = c("Boxplot", "Histogram", "Scatter Plot", "Interaction Plot")),
      downloadButton("downloadPlot", "Download Selected Plot")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "plots",
              fluidRow(
                box(title = "Boxplot of Gain", plotOutput("boxplot"), width = 6),
                box(title = "Histogram of Gain", plotOutput("histogram"), width = 6)
              ),
              fluidRow(
                box(title = "Scatter Plot of Gain", plotOutput("scatterPlot"), width = 12)
              ),
              fluidRow(
                box(title = "Interaction Plot (Race x Group)", plotOutput("interactionPlot"), width = 12)
              ),
              fluidRow(
                box(title = "Summary Statistics", verbatimTextOutput("summary"), width = 12)
              )
      ),
      tabItem(tabName = "data",
              fluidRow(
                box(title = "Data Table", DTOutput("data_table"), width = 12),
                downloadButton("downloadData", "Download Data")
              )
      )
    )
  ),
  skin = "yellow"
)

server <- function(input, output) {
  
  selected_data <- reactive({
    if (input$group == "None") {
      nutrition
    } else {
      nutrition |>
        group_by(!!sym(input$group))
    }
  })
  
  plot_boxplot <- reactiveVal()
  plot_histogram <- reactiveVal()
  plot_scatter <- reactiveVal()
  plot_interaction <- reactiveVal()
  
  output$summary <- renderPrint({
    if (input$group == "None") {
      summary(nutrition$gain)
    } else {
      selected_data() |>
        summarise(
          mean = mean(gain, na.rm = TRUE),
          sd = sd(gain, na.rm = TRUE),
          min = min(gain, na.rm = TRUE),
          max = max(gain, na.rm = TRUE),
          n = n()
        )
    }
  })
  
  output$boxplot <- renderPlot({
    p <- ggplot(selected_data(), aes(y = gain))
    
    if (input$group != "None") {
      p <- p + aes(x = !!sym(input$group))
    }
    
    p <- p + geom_boxplot() +
      labs(title = "Boxplot of Gain",
           y = "Gain")
    
    if (input$jitter) {
      p <- p + geom_jitter(width = 0.2, alpha = 0.5)
    }
    
    plot_boxplot(p)
    p
  })
  
  output$histogram <- renderPlot({
    p <- ggplot(selected_data(), aes(x = gain))
    
    p <- p + geom_histogram(bins = 20, fill = "orange", color = "black") +
      labs(title = "Histogram of Gain",
           x = "Gain")
    
    plot_histogram(p)
    p
  })
  
  output$data_table <- renderDT({
    datatable(nutrition, options = list(pageLength = 10))
  })
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("nutrition_data_", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(nutrition, file)
    }
  )
  
  output$downloadPlot <- downloadHandler(
    filename = function() {
      paste(input$plot_download, "_", Sys.Date(), ".png", sep = "")
    },
    content = function(file) {
      if (input$plot_download == "Boxplot") {
        ggsave(file, plot = plot_boxplot(), device = "png")
      } else if (input$plot_download == "Histogram") {
        ggsave(file, plot = plot_histogram(), device = "png")
      } else if (input$plot_download == "Scatter Plot") {
        ggsave(file, plot = plot_scatter(), device = "png")
      } else if (input$plot_download == "Interaction Plot") {
        ggsave(file, plot = plot_interaction(), device = "png")
      }
    }
  )
  
  output$scatterPlot <- renderPlot({
    if (input$group != "None") {
      p <- ggplot(nutrition, aes(x = 1:nrow(nutrition), y = gain, color = !!sym(input$group))) +
        geom_point() +
        labs(title = paste("Scatter Plot of Gain by", input$group),
             x = "Index",
             y = "Gain",
             color = input$group) +
        theme(axis.text.x = element_blank(),
              axis.ticks.x = element_blank())
      plot_scatter(p)
      p
    } else {
      p <- ggplot(nutrition, aes(x = 1:nrow(nutrition), y = gain, color = group)) +
        geom_point() +
        labs(title = "Scatter Plot of Gain by group",
             x = "Index",
             y = "Gain",
             color = "group") +
        theme(axis.text.x = element_blank(),
              axis.ticks.x = element_blank())
      plot_scatter(p)
      p
    }
  })
  
  output$interactionPlot <- renderPlot({
    if (input$group != "None") {
      nutr.aov <- aov(gain ~ (group + age + race)^2, data = nutrition)
      nutr.emm <- emmeans(nutr.aov, ~ race * group, at = list(age = "3"))
      p <- emmip(nutr.emm, race ~ group)
      plot_interaction(p)
      p
    } else {
      plot_interaction(NULL)
      NULL
    }
  })
}

shinyApp(ui = ui, server = server)
