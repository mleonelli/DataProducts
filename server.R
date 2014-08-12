
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
  data <- read.csv("datiprovincialicompleti2012.csv")
  data$District <- as.character(data$District)
  
  output$AgeControl <- renderUI({
    sliderInput(inputId = "age", label = "Choose an age range:", min = min(data$Age), max =  max(data$Age), step = 1, value = c(min(data$Age), max(data$Age)))
  })
  
  output$DistrictControl <- renderUI({
    selectizeInput(inputId = "district", 
                   label = "Choose up to 10 districts:", 
                   choices = unique(data$District), 
                   multiple = TRUE, 
                   selected = c("Milano", "Roma"),
                   options = list(maxItems = 10)
                 )
  })
  output$SexControl <- renderUI({
    selectizeInput(inputId = "sex", label = "Choose a sex:",choices=c("Male", "Female"), multiple= TRUE, selected = c("Female"))
  })
  
  output$distPlot <- renderPlot({
    
    xcol <- input$xcol
    ycol <- input$ycol
    selectedData <- data[data$District %in% input$district, ]
    selectedData <- selectedData[selectedData$Sex %in% input$sex, ]
    selectedData <- selectedData[selectedData$Age >= input$age[1] & selectedData$Age <= input$age[2], c(xcol, ycol, "District", "Sex")]
    
    
    g <- ggplot(aes_string(x = xcol, y = ycol), data = selectedData)
    if(input$facet == "Sex"){
      g + facet_grid(. ~ Sex) + geom_line(aes(color = District)) + geom_point(aes(color = District))
    }
    else{
      g + facet_grid(. ~ District) + geom_line(aes(color = Sex)) + geom_point(aes(color = Sex))
    }

  })
  
  output$distTable <- renderDataTable({
    selectedData <- data[data$District %in% input$district, ]
    selectedData <- selectedData[selectedData$Sex %in% input$sex, ]
    selectedData <- selectedData[selectedData$Age >= input$age[1] & selectedData$Age <= input$age[2], ]
    
    selectedData
  })
  
})
