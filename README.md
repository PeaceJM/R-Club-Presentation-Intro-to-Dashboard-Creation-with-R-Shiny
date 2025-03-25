R Club Presentation: Intro to Dashboard Creation with R Shiny
================
Peace M

# R Club: Intro to Shiny Dashboards for Researchers

###### 3/21/25

Shiny is a web interface that can be integrated into R and Python to
transform code into interactive, accessible applications that convey
insights to researchers and stakeholders.

This module introduces R Shiny for dashboard creation, covering the
basic structure of a Shiny app and an example applictaion.

By the end of this presentation, learners should:

• Understand the benefits of using R Shiny in research.

• Recognize the basic structure of a Shiny app.

• Implement practical methods to integrate research data into basic
dashboards using R Shiny: https://peacemaddox.shinyapps.io/r_club/

Shiny enhances research team collaboration by facilitating better
communication of complex data through effective visualization tools.

## Components of a Shiny Application

[Shiny
Gallery](https://shiny.posit.co/r/getstarted/shiny-basics/lesson1/)

**UI:** Provides interactive elements for user input.

``` r
ui <- page_fluid()
```

**Server:** Processes user inputs, and displays results in the UI.

``` r
server <- function(input, output, session) {}
```

**Create the app:**

``` r
shinyApp(ui = ui, server = server)
```

[Shiny Dashboard](https://rstudio.github.io/shinydashboard/)

## Introduction to the Data

The following code checks all built-in datasets available in all the
installed packages of your R environment.

``` r
data(package = .packages(all.available = TRUE))
```

``` r
library(emmeans)
```

    ## Welcome to emmeans.
    ## Caution: You lose important information if you filter this package's results.
    ## See '? untidy'

`emmeans`: Estimated Marginal Means, aka Least-Squares Means

Obtain estimated marginal means (EMMs) for many linear, generalized
linear, and mixed models. Compute contrasts or linear functions of EMMs,
trends, and comparisons of slopes. Plots and other displays.
Least-squares means are discussed, and the term “estimated marginal
means” is suggested, in Searle, Speed, and Milliken (1980) Population
marginal means in the linear model: An alternative to least squares
means, The American Statistician 34(4), 216-221
<doi:10.1080/00031305.1980.10483031>.

[emmeans.pdf](https://cran.r-project.org/web/packages/emmeans/emmeans.pdf)

``` r
library(tidyverse)
```

    ## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ## ✔ dplyr     1.1.4     ✔ readr     2.1.5
    ## ✔ forcats   1.0.0     ✔ stringr   1.5.1
    ## ✔ ggplot2   3.5.1     ✔ tibble    3.2.1
    ## ✔ lubridate 1.9.4     ✔ tidyr     1.3.1
    ## ✔ purrr     1.0.4     
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()
    ## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
nutrition
```

    ##     age      group     race gain
    ## 1     1      NoAid    White    5
    ## 2     1      NoAid    White   -2
    ## 3     1      NoAid    White  -10
    ## 4     1 FoodStamps    Black    4
    ## 5     1 FoodStamps    Black    4
    ## 6     1 FoodStamps    White   -8
    ## 7     1 FoodStamps    White    9
    ## 8     2      NoAid    Black   -4
    ## 9     2      NoAid    Black   -2
    ## 10    2      NoAid    Black    0
    ## 11    2      NoAid    Black    0
    ## 12    2      NoAid    Black    5
    ## 13    2      NoAid    Black   -6
    ## 14    2      NoAid    Black    2
    ## 15    2      NoAid    White    7
    ## 16    2      NoAid    White    2
    ## 17    2      NoAid    White  -13
    ## 18    2      NoAid    White    2
    ## 19    2      NoAid    White    3
    ## 20    2      NoAid    White    3
    ## 21    2      NoAid    White   -4
    ## 22    2      NoAid    White   -5
    ## 23    2 FoodStamps    White    5
    ## 24    2 FoodStamps    White    0
    ## 25    2 FoodStamps    White   10
    ## 26    2 FoodStamps    White    3
    ## 27    2 FoodStamps    White    3
    ## 28    2 FoodStamps    White    7
    ## 29    2 FoodStamps    White    7
    ## 30    2 FoodStamps    White    4
    ## 31    3      NoAid    Black    3
    ## 32    3      NoAid    Black  -14
    ## 33    3      NoAid    Black  -14
    ## 34    3      NoAid    Black   -1
    ## 35    3      NoAid    Black    3
    ## 36    3      NoAid    Black    1
    ## 37    3      NoAid Hispanic   -1
    ## 38    3      NoAid Hispanic    6
    ## 39    3      NoAid    White  -20
    ## 40    3      NoAid    White    6
    ## 41    3      NoAid    White    9
    ## 42    3      NoAid    White   -5
    ## 43    3      NoAid    White    3
    ## 44    3      NoAid    White   -1
    ## 45    3      NoAid    White    3
    ## 46    3      NoAid    White    0
    ## 47    3      NoAid    White    4
    ## 48    3      NoAid    White   -3
    ## 49    3      NoAid    White    2
    ## 50    3      NoAid    White    3
    ## 51    3      NoAid    White   -5
    ## 52    3      NoAid    White    2
    ## 53    3      NoAid    White   -1
    ## 54    3      NoAid    White   -1
    ## 55    3      NoAid    White    6
    ## 56    3      NoAid    White   -8
    ## 57    3      NoAid    White    0
    ## 58    3      NoAid    White    2
    ## 59    3 FoodStamps    Black    1
    ## 60    3 FoodStamps    Black    5
    ## 61    3 FoodStamps    Black   15
    ## 62    3 FoodStamps    Black    9
    ## 63    3 FoodStamps Hispanic    0
    ## 64    3 FoodStamps    White    4
    ## 65    3 FoodStamps    White    5
    ## 66    3 FoodStamps    White    0
    ## 67    3 FoodStamps    White    5
    ## 68    3 FoodStamps    White    2
    ## 69    3 FoodStamps    White    8
    ## 70    3 FoodStamps    White    1
    ## 71    3 FoodStamps    White   -2
    ## 72    3 FoodStamps    White    6
    ## 73    3 FoodStamps    White    6
    ## 74    3 FoodStamps    White    4
    ## 75    3 FoodStamps    White   -5
    ## 76    3 FoodStamps    White    6
    ## 77    3 FoodStamps    White    3
    ## 78    3 FoodStamps    White    7
    ## 79    3 FoodStamps    White    4
    ## 80    3 FoodStamps    White    5
    ## 81    3 FoodStamps    White   12
    ## 82    3 FoodStamps    White    3
    ## 83    3 FoodStamps    White    8
    ## 84    3 FoodStamps    White    3
    ## 85    3 FoodStamps    White    8
    ## 86    3 FoodStamps    White   13
    ## 87    3 FoodStamps    White    4
    ## 88    3 FoodStamps    White    7
    ## 89    3 FoodStamps    White    9
    ## 90    3 FoodStamps    White    3
    ## 91    3 FoodStamps    White   12
    ## 92    3 FoodStamps    White   11
    ## 93    3 FoodStamps    White    4
    ## 94    3 FoodStamps    White   12
    ## 95    4      NoAid    Black    0
    ## 96    4 FoodStamps    Black   -3
    ## 97    4 FoodStamps    White   -6
    ## 98    4 FoodStamps    White   -5
    ## 99    4 FoodStamps    White    5
    ## 100   4 FoodStamps    White    8
    ## 101   4 FoodStamps    White    5
    ## 102   4 FoodStamps    White    6
    ## 103   4 FoodStamps    White    7
    ## 104   4 FoodStamps    White    6
    ## 105   4 FoodStamps    White    2
    ## 106   4 FoodStamps    White    7
    ## 107   4 FoodStamps    White    5

``` r
summary(nutrition)
```

    ##  age           group          race         gain       
    ##  1: 7   FoodStamps:60   Black   :21   Min.   :-20.00  
    ##  2:23   NoAid     :47   Hispanic: 3   1st Qu.:  0.00  
    ##  3:64                   White   :83   Median :  3.00  
    ##  4:13                                 Mean   :  2.29  
    ##                                       3rd Qu.:  6.00  
    ##                                       Max.   : 15.00

[Nutrition data](https://rdrr.io/cran/emmeans/man/nutrition.html):

**Details:** A survey was conducted by home economists “to study how
much lower-socioeconomic-level mothers knew about nutrition and to judge
the effect of a training program designed to increase their knowledge of
nutrition.” This is a messy dataset with several empty cells.

`age` a factor with levels 1, 2, 3, 4. Mother’s age group.

`group` a factor with levels FoodStamps, NoAid. Whether or not the
family receives food stamp assistance.

`race` a factor with levels Black, Hispanic, White. Mother’s race.

`gain` a numeric vector (the response variable). Gain score (posttest
minus pretest) on knowledge of nutrition.

# Final app

Before building your dashboard, you will need to install `shiny`,
`shinydashboard`, `ggplot2`, and any other libraries appropriate for
your application. You will also need to import any datasets, pictures,
or models required.

## UI

**Functions for setting up the structure of your dashboard:**

`dashboardPage`: Wraps all other dashboard components and defines the
layout.

`dashboardSidebar`: This function creates a slide bar for navigation and
filtering, and (for this example ) exporting results.

`sidebarMenu`: Navigation function that organizes the sidebar content
into a structured menu.

`menuItem`: Defines the label, tab name, and icon for each menu item.
This function creates individual items within the sidebarMenu. Each
menuItem represents a link to a specific tab or section of your
dashboard.

**A few important functions that will allow users int interact with your
dashboard:**

`checkboxInput`: This function creates a checkbox input control,
allowing users to toggle a boolean (TRUE/FALSE) value. It is also useful
for on/off settings or enabling/disabling features (ex. jitter).

`selectInput`: This function creates a dropdown selection input control,
allowing users to choose one value from a list of options. In this case,
it will be used to select which plots you want to download.

`downloadButton`: This function creates a button that triggers a
download action.

``` r
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
```

**Functions for inserting the tables and figures:**

`dashboardBody`: This function contains the main content the user will
see when viewing and interacting with the application.

`tabItems`: This function is a container for multiple `tabItem`
elements.

`fluidRow`: This function creates a row within the dashboard layout,
allowing you to arrange elements horizontally.

`box`: This in an important component of dashboard pages. The contents
of the `box` can be (most) any Shiny UI content.

**Customizing the theme:**

`skin`: This allows you to choose from pre-defined themes to customize
your dashboard. HTML and CSS can be added to further customize the
appearance of your dashboard.

This can also be done with HTML and CSS

``` r
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
```

## Server

**Server logic for dynamic and interactive dashboards:**

`reactive`: Creates a reactive function, which is a function that
automatically re-executes whenever its dependencies (input values)
change. This ensures that any output or calculation that relies on
`reactive` is automatically updated when the underlying data changes.

`reactiveVal`: The `reactiveVal` function is used to construct a
“reactive value” object. This is an object used for reading and writing
a value, like a variable, but with special capabilities for reactive
programming. When you read the value out of a `reactiveVal` object, the
calling reactive function takes a dependency, and when you change the
value, it notifies any reactives that previously depended on that value
[Shiny
Posit](https://shiny.posit.co/r/reference/shiny/1.1.0/reactiveval.html).

**Using functions within the server:**

Step 1: Define the function `selected_data <- reactive`.

Step 2: Think, “`if` \_\_\_\_\_\_\_, then \_\_\_\_\_\_\_, `else`
\_\_\_\_\_\_\_.

Step 3: `group_by(!!sym(input$group))` groups the dataset by the
`input$group`.

``` r
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
```

**Outputs:**

- The plot outputs build on the `selected_data()` function defined
  earlier.

- `renderPrint`: Creates a reactive text output.

- `renderPlot`: Creates a reactive plot output.

- `renderDT`: Creates a reactive data table output.

- `p <- p + geom_`…

  - This initializes a ggplot2 plot object, assigning it to the variable
    p.
  - The `+` operator is used to layer different components onto the
    plot.

``` r
  output$summary <- renderPrint({
    if (input$group == "None") {
      summary(nutrition$gain)
    } else {
      selected_data() |>
        summarise(
          mean = mean(gain, na.rm = TRUE), #remove missing values before calculating
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
```

**Downloading Results:**

- `downloadHandler` Defines a download handler.
- `paste ("name of file", sep = " ", collapse = NULL, recycle0 = FALSE)`
  - `paste()`creates a dynamic filename that includes
    “nutrition_data\_”, the current date (using `Sys.Date()`), and the
    “.csv” or “.png” extension.
- `ggsave` saves the plot file.

``` r
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
```

`color = group` allows for the color of the points to reflect the
selected group.

``` r
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
```

The `emmeans` package for generating the interaction plot: Great package
for generating linear models that include factors (ex. population data).

``` r
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
```

# More Resources

[Shiny Dashboard](https://rstudio.github.io/shinydashboard/)
