library(shiny)
library(Quandl)
# token is not commited to GitHub, replace with your own token
load("authToken.RData")
Quandl.auth(authToken)

# function to calculate the cumulative return for the price
normalize <- function(ts) {
  ind <- min(which(complete.cases(ts) == TRUE))
  sweep(ts, 2, ts[ind], "/") - 1
}

# load the time series once
tickers <- c("YAHOO/INDEX_SSMI", "GOOG/SWX_CSSMI")
names <- c("smi", "ishares")
legend <- c("SMI", "iShares SMI")
closeTickers <- sapply(tickers, function(s) { paste(s,"1",sep=".")} )
series <- Quandl(closeTickers, type = "xts")
names(series) <- names
colors <- c("red", "darkblue", "darkgreen", "darkviolet")

# define server logic
shinyServer(function(input, output) {
  calcYields <- reactive({
    yields <- normalize(last(series, paste(input$years, "years"))) * 100
  })
  output$years <- renderPrint(input$years)
  output$chart <- renderPlot({
    plot(x = calcYields()[,names[1]], xlab = "Time", ylab = "Cumulative Return [%]",
         main = "Cumulative Returns", major.ticks = "years",
         minor.ticks = FALSE, col = colors[1])
    lines(x = calcYields()[,names[2]], col = colors[2])
    legend(x = 'bottomright', lty = 1, col = colors[1:2], legend = legend)
  })
  output$smiYield <- renderPrint(as.numeric(last(calcYields())[,names[1]]))
  output$iSharesYield <- renderPrint(as.numeric(last(calcYields())[,names[2]]))
})
