# Clean and Standardize Station Names

This function cleans and standardizes station names by performing
several transformations:

## Usage

``` r
clean_station_names(name)
```

## Arguments

- name:

  A character vector of station names to be cleaned.

## Value

A character vector of cleaned station names with standardized
formatting.

## Examples

``` r
stations <- c("Mississippi Sound near Grand Pass", "Rigolets at Hwy 90 near
Slidell, LA", "EAST PEARL RIVER AT CSX RAILROAD NR CLAIBORNE, MS",
"MISSISSIPPI SOUND AT USGS MERRILL SHELL BANK LIGHT", "MISSISSIPPI SOUND AT
USGS ROUND ISLAND LIGHT, MS", "BILOXI BAY AT POINT CADET HARBOR AT BILOXI, MS")
clean_station_names(stations)
#> [1] "Grand Pass"                               
#> [2] "Rigolets, Hwy 90, Slidell"                
#> [3] "East Pearl River, Csx Railroad, Claiborne"
#> [4] "Merrill Shell Bank Light"                 
#> [5] "Round Island Light"                       
#> [6] "Biloxi Bay, Point Cadet Harbor, Biloxi"   
```
