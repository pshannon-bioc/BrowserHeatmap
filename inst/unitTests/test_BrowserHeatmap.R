library(RUnit)
library(BrowserHeatmap)
#--------------------------------------------------------------------------------
PORTS=9000:9020
#--------------------------------------------------------------------------------
runTests <- function()
{
  testConstructor();
  testWindowTitle()
  testDisplay()
  
} # runTests
#--------------------------------------------------------------------------------
testConstructor <- function()
{
   print("--- testConstructor")
   app <- BrowserHeatmap(quiet=FALSE, portRange=PORTS);
   checkTrue(ready(app))
   checkTrue(port(app) %in% PORTS)
   closeWebSocket(app)
   checkTrue(!ready(app))
   
} # testConstructor
#--------------------------------------------------------------------------------
testWindowTitle <- function()
{
   print("--- testWindowTitle")
   app <- BrowserHeatmap(PORTS, quiet=FALSE)
   checkTrue(ready(app))
   checkEquals(getBrowserWindowTitle(app), "BrowserHeatmap")
   setBrowserWindowTitle(app, "new title");
   checkEquals(getBrowserWindowTitle(app), "new title")
   closeWebSocket(app)

} # testWindowTitle
#--------------------------------------------------------------------------------
testDisplay <- function()
{
   print("--- testDisplay")
   app <- BrowserHeatmap(portRange=PORTS);
   checkTrue(ready(app))

   title <- "simple heatmap test";
   setBrowserWindowTitle(app, title)
   checkEquals(getBrowserWindowTitle(app), title)

   matrix <- matrix(sample(1:1000, size=20)/1000, nrow=4, dimnames=list(LETTERS[1:4], letters[1:5]))
   display(app, matrix)

} # testDisplay
#--------------------------------------------------------------------------------
# good use:
#   app <- demo()
#   select some points in the browser with your mouse, then
#   getSelection(app)
#
demo <- function()
{
   app <- BrowserHeatmap(portRange=PORTS);
   title <- "simple heatmap demo";
   setBrowserWindowTitle(app, title)

   matrix <- matrix(sample(1:1000, size=20)/1000, nrow=4, dimnames=list(LETTERS[1:4], letters[1:5]))

   display(app, matrix)

   app

} # demo
#--------------------------------------------------------------------------------
if(!interactive())
    runTests();
