library(leaflet)
library(rgdal)
library(tidyverse)

geo <- readOGR("counties.json")

healthTable <- read_csv("health_ineq_online_table_11.csv")

healthData <- left_join(geo@data, healthTable, by("County" = "county_name"))
geo@data <- healthData

leaflet(geo) %>%
  addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
              opacity = 1.0, fillOpacity = 0.5)

