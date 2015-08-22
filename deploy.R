# save token
authToken = "***"
save(authToken, file = "authToken.Rdata", ascii = TRUE)

# test locally in getwd()
library(shiny)
runApp()

# deploy application to shinyapps.io
library(shinyapps)
deployApp(appName = "swissetf")

# terminate the application
terminateApp(appName = "swissetf")
