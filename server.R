shinyServer(function(input, output) {
  
  filtered_data <-
    reactive({
      tidy_cont_wrl %>%
        filter(Year > input$timeInput[1] &
                 Year < input$timeInput[2] &
                 Continent == input$continentInput) 
    })
  
  
  filtered_data_dy <-
    reactive({
      continent_ghg %>%
        select(Year, Continent, Total) %>%
        mutate(Total = Total/1000000) %>%
        pivot_wider(names_from = Continent, values_from = Total)
    })
  
  
# ABOUT
  
  output$warmingstripes_img <-renderImage({
    list(src = "www/warmingstripes_img.png", width = "100%", height = 150)
  }, deleteFile = F)
  
  
  output$hockeystick_img <-renderImage({
    list(src = "www/hockeystick_img.png", width = "100%")
  }, deleteFile = F)
  
  
  output$overall_intro1 <-renderText({
    "TrackToZero Emissions Navigator is an online platform and shiny application designed to empower researchers, policymakers, 
    the general public and beyond with open climate data and visualizations to gather insights on national, sectoral, and and global progress on climate change.
    Specifically, TrackToZero provides a simple, miniature data explorer to quickly access, plot, and visualize greenhouse gas  (GHG) emissions data from around the world over the last three decades."
  })
  
  output$overall_intro2 <-renderText({
    "Emissions come from a diverse variety of sources -- be that continents, nations or sectors -- and we need many solutions to decarbonize the economy. 
     So, what are these sources of GHG emissions & how much do each of them contribute? This app has created some interactive plots and elements in order to help you find out just that!"
  })
  
  #output$overall_intro3 <-renderText({
  #  "In a global overview: About 60% of GHG emissions come from just 10 countries, while the 100 least-emitting have contributed less than 3%.
  #   The domain of *Energy* accounts for nearly three-quarters (73%) of all global emissions, followed by Agriculture (18%). 
  #   Within the Energy domain, the largest emitting sector is Electricity and Heat Generation (30%), followed by Transportation (18%) and Manufacturing (12%). 
  #   Land use-change and forestry (+4%) is special in that it can be both a source and sink of emissions, and thus may be a key sector to reach net-zero."
  #})
  
  output$overall_intro4 <-renderText({
    "This app is significantly inspired by and based off of the **Climate Watch database**, which brings together dozens of open-source datasets for users to explore the Nationally Determined Contributions (NDCs)
    under the Paris Agreement, access historical emissions data, discover how countries can leverage their climate goals to achieve their sustainable development objectives,
    and use models to map new pathways to a lower-carbon, sustainable and  prosperous future."
  })   
  
  
# NAVIGATOR
  
  output$emissions_timeseries <- 
    renderPlot({
      filtered_data() %>%
        ggplot(aes(x = Year, y = Emissions_Mt, fill = Sector)) +
        geom_area(alpha=0.7, colour="white") +
        ggtitle("Stacked Timeseries of Emissions Across Economic Sectors") +
        ylab("Annual Total GHG Emissions (Mt CO₂e)") + 
        scale_y_continuous(breaks = waiver())+
        scale_fill_viridis(discrete = T) +
        theme_ipsum() +
        theme(text = element_text(family = "candara", size = 15), 
              plot.title = element_text(family = "candara", size = 21, face = "bold"),
              axis.text.x = element_text(family = "candara", size = 14),
              axis.text.y = element_text(family = "candara", size = 14),
              axis.title.x = element_text(family = "candara", vjust = -3, hjust = 0.5, size = 15, face = "bold"), 
              axis.title.y = element_text(family = "candara", vjust = +3, hjust = 0.5, size = 15, face = "bold"))
    })
  
  
  output$data_table <-
    DT::renderDT({
      filtered_data() 
    })
  
  
  output$dygraph_timeseries <- 
    renderDygraph({
      filtered_data_dy() %>%
        dygraph(main = "Timeseries of GHG Emissions Across Continents", width = 700, height = 500) %>% 
        dyAxis("x", label = "Year", drawGrid = TRUE, 
               axisLabelFontSize = 13) %>%
        dyAxis("y", label = "Annual Total GHG Emissions (Mt CO₂e)", pixelsPerLabel=40, 
               axisLabelFontSize = 13) %>%
        dyLegend(show = "always", width = 200, labelsSeparateLines = TRUE) %>%
        dyHighlight(highlightCircleSize = 5, highlightSeriesBackgroundAlpha = 0.4, hideOnMouseOut = FALSE)  %>%
        dyCrosshair(direction = "vertical") %>%
        dyOptions(strokeWidth = 2.5,
                  colors = RColorBrewer::brewer.pal(6, "Spectral"), 
                  colorSaturation = 0.8,
                  axisLineColor = "navy", 
                  gridLineColor = "lightblue", 
                  digitsAfterDecimal = 0) 
    })
  
  output$background <- renderText({
    "To know what’s included in each sector category, the data scientists at Our World In Data have provided a short description of each. 
    These descriptions are based on explanations provided in the IPCC’s Fifth Assessment Report AR5) and methodology papers published by the World Resources Institute."
    
  })
  
  
# DATA SOURCES - 
## Did not end up using any code here as the contents of this Data Sources page were directly provided/defined in the ui.R input file
       
  
# TEAM
  
  output$selfie_img <-renderImage({
    list(src = "www/selfie_img.png", width = 300, height = 300)
  }, deleteFile = F)
  
  output$our_team1 <- renderText({
    "Hello, creatures of the internet! I am a climate activist and MSc student studying Environmental Science and climate change communcation at the University of
    British Columbia (UBC) in Vancouver, Canada. All of the design and code for this app are created in RStudio version 2022.07.2+576 with the Shiny Web App."
  })
  
  output$our_team2 <- renderText({
    "Climate change, arguably the greatest challenge of our generation and of the 21st century, is driven by human-caused greenhouse gas (GHG) emissions.
    Addressing climate change is a wicked problem and it will take all of us. 
    It is therefore critical that the trajectory of global and national emissions are made easily accessible to anyone. 
    This simple but interactive Shiny App. was designed with the belief that increasing awareness and basic climate change literacy is an important starting point. 
    Only if people are aware of the problem of rising emissions and can see the data for themselves will they want to join the tide of changemakers to address this challenge together."
  })
  
  output$thank_note <- renderText({
    "Thank you for your attention to my project and the climate crisis!
    The time for climate action is now!"
  })
  
})
