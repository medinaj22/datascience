library(shiny)
library(tidyverse)
library(ggplot2)
library(dplyr)
library(readr)
library(readxl)
library(leaflet)
library(rgdal)
library(readxl)

#checking of this works

function(input, output) {
  
  # ui.r leafletOut("changeableCloropleth")
  # ui.r selectInput("cloroplethSelector", choices = c("Choice1", "Choice2", "Choice3"))
 
   output$LECountyandIncomePercentile <- renderLeaflet(
    {
    
    if (input$CountyChoices == "Q1-M") {
      # code to make map #1
      geo <- readOGR("counties.json")
      
      healthTable1 <- read_csv("health_ineq_online_table_11.csv")
      
      healthData1 <- left_join(geo@data, healthTable1, by = c("COUNTY" = "county_name"))
      geo@data <- healthData1
      
      bins <- c(77, 79, 81, 83, 85, 87, 89, Inf)
      pal <- colorBin("YlOrRd", domain = healthTable1, bins = bins)
      
      leaflet(geo) %>%
        setView(-96, 37.8, 4) %>% 
        addPolygons(fillColor = ~pal(health_ineq_online_table_11$le_agg_q1_M), weight = 2, opacity = "white", dashArray = "3", fillOpacity = 0.7) %>%
        addLegend("bottomright", pal = pal, values = ~bins,
                  title = "LE by County",
                  labFormat = labelFormat(prefix = "Years: "),
                  opacity = 1
        )
      
    } 
    else if (input$CountyChoices == "Q2-M") {
      #code to make map 2
      geo <- readOGR("counties.json")
      
      healthTable1 <- read_csv("health_ineq_online_table_11.csv")
      
      healthData1 <- left_join(geo@data, healthTable1, by = c("COUNTY" = "county_name"))
      geo@data <- healthData1
      
      bins <- c(77, 79, 81, 83, 85, 87, 89, Inf)
      pal <- colorBin("YlOrRd", domain = healthTable1, bins = bins)
      
      leaflet(geo) %>%
        setView(-96, 37.8, 4) %>% 
        addPolygons(fillColor = ~pal(health_ineq_online_table_11$le_agg_q2_M), weight = 2, opacity = "white", dashArray = "3", fillOpacity = 0.7) %>%
        addLegend("bottomright", pal = pal, values = ~bins,
                  title = "LE by County",
                  labFormat = labelFormat(prefix = "Years: "),
                  opacity = 1
        )
      
    } 
    else if (input$CountyChoices == "Q3-M") {
      #code to make map 3
      geo <- readOGR("counties.json")
      
      healthTable1 <- read_csv("health_ineq_online_table_11.csv")
      
      healthData1 <- left_join(geo@data, healthTable1, by = c("COUNTY" = "county_name"))
      geo@data <- healthData1
      
      bins <- c(77, 79, 81, 83, 85, 87, 89, Inf)
      pal <- colorBin("YlOrRd", domain = healthTable1, bins = bins)
      
      
      leaflet(geo) %>%
        setView(-96, 37.8, 4) %>% 
        addPolygons(fillColor = ~pal(health_ineq_online_table_11$le_agg_q3_M), weight = 2, opacity = "white", dashArray = "3", fillOpacity = 0.7) %>%
        addLegend("bottomright", pal = pal, values = ~bins,
                  title = "LE by County",
                  labFormat = labelFormat(prefix = "Years: "),
                  opacity = 1
        )
    }
    else {
      #code to make map 4
      geo <- readOGR("counties.json")
      
      healthTable1 <- read_csv("health_ineq_online_table_11.csv")
      
      healthData1 <- left_join(geo@data, healthTable1, by = c("COUNTY" = "county_name"))
      geo@data <- healthData1
      
      bins <- c(77, 79, 81, 83, 85, 87, 89, Inf)
      pal <- colorBin("YlOrRd", domain = healthTable1, bins = bins)
      
      
      leaflet(geo) %>%
        setView(-96, 37.8, 4) %>% 
        addPolygons(fillColor = ~pal(health_ineq_online_table_11$le_agg_q4_M), weight = 2, opacity = "white", dashArray = "3", fillOpacity = 0.7) %>% 
        addLegend("bottomright", pal = pal, values = ~bins,
                  title = "LE by County",
                  labFormat = labelFormat(prefix = "Years: "),
                  opacity = 1
        )
      
    }
    
  }
  )
  
  #code for timelapse of income inequality among blacks and whites
   blackonlyincome <- read_excel("blackonlyincome.xlsx")
   whiteonlyincome <- read_excel("whiteonlyincome.xlsx")
  combined_income <- read_excel("combined income.xlsx")
  
  output$incomeplot <- renderPlot({
    combined_income%>%
      filter(Year==input$Year)%>%
      ggplot(aes(Race, `Mean Income 2019`, fill = Race)) + 
      geom_bar(stat = "identity") +
      ggtitle("Income Inequality  Over Time") +
      xlab("Race") + ylab("Average Yearly Income") +
      theme(axis.text.x = element_text(angle = 60, hjust = 1))
    
    
  })
  
  output$blackincome <- renderPlot({
    blackonlyincome%>%
      ggplot(aes(Year, `Mean Income 2019`)) +
      geom_point() +
      ggtitle("Black Income") +
      xlab("Year") + ylab("Income") +
      theme(axis.text.x = element_text(angle = 60, hjust = 1))
  })
  
  output$whiteincome <- renderPlot({
    whiteonlyincome %>%
      ggplot(aes(Year, `Mean Income 2019`)) +
      geom_point() +
      ggtitle("White Income") +
      xlab("Year") + ylab("Income") +
      theme(axis.text.x = element_text(angle = 60, hjust = 1)) 
      
      
    
  }
  )
  
  #code for life expectancy
  RaceLE_NCHSdata <- read_csv("NCHS_Death_rates_and_life_expectancy_at_birth.csv")
  
  output$LifeExpectancy <- renderPlot({
    RaceLE_NCHSdata %>%
      filter(Year == input$Years) %>%
      ggplot(aes(x = Race, y = `Average Life Expectancy (Years)`, fill = Sex))+
      geom_bar(stat = "identity") +
      theme(axis.text.x = element_text(angle = 60, hjust = 1))
    
  }
  )
  
  output$LifeExpectancypoint <- renderPlot({
    RaceLE_NCHSdata %>%
      filter(Sex == input$Sex, Race == input$Race) %>%
      ggplot(aes(Year, `Average Life Expectancy (Years)`, colour= Sex, shape = Race)) +
      geom_point() +
      theme(axis.text.x = element_text(angle = 60, hjust = 1))
      }
    )

  output$LifeExpectancyInfo <- renderDataTable({
    clickEvent<- input$LifeExpectancypointPlotClick
    RaceLE_NCHSdata %>%
      nearPoints(clickEvent)
  }
  )
  

  # County Life Expectancy Data
  health_ineq_online_table_11 <- read.csv("health_ineq_online_table_11.csv")
  CountyLevelLE <- health_ineq_online_table_11
  
  output$downloadData1 <- downloadHandler(
    filename = function() {
      paste("CountyLevelLE-", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(CountyLevelLE, file)
    }
  )
  
  # Life Expectancy at Birth by Race Data; NCHS
  RaceLE_NCHSdata <- read_csv("NCHS_Death_rates_and_life_expectancy_at_birth.csv")
  
  output$downloadData2 <- downloadHandler(
    filename = function() {
      paste("RaceLE_NCHSdata-", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(RaceLE_NCHSdata, file)
    }
  )
  
  # Income inequality by Race Data - White; Census
  
  whiteonlyCensusIncomedata <- whiteonlyincome
  
  output$downloadData3 <- downloadHandler(
    filename = function() {
      paste("whiteOnlyCensusIncomedata-", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(whiteonlyCensusIncomedata, file)
    }
  )
  
  # Income inequality by Race Data - Black; Census
  blackonlyincome2 <- read.csv("blackonlyincome2.csv")
  blackonlyCensusIncomedata <- blackonlyincome2
  
  output$downloadData4 <- downloadHandler(
    filename = function() {
      paste("blackOnlyCensusIncomedata-", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(blackonlyCensusIncomedata, file)
    }
  )
  
}
