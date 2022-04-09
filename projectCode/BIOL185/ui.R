library(shiny)
library(shinyWidgets)
library(tidyverse)
library(ggplot2)
library(shinyWidgets)
library(leaflet)
library(rgdal)
library(shinydashboard)
library(readxl)

RaceLE_NCHSdata<-read.csv("NCHS_Death_rates_and_life_expectancy_at_birth.csv")
blackonlyincome <- read_excel("blackonlyincome.xlsx")
whiteonlyincome <- read_excel("whiteonlyincome.xlsx")
combined_income <- read_excel("combined income.xlsx")

fluidPage(
  setBackgroundColor (
    color = c("#F8F8FF", "#CFEEFA"),
    gradient = "linear",
    direction = "bottom"
  ),
  
 
  ui <- navbarPage("Inequality Navigation Bar",
                   tabPanel("Home", 
                            titlePanel("Income & Health Inequality in America"),
                            mainPanel(
                              h1("Behind the Project"),
                              p("Systematic inequality has been an overlooked undercurent for much of U.S. History.", 
                                ("America's structurual racism has created and upheld many of the racial gaps,"), 
                                "such as the wealth gap and the life expectancy disparity."),
                                ("Despite the overwelming evidence to prove such phenomena exists, many still deny it."),
                              br(),
                              p("For these reasons we decided to look at income disparity between whites and blacks over time in the U.S.
        as well as life expectancy in U.S. counties as of 2017 to show how such disparities have changed and still remain. If this topic interests you, further reasearch can be done here.",
                                a("Pew Research Center.", 
                                  href = "https://www.pewsocialtrends.org/2016/06/27/1-demographic-trends-and-economic-well-being/")),
                              br(),
                              h1(""),
                              p(""),
                              p("" 
                              ),
                              p(""),
                              p("")
                            )
                   ),
                   tabPanel("Life Expectancy Disparity by Race",
                   
                   sidebarPanel(
                     sliderInput(inputId ="Years",
                                 label = "Year",
                                 min = 1900,
                                 max = 2019,
                                 value = 1900,
                                 animate = animationOptions(interval = 1000, loop = FALSE)
                     ),
                     
                     selectInput(inputId = "Sex",
                                 label = "Select Sex",
                                 multiple = TRUE,
                                 choices = unique(RaceLE_NCHSdata$Sex),
                                 selected = "Both Sexes"),
                     
                     selectInput(inputId = "Race",
                                 label = "Select Race",
                                 multiple = TRUE,
                                 choices = unique(RaceLE_NCHSdata$Race),
                                 selected = "All Races")
                     
                     
                   ),
                   mainPanel(
                     plotOutput("LifeExpectancy"),
                     plotOutput("LifeExpectancypoint",
                                click = "LifeExpectancypointPlotClick")
                   ),
                   dataTableOutput("LifeExpectancyInfo")
                   ),

                   tabPanel("Life Expectancy by Counties",
                            leafletOutput("LECountyandIncomePercentile"),
                            selectInput("CountyChoices", "Select County Dataset", choices = c("Q1-M", "Q2-M", "Q3-M", "Q4-M")),
                            p("What is being mapped is Life Expectancy in U.S counties based on income quartiles (I believe the authors mean quintiles, yet that
                              was on their data key). Taking this into perspective with the visualization, the map should be interpreted as this, 'If I am in Q1 (lowest quintile) this is my life expectancy in said county. The same should go for the other income quartiles listed (Q2, Q3, Q4).")
                            ),
             
                   tabPanel("Income Disparity",
                   sidebarPanel(
                     sliderInput(inputId ="Year" ,
                                 label = "Year" ,
                                 min = 1980 ,
                                 max = 2019,
                                 value = 1980,
                                 animate = animationOptions(interval = 1000, loop = FALSE)
                     )
                                 
                      ),
                     mainPanel(
                       plotOutput("incomeplot"),
                       plotOutput("blackincome"),
                       plotOutput("whiteincome")
                     )
                     ),
                   
                   tabPanel("Data & Acknowlegments",
                            h2("Acknowledgments"),
                            p("We would first like to thank Dr. Gregg Whitworth for assisting us with this project. He helped
               with everything from the brainstorming process to helping us create the code for visualizing the data we found.
               We would also like to thank Dr. Jonathan Eastwood as he provided advice on the brainstorming and execution aspects of this
               project which were helpful considering this topic is his speciality."),
                            br(),
                            p("We hope that these results find their way to people who can continue carrying out the analysis that we started
               as a class project. Future projects could show the inequality between whites and other races/ethnicities in America,
               such as Hispanics and Asians,  or compare other areas of inequality."),
                            br(),
                            p("The data used in this project came form the CDC, the Census, and other publicly available domains. So that future studies may have the data readily available,
               we have decided to post post all data that was used for download below. We hope that more research into the issues of systemic inequalties will be done in the future to highlight
                              the severity of said issues and what can be done to mitigate it. "),
                            h4("Download County-level Life Expectancy Data"),
                            downloadBttn(
                              outputId = "downloadData1",
                              style = "pill",
                              color = "primary",
                              size = "sm"
                            ),
                            h4("Download Life Expectancy by Race Data"),
                            downloadBttn(
                              outputId = "downloadData2",
                              style = "pill",
                              color = "primary",
                              size = "sm"
                            ),
                            h4("Download Income Inequality by Race Data - White"),
                            downloadBttn(
                              outputId = "downloadData3",
                              style = "pill",
                              color = "primary",
                              size = "sm"
                            ),
                            h4("Download Income Inequality by Race Data - Black"),
                            downloadBttn(
                              outputId = "downloadData4",
                              style = "pill",
                              color = "primary",
                              size = "sm"
                            ) 
                   )
  )
)
