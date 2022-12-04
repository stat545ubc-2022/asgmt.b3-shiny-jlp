library(shiny)
library(tidyverse)
library(DT) #provides an R interface to the JavaScript library DataTables, allowing us to make interactive data tables
library(dygraphs) #dygraph for interactive plotting of time series data
library(shinydashboard) #to make dynamic dashboards with Shiny UI
library(shinythemes) #package containing Bootstrap themes packaged for use with Shiny applications: in this app. we use the `flatly` theme
library(hrbrthemes) #for theme_ipsum
library(viridis) #for viridis color scale
library(readxl) #to import raw data files from Excel
library(extrafont) #to embed fonts other than the basic Postscript fonts: `candara` font in this case
library(showtext) #to use non-standard fonts more easily in R graphs
library(rsconnect)
library(shinytest)

font_add(family = "candara", regular = "fonts/candara.ttf", bold = "fonts/candara-bold.ttf")
showtext_auto()

continent_ghg <- read_xlsx("data/continent_ghg.xlsx")
continent_world_ghg <- read_xlsx("data/continent_world_ghg.xlsx")

tidy_cont_wrl <- continent_world_ghg %>% 
  select(everything(), -Total) %>% 
  pivot_longer(Agriculture:`Aviation and shipping`, names_to = "Sector", values_to = "Emissions") %>%
  mutate(Emissions_Mt = Emissions/1000000) %>%#Emissions in million tons (Mt) CO₂e 
  select(everything(), -Emissions)