# TrackToZero: Greenhouse Gas Emissions Navigator
Quick access to the app: https://jadenphillips.shinyapps.io/tracktozero/

This is STATS545 B Assignment #4's Option C - upgrading my own Shiny app


### What is the TrackToZero App?
**TrackToZero** Emissions Navigator is an online platform and shiny application designed to empower researchers, policymakers, the general public and beyond with open climate data and visualizations to gather insights on national, sectoral, and and global progress on climate change. Specifically, TrackToZero provides a simple, miniature data explorer to quickly access, plot, and visualize greenhouse gas (GHG) emissions data from around the world over the last three decades.

Emissions come from a diverse variety of sources -- be that continents, nations or sectors -- and we need many solutions to decarbonize the economy. So, what are these sources of GHG emissions & how much do each of them contribute? This app has created some interactive plots and elements in order to help you find out just that!


### What is the source of data in this App?

The idea for this Shiny app. was originally inspired by ***Our World In Data***, a project of the UK-based non-profit Global Change Data Lab with a mission to publish the 'research and data to make progress against the world’s largest problems'. 

However, *Our World In Data* is not the original source of these emissions data. In fact, the raw data was actually retrieved from ***CLIMATE WATCH***, an open data platform managed by the *World Resources Institute* designed to help stakeholders gather the data to compare, analyze and evaluate countries’ efforts to address climate change. The exact data used behind the scenes in the development of this app, involving historical greenhouse gas emissiond between 1990~2019, can be found here:
- The **Raw Data**: https://www.climatewatchdata.org/data-explorer/historical-emissions?historical-emissions-data-sources=cait&historical-emissions-gases=all-ghg&historical-emissions-regions=All%20Selected&historical-emissions-sectors=total-including-lucf%2Ctotal-including-lucf&page=1&sort_col=sector&sort_dir=ASC#data
- The **Metadata**: https://www.climatewatchdata.org/data-explorer/historical-emissions?historical-emissions-data-sources=cait&historical-emissions-gases=all-ghg&historical-emissions-regions=All%20Selected&historical-emissions-sectors=total-including-lucf%2Ctotal-including-lucf&page=1&sort_col=sector&sort_dir=ASC#meta
