library(shiny)
library(MASS)
library(plyr)
library(dplyr)
library(data.table)
library(caret)
library(rpart)
library(randomForest)
library(xgboost)
library(ggplot2)
library(Rtsne)
library(corrplot)
library(reshape2)
library(ROCR)
shinyServer(function(input, output) {
  data(biopsy)
  # remove observations with missing values
  biopsy.v2 <- na.omit(biopsy)
  biopsy.v2$ID <- NULL
  names(biopsy.v2) <- c("thick", "u.size", "u.shape", 
                     "adhsn", "s.size", "nucl",    "chrom", "n.nuc", 
                     "mit", "class")
  # Replace the class outcome with 0 or 1, where benign is zero and malignant 1
  y <- ifelse(biopsy.v2$class == "malignant", 1, 0)
  biop.m <- melt(biopsy.v2, id.var = "class")
  ind <- sample.int(n = nrow(biopsy.v2), size = floor(70*nrow(biopsy.v2)/100), replace = F)
  train <- biopsy.v2[ind,]
  test <- biopsy.v2[-ind,]
  glmmodel <-  glm(class ~ ., family = binomial, data = train)
  p <- predict(glmmodel, newdata=test)
  pr <- prediction(p, test$class)
  prf <- performance(pr, measure = "tpr", x.measure = "fpr")
  auc <- performance(pr, measure = "auc")
  auc <- auc@y.values[[1]]
  

  # Create Boxplot to identify outliers
  output$plot1 <- renderPlot({
    if (input$Show_Outliers){
      ggplot(data = biop.m, aes(x = class, y = value)) + 
      geom_boxplot() + facet_wrap(~ variable, ncol = 3)
    }
  })  
  output$plot2 <- renderPlot({
    if (input$Show_correlation){
          bc <- cor(biopsy.v2[, 1:9]) #create an object of the features
          corrplot.mixed(bc)
    }
  })    
  # Split data into train and test based on inputSamplesize
  rv <- reactive({
    sample.int(n = nrow(biopsy.v2), size = floor(input$sampleSize*nrow(biopsy.v2)/100), replace = F)
  })
  output$data1 <- renderTable({
    train <- biopsy.v2[rv(),]
    table(train$class)
  })
  output$data2 <- renderTable({
    test <- biopsy.v2[-rv(),]
    table(test$class)
  })

  output$glmfit <- renderPlot({
    train <- biopsy.v2[ind,]
    test <- biopsy.v2[-ind,]
    glmmodel <-  glm(class ~ ., family = binomial, data = train)
    p <- predict(glmmodel, newdata=test)
    pr <- prediction(p, test$class)
    prf <- performance(pr, measure = "tpr", x.measure = "fpr")
    auc <- performance(pr, measure = "auc")
    auc <- auc@y.values[[1]]
    plot(prf)
  })
  output$glmauc <- renderText({
    auc
  })
})
