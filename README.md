
# mseptools

<!-- badges: start -->
<!-- badges: end -->

The goal of mseptools is to provide R functions helpful to the Mississippi Sound Estuary Program and other MSEP-area researchers.

## Installation

You can install `mseptools` from GitHub with the following code:

``` r
# install.packages("devtools")
devtools::install_github("cmep-ms/mseptools")
```

## Example  

### Get Data  

This is a basic example of downloading a week's worth of salinity data from all USGS stations in the Mississippi Sound:

``` r
library(mseptools)
dat <- get_mssnd_data(startDate = "2025-01-01", endDate = "2025-01-08")
head(dat$data)
head(dat$daily)
head(dat$siteInfo)
```
### Plot  

This graph uses `plotly`, which makes the graphics interactive. In addition to hovering over parts of the graph to see the exact values, you can click on a legend entry to remove (or re-show) a station; double-click to show *only* that station. There is a slider bar below so you can narrow the date range. 

``` r
plot_mssnd_salinity(dat)
```  
