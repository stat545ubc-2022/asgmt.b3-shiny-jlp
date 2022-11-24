library(shiny)
library(tidyverse)
library(DT)
library(dygraphs)
library(shinydashboard)
library(shinythemes)
library(hrbrthemes)
library(viridis)
library(readxl)
library(extrafont)
library(showtext)
library(here)
library(rsconnect)
rsconnect::deployApp("~/Desktop/STAT545/shiny_app/TrackToZero")

font_add(family = "candara", regular = "candara.ttf", bold = "candara-bold.ttf")
showtext_auto()

#ghg_emissions<- read_xlsx("~/Desktop/STAT545/shiny_app/TrackToZero/ghg_emissions.xlsx")
#country_ghg <- read_xlsx("~/Desktop/STAT545/shiny_app/TrackToZero/country_ghg.xlsx")
continent_ghg<- read_xlsx(here::here("continent_ghg.xlsx"))
continent_world_ghg <- read_xlsx(here::here("continent_world_ghg.xlsx"))

#tidy_country_emissions <- country_ghg %>%
#    pivot_longer(Agriculture:`Aviation and shipping`, names_to = "Sector", values_to = "Emissions") 
#tidy_continent_emissions <- continent_ghg %>% 
#                              select(everything(), -Total) %>% 
#                              pivot_longer(Agriculture:`Aviation and shipping`, names_to = "Sector", values_to = "Emissions") 
tidy_cont_wrl <- continent_world_ghg %>% 
  select(everything(), -Total) %>% 
  pivot_longer(Agriculture:`Aviation and shipping`, names_to = "Sector", values_to = "Emissions") %>%
  mutate(Emissions_Mt = Emissions/1000000) %>%#Emissions in million tons (Mt) CO₂e 
  select(everything(), -Emissions)