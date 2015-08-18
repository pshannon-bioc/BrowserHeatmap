# BrowserHeatmap
An interactive d3  heatmap created from, and interactive with, an R session.
This is only a roughed-in, largely an unmodifed version of the xyplotting BrowserVizDemo
package, ready for anyone who will implement a d3 (or other) heatmap display
in javascript using the matrix passed from R.

To install and run the unit tests:

*  Needs the BrowserViz base class: biocLite("BrowserViz")
*  R CMD INSTALL BrowserViz   (need to be in the devel branch)
*  Similarly with httpuv
*  R CMD INSTAL BrowserHeatmap
*  cd BrowserHeatmap/inst/unitests
*  R -f test_BrowserHeatmap.R 

