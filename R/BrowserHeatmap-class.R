library (httpuv)
library (methods)
#----------------------------------------------------------------------------------------------------
browserHeatmapBrowserFile <- system.file(package="BrowserHeatmap", "scripts", "heatmap.html")
#----------------------------------------------------------------------------------------------------
.BrowserHeatmap <- setClass ("BrowserHeatmapClass", 
                            representation = representation (),
                            contains = "BrowserVizClass",
                            prototype = prototype (uri="http://localhost", 9000)
                            )

#----------------------------------------------------------------------------------------------------
setGeneric ('display',  signature='obj', function (obj, matrix) standardGeneric ('display'))
setGeneric ('getSelection',  signature='obj', function (obj) standardGeneric ('getSelection'))
#----------------------------------------------------------------------------------------------------
setupMessageHandlers <- function()
{
   addRMessageHandler("handleResponse", "handleResponse")

} # setupMessageHandlers
#----------------------------------------------------------------------------------------------------
# constructor
BrowserHeatmap = function(portRange, host="localhost", title="BrowserHeatmap", quiet=TRUE)
{
  if(!quiet) printf("BrowserHeatmap ctor, host %s, first port: %d", host, min(portRange));
  bhm <- .BrowserHeatmap(BrowserViz(portRange, host, title, quiet, browserFile=browserHeatmapBrowserFile))
  print(bhm)
  if(!quiet) printf("BrowserHeatmp ctor finishing");

  bhm

} # BrowserHeatmap: constructor
#----------------------------------------------------------------------------------------------------
setMethod('display', 'BrowserHeatmapClass',
          
  function (obj, matrix) {
     x <- matrix[1,]
     y <- matrix[2,]
     xMin <- min(x)
     xMax <- max(x)
     yMin <- min(y)
     yMax <- max(y)

     payload <- list(rownames=rownames(matrix),
                     colnames=colnames(matrix),
                     matrix=matrix,
                     x=x,
                     y=y,
                     xMin=xMin,
                     xMax=xMax,
                     yMin=yMin,
                     yMax=yMax);
     
     send(obj, list(cmd="displayHeatmap", callback="handleResponse", status="request",
                    payload=payload));
     while (!browserResponseReady(obj)){
        if(!obj@quiet) message(sprintf("displayHeatmap waiting for browser response"));
        Sys.sleep(.1)
        }
     getBrowserResponse(obj)
     })

#----------------------------------------------------------------------------------------------------
setMethod('getSelection', 'BrowserHeatmapClass',

  function (obj) {
     send(obj, list(cmd="getSelection", callback="handleResponse", status="request", payload=""))
     while (!browserResponseReady(obj)){
        if(!obj@quiet) message(sprintf("getSelection waiting for browser response"));
        Sys.sleep(.1)
        }
     getBrowserResponse(obj)
     })

#----------------------------------------------------------------------------------------------------
