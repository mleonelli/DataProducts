
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(
  
  
  fluidPage(

  # Application title
  titlePanel("Life Expentancy in Italy by District 2012"),
  
  
  
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      
      uiOutput("AgeControl"),
      uiOutput("DistrictControl"),
      uiOutput("SexControl"),
      selectInput('xcol', 'X Variable', c("Age", "DeathProbability", "LifeProbability", "LifeExpentancy")),
      selectInput('ycol', 'Y Variable', c("Living", "Dead", "DeathProbability", "LifeProbability", "LifeExpentancy")),
      selectInput('facet', 'Facet By', c("Sex", "District"))
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel('Graph', plotOutput("distPlot")),
        tabPanel('Table', dataTableOutput('distTable'))
    )
    
    
  )
)))
