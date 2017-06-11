---
title       : Predicting Tumor Type
subtitle    : 
author      : Rama Tripathy
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Read-And-Delete

1. Edit YAML front matter
2. Write using R Markdown
3. Use an empty line followed by three dashes to separate slides!

--- .class #id 

## Slide 1



##                            Shiny Project in R  
###                             Rama Tripathy  


--- .class #id 

## slide 2

###  Links for this project
1. https://tripathyrc.shinyapps.io/shinyproject/  
2. https://github.com/triparc/Shiny_Project  
3. References  
  - https://github.com/DataScienceSpecialization
  - http://slidify.org/start.html
  - http://slidify.org/publish.html
  - http://slidify.org/samples/intro/#1
  - http://shiny.rstudio.com/tutorial/
  
--- .class #id 

## slide 3
### Shiny app for predicting Tumor type - "benign"/"malignant"
1. Design the application in R 
  - Identify EDA tasks - Load Data, Visualize and aanyze data 
    for outlkiers and missing values
  - Split the data into Train and Test sets - Min: 60, Max: 90, default: 70
  - Model using GLM model and evaluate it using Test data
2. Design UI corresponding to these three steps and 
   create three tabs and create ui.r
3. Design the server components and create server.r
4. create an app.r and call these two components - ui.r and server.r

--- .class #id 

## Slide 4 
1. Load and analyze data

```r
library(MASS)
data(biopsy)
head(biopsy)
```

```
##        ID V1 V2 V3 V4 V5 V6 V7 V8 V9     class
## 1 1000025  5  1  1  1  2  1  3  1  1    benign
## 2 1002945  5  4  4  5  7 10  3  2  1    benign
## 3 1015425  3  1  1  1  2  2  3  1  1    benign
## 4 1016277  6  8  8  1  3  4  3  7  1    benign
## 5 1017023  4  1  1  3  2  1  3  1  1    benign
## 6 1017122  8 10 10  8  7 10  9  7  1 malignant
```


--- .class #id 

## Slide 5
1. Identify outliers
2. Impute missing values
3. Apply GLM model to fit the train data
4. Evaluate the model using test data
5. Predict for new data


---  .class #id 

