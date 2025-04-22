
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

### Map the stations  

This function uses `leaflet` to show the USGS monitoring stations on a map.  

``` r
map_mssnd_usgs(dat$siteInfo)
```

### Color palette  

`plot_mssnd_salinity()` takes a named vector of colors; `leaflet` does not. A common palette can be created and used in both functions as follows:  

``` r
stns <- sort(dat$siteInfo$clean_nm)

# static color palette
colors_static <- as.character(khroma::color("roma")(length(stns)))
names(colors_static) <- stns

# color function
color_function <- leaflet::colorFactor(palette = colors_static,
                                       domain = names(colors_static))

# plot and map with these palettes
plot_mssnd_salinity(dat, colors = colors_static)
map_mssnd_usgs(dat$siteInfo, color_function = color_function)
```
