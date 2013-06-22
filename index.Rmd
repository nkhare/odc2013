---
title       : How to visualize the data over Web using Shiny + R
subtitle    : Open Data Camp 2013, Hyderabad 
author      : Neependra Khare
job         : 
framework   : io2012   # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}

---

## R
1. R is a free software environment for statistical computing and graphics
2. Excellent for data visualization
3. Very active community
4. ..but..
  - Its a very personal experience 
  - Sharing is not easy
  

--- .middle 
## Shiny
Shiny = R + interactivity + web + easy

--- 

## Shiny
1. Turns R analyses into interactive web applications
2. No HTML or JavaScript knowledge is necessary
3. But fully customizable and extensible with HTML/CSS/JavaScript
3. Web UI
4. Uses “reactive” programming model
5. Free and Open Source (GPL-3)

---


## Making an App
1. Create a directory for the app
2. Create two file in that directory
  - ui.R – defines user interface
  - server.R – specifies the logic behind user interface

---

## ui.R
```
library(shiny)

shinyUI(pageWithSidebar(
  headerPanel('District Wise Rural Health Care Infrastructure'),
  sidebarPanel(
    selectInput("dataset", "Choose a States/Union Territory:",
                choices = states),
    selectInput("center", "Choose a center:",
                choices = centers ),

    downloadButton('downloadData', 'Download')
  ),
  mainPanel(
    plotOutput('plot'),
    tableOutput('table')
  )
))

```

---

## server.R
```
shinyServer(function(input, output) {
  datasetInput <- reactive({
        state = input$dataset
        center = input$center
        df = read.csv("District_Wise_Rural_HealthCare_Infrastructure.csv")
        sub = subset.data.frame(df, df$States.Union.Territory == state)
        ndf = data.frame(District = sub$Name.of.the.District, Centers = eval(parse(text = paste0("sub$",center))))
  })

  output$table <- renderTable({
    datasetInput()
  })
})

```



---

## Demo 1

- District-Wise Availability Of Health Centres In India as of March 2011
  
- Data Source
  - data.gov.in
  - The number of state-wise and district-wise availability of Sub-Centres, Primary Health Centres, Community Health Centres, Sub Divisional Hospitals and District hospitals In India.
    - http://data.gov.in/dataset/district-wise-availability-health-centres-india-march-2011
- Running from self-hosted Shiny Server
  - http://localhost:3838/demo1/
- Running from RStudio-hosted Shiny Server
  - install.packages('shiny')
  - shiny::runGist('5835958')
  

---


## Demo 2

- Enrolment for Ph D/M.phil across India between 2001-09

- Data Source 
  - data.gov.in
  - Enrolment In Higher Education According To Faculty And Stage (All India And State wise)
    - http://data.gov.in/dataset/enrolment-higher-education-according-faculty-and-stage-all-india-and-state-wise
- Running from self-hosted Shiny Server
  - http://localhost:3838/demo2/
- Running from RStudio-hosted Shiny Server
  - install.packages('shiny')
  - shiny::runGist('5836010')


---

## Deploying Shiny Apps
1. Deploy is locally
  - R package itself is not designed for web deployments
2. Self-hosted Shiny Server
  - https://github.com/rstudio/shiny-server
3. RStudio-hosted Shiny Server

--- .middle

## Questions

---

## References
- http://www.r-project.org/
- http://www.rstudio.com/shiny/
- http://joecheng.com/R/SeattleMay2013/assets/fallback/index.html\

