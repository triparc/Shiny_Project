library(shiny)
shinyUI(fluidPage(
  titlePanel("Predict if tumor biopsy is malignant or not"),
  tabsetPanel(
    tabPanel(
      title= "Eda",
      h2("Exploratory Data Analysis"),
      sidebarPanel( 
      h4("Use boxplots to identify outliers:"),
      checkboxInput("Show_Outliers", "Show/Hide Boxplots ", value = TRUE),
      h4("Collinearity with logistic regression can bias our estimates."),
      h4("We will use corrplot package and examine the correlations:"),
      checkboxInput("Show_correlation", "Show/Hide CoorelationPlot", value = TRUE),
      submitButton("Submit")
      ),
      mainPanel(
        plotOutput("plot1"),
        plotOutput("plot2"))
    ),
    tabPanel(
        title="Split",
        h4("Split the dataset into train and test sets:"),
        sidebarPanel(  
        sliderInput('sampleSize', 'Split ratio for train-test data: ',value = 70, min = 60, max = 90, step = 5), 
        submitButton("Submit")
        ),
        mainPanel(
        h3("Train data:"),
        tableOutput("data1"),
        h3("Test data:"),
        tableOutput("data2"))
        ),
    tabPanel(
      title="Model",
      sidebarPanel(  
      checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
      submitButton("Submit")),
      mainPanel(
      h3("Model Fit for Tumor Type from GLM Model:"),
      plotOutput("glmfit"),
      h3("GLM Model Accuracy:"),
      textOutput("glmauc"))
    )
)))
