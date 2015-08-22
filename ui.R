library(shiny)

shinyUI(
  fluidPage(
    titlePanel("Swiss ETF"),
    p("This application compares the performance of Swiss ETFs against the SMI. 
      Just select the desired time range with the slider and the cumulative
      return and history chart is updated.
      Currently only the following indices and ETFs are supported:"),
    tags$ul(
      tags$li(tags$a(
        href="http://www.six-swiss-exchange.com/indices/security_info_de.html?id=CH0009980894CHF9",
        "SMI")), 
      tags$li(tags$a(
        href="http://www.ishares.com/ch/privatkunden/de/produkte/261154/ishares-smi-ch-fund",
        "iShares SMI"))
      ),
    
    sidebarLayout(
      sidebarPanel(
        sliderInput("years", "Time range [years]:", min = 1, max = 5, value = 3, step = 1),
        p("SMI return [%]:"),
        verbatimTextOutput("smiYield"),
        p("iShares SMI return [%]:"),
        verbatimTextOutput("iSharesYield")
      ),
      
      mainPanel(
        plotOutput("chart")
      )
    )
  )
)