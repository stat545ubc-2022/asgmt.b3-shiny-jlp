shinyUI(

  fluidPage(
    theme = shinytheme("flatly"),
    titlePanel("TrackToZero - Global Emissions Navigator"), #Title and caption description of my app
    h5("The Countdown to Net-Zero Is On!"), #Minor text under title panel 
    
    #This is the function under which all contents of the Navigation Bar will be defined/indicated
    navbarPage(         
      "Let's explore global GHG emissions data!", #Text string at the left of the NavBar (non-interactive)
      tabPanel("About", # First click-able Navigation Bar Button: Corresponding to the "About", homepage of this app.
               imageOutput("warmingstripes_img", width = "100%", height = "150px"), # Climate stripes image spanning across the top of the entire page
               br(),
               
               # Sidebar panel created to separate the hockey stick image from the main block of text (width = 5/12):
               sidebarPanel(width = 5,  
                            imageOutput("hockeystick_img", height = "100%"),
                            h5(em("Illustration of the climate hockey stick graph of rising global surface temperatures."))),
               
               # Main block of text introducing what this app. is and how it works (to the right of the sidebar in the page layout; width = 7/12)
               mainPanel(width = 7, 
                         h3("What is TrackToZero?"),
                         textOutput("overall_intro1"),
                         br(),
                         textOutput("overall_intro2"),
                         br(),
                         #textOutput("overall_intro3"),
                         #br(),
                         textOutput("overall_intro4"),
                         h3("How to use TrackToZero?"),
                         p("Please feel free to click around to explore features of the app.!"),
                         tags$b("In case you would like some instructions or guidance, here is how it works:"),
                         p("Under the 'Navigator' tab you can select whether you would like to view the emissions data by either *continent* or *economic sector*."),
                         p("Within the 'By Continent' tabPanel, you can use the slider (to select timespan) and the dropdown menu (to select the geographic region) to interact with the plot and only view the data of interest.
                            Additionally, this input will also dynamically update the data-table attached in the 'Table' sub-tab.
                            An explanation including the sector definition/classification can be found in the 'Background' sub-tab."),
                         p("Within the 'By Sector' tabPanel, you can interact with a dygraph of the global emissions time-series grouped and colored by sector. 
                            Simply scroll your mouse across the plot to view the different sectoral emissions breakdowns per year, a crosshair will follow you bolding the datapoints you hover above,
                            and the values will be displayed in the Legend at the top right corner of the plot."),
                         p("On the next 'Data Sources' tab, you can find all the information you need about where we retrieved the data used behind the scenes in this app, including hyperlinks and more!"), 
                         p("Last but not least, you can read about the developers behind this project in the 'Team' tab."), 
                         br()
                         
               ) 
      ),
      
      # Second click-able Navigation Bar Button: Corresponding to the most important plots & interactive navigation features of this app.
      navbarMenu("Navigator", # using 'navbarMenu( )' allows us to create a drop-drown menu to display numerous sub-options
                 
                 tabPanel("By sector", # Among the Navigation options: Option #1 is *by sector*
                          sidebarLayout( #To create a separate column/section for the user toggles (e.g., slider, drop-down selections), we use a sidebarLayout
                            sidebarPanel(
                              #sliderInput allows users to select the range of time displayed (anywhere within the dataset's range of 1990~2019)
                              sliderInput("timeInput", "Year", 1990, 2020, 
                                          value = c(1997,2007)),
                              #selectInput below gives users the option to select to view data from any specific continent or the entire World 
                              selectInput("continentInput", label = h3("Continent / Region"),  
                                          choices = list("Asia", "Africa", "Europe", "Oceania", "North America", "South America", "World"), 
                                          selected = 1)
                            ),
                            mainPanel(
                              tabsetPanel( #A tabset is used here in order to split the outputs relevant to "By Sector" in to separate displays 
                                              #(though all connected to the same interactive user input from the side panel)
                                tabPanel("Plot", plotOutput("emissions_timeseries", width = "100%", height = "500px")), 
                                
                                tabPanel("Table", DT::DTOutput("data_table", width = "95%")),
                                
                                tabPanel("Background", #A glossary explaining how each of the *economic sectors* are defined in this data
                                         br(),
                                         textOutput("background"),
                                         br(),
                                         tags$h4(tags$b("The 11 economic sector  used in this app are classificatied/defined as follows:")),
                                         tags$ul(
                                           tags$li(em("AGRICULTURE:"), "This covers all anthropogenic emissions from the Agriculture sector except for fuel combustion and sewage emissions, which are covered in energy and waste, respectively. Corresponding to IPCC source/sink category 4, these sub-sources include: enteric fermentation (livestock), manure management, rice rultivation, agricultural soils, and other agricultural sources."), 
                                           br(),
                                           tags$li("AVIATION & SHIPPING: This includes all direct emissions of fossil fuel combustion associated with non-road transportation, including international and domestic aviation as well as shipping."), 
                                           br(),
                                           tags$li("BUILDINGS: The buildings sector encompasses both residential and commercial (including institutional) buildings. Emissions from this sector are predominantly a function of energy consumption for diverse purposes that can be organized into three broad categories: public electricity use, direct fuel combustion, and district heating."),
                                           br(),
                                           tags$li("ELECTRICITY & HEAT: Refers mainly, but not exclusively to electricity and heat (including CHP) produced by entities whose primary activity is to supply the public. Here, this category also includes autoproducers and other energy industries. Autoproducers should ideally be allocated to the sector for which the electricity and/or heat was generated, however CO₂ and energy statistics from the IEA do not allow for this."),
                                           br(),
                                           tags$li("FUGITIVE EMISSIONS: Intentional or unintentional releases of gases from human activities. In particular, this dataset's fugitive emissions accounts for those arising form: 1) gas venting/flaring, 2) oil & natural gas systems, and 3) coal mining."),
                                           br(),
                                           tags$li("INDUSTRY: This category includes all emissions from direct industrial processes, notably including cement production as well as chemical & petrochemical production."),
                                           br(),
                                           tags$li("LAND-USE CHANGE & FORESTRY: This covers emissions & removals from forest & land-use change activities, including but not limited to 
                                                     (1) emissions and removals of CO2 from decreases or increases in biomass stocks due to forest management, logging, fuelwood collection, etc.; 
                                                     (2) conversion of existing forests and natural grasslands to other land uses; 
                                                     (3) removal of CO2 from the abandonment of formerly managed lands (e.g. croplands and pastures); and (4) 
                                                     emissions and removals of CO2 in soil associated with land-use change and management."),
                                           br(),
                                           tags$li("MANUFACTURING & CONSTRUCTION: This catagory includes the emissions created from the combustion of fuels in both the manufacturing industry (eg., food processing, plastic processing, textile processing) and the construction industry (eg., building roads, bridges, houses)."),
                                           br(),
                                           tags$li("OTHER FUEL COMBUSTION: Emissions from fuel combustion in (1) commercial and institutional buildings, (2) residential buildings, (3) agriculture, forestry, or domestic inland, coastal and deep-sea fishing, and (4) remaining non-specified emissions."),
                                           br(),
                                           tags$li("TRANSPORT: This includes all direct emissions of fossil fuel combustion associated with transport activities (minus aviation and shipping; encompassing only road transport, or motor vehicles). This sector does not include, however, emissions pertaining to the manufacture of motor vehicles or other transport equipment. Those emissions are contained in Industry."),
                                           br(),
                                           tags$li("WASTE: This includes emissions from both wastewater & landfills. Organic matter and residues from animals, plants, humans & their waste products can collect in wastewater systems and produce methane & nitrous oxide when they decompose. As for landfills, these are often low-oxygen environments, facilitating organic matter to converted to methane when it decomposes"),
                                           br()
                                         )
                                )
                              )
                            )
                          ) # end of sidebarLayout
                 ),
                 
                 tabPanel("By continent", # Among the Navigation options: Option #2 is *by continent*
                          dygraphOutput("dygraph_timeseries", width = "90%", height = "600px"))
      ),
      
      # Third click-able Navigation Bar Button: Navigates to page detailing all of the original data sources used in the development of this app.
      tabPanel("Data Sources", 
               mainPanel(
                 h3(tags$b("Where does the data come from?")),
                 p( "The idea for this Shiny application was originally inspired by", em(span("Our World In Data", style = "color:dodgerblue")), ", a project of the UK-based non-profit",  
                    em(span("Global Change Data Lab", style = "color:dodgerblue")), "with a mission to publish the 'research and data to make progress against the world’s largest problems'. 
                    With climate change being one of their focus topics, I found Our World In Data's interactive climate data plots incredibly engaging and interesting."),
                 p("The webpage that sparked my interest and nudged me to make this miniature (emissionsfocused) version of thier idea 
                              in the form of this TrackToZero App can be found here:", 
                   a(href="https://ourworldindata.org/greenhouse-gas-emissions",
                     "Our World In Data: Greenhouse Gas Emissions")),
                 p( "However, Our World In Data is not the original source of these emissions data. 
                    In fact, the raw data was actually retrieved from ", em(span("CLIMATE WATCH", style = "color:dodgerblue")), 
                   ", an open data platform managed by the", em(span("World Resources Institute", style = "color:dodgerblue")), 
                   "designed to help stakeholders gather the data to compare, analyze and evaluate countries’ efforts to address climate change."),
                h4(tags$b("Links to Data sources:")),
                p(strong(a(href="https://www.climatewatchdata.org/data-explorer/historical-emissions?historical-emissions-data-sources=cait&historical-emissions-gases=all-ghg&historical-emissions-regions=All%20Selected&historical-emissions-sectors=total-including-lucf%2Ctotal-including-lucf&page=1&sort_col=sector&sort_dir=ASC#data",
                           "RAW DATA", style = "font-size:16px; color:purple")),
                           ": The Data Explorer including access to all of the raw emissions data used for this application can be found here (available for free download)"), 
                p(strong(a(href="https://www.climatewatchdata.org/data-explorer/historical-emissions?historical-emissions-data-sources=cait&historical-emissions-gases=all-ghg&historical-emissions-regions=All%20Selected&historical-emissions-sectors=total-including-lucf%2Ctotal-including-lucf&page=1&sort_col=sector&sort_dir=ASC#meta",
                            "METADATA", style = "font-size:16px; color:purple")),
                            ": The Metadata with explanations of sources and data collection details for this Climate Watch Historical GHG Emissions dataset 
                            (previously published through CAIT Climate Data Explorer) can be found here")
             )
            ), 
      https://www.climatewatchdata.org/data-explorer/historical-emissions?historical-emissions-data-sources=cait&historical-emissions-gases=all-ghg&historical-emissions-regions=All%20Selected&historical-emissions-sectors=total-including-lucf%2Ctotal-including-lucf&page=1&sort_col=sector&sort_dir=ASC#meta
      # Fourth and final click-able Navigation Bar Button: Navigates to page with some information about me and why I built Tthis rackToZero App.
      tabPanel("Team", 
               mainPanel(imageOutput("selfie_img", height = "300px", width = "300px"),
                         h2("Jaden L. Phillips"),
                         textOutput("our_team1"),
                         br(),
                         textOutput("our_team2"),
                         br(),
                         span(textOutput("thank_note"), style = "font-size:25px; color:darkblue")
                         
               )
      )
    )
  )
)