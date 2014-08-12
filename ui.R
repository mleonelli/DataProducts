
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(
  
  
  fluidPage(

  # Application title
  titlePanel("Life Expentancy in Italy by District (2012)"),

  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      
      uiOutput("AgeControl"),
      uiOutput("DistrictControl"),
      uiOutput("SexControl"),
      selectInput('xcol', 'X Variable', c("Age", "ExpectactionOfLife", "Survivors", "Deaths", "ProbabilityOfSurviving")),
      selectInput('ycol', 'Y Variable', c("ExpectactionOfLife", "Survivors", "Deaths", "ProbabilityOfSurviving", "Age")),
      selectInput('facet', 'Facet By', c("Sex", "District"))
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel('Graph', plotOutput("distPlot")),
        tabPanel('Table', dataTableOutput('distTable')),
        tabPanel('Help', HTML('<p align="justify" class="style2"><strong>Survivors </strong>: is the number of those surviving to exact
        age x from the initial generation of 100.000 births. They are related
      to the probability of dying by the following formula:</p>'),
                 withMathJax('$$I_{x+1} = I_x * (1 - q_x)$$'),
                 HTML('<p align="justify" class="style2"><strong>Deaths </strong>: number of deaths occurring to the population
                              in age group from x to x+1, thus:</p>'),
                 withMathJax('$$d_x = I_x * q_x$$'),
                              HTML('<p align="justify" class="style2"><strong>Expectation of life </strong>: denotes the average expectation
                              of life of a group of survivors on reaching age x.</p>
                              <p align="justify" class="style2"><strong>Probability of surviving: </strong>it is the probability that
                              a person of the associated stationary population of
                              exact age x (as per lived years at the date of January 1 st of the reference
                              year) survives for one year.</p>'),
                 
                 HTML('<div style="clear: left;"><img src="https://www.gravatar.com/avatar/61cb0e95e831b37a9960a3e7179587dc" alt="" style="float: left; margin-right:5px" /></div>'),
                 strong('Author'),
                 p('Mauro Leonelli',br(),
                   'R Learner | Project Manager | Web Developer',br(),
                   a('Site', href="http://www.mauroleonelli.com/", target="_blank"),
                   '|',
                   a('LinkedIn', href="http://www.linkedin.com/in/mauroleonelli", target="_blank")  
                 ))
    )
    
    
  )
)))
