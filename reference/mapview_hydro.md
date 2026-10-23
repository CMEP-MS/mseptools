# Interactive mapview plot with USGS Hydrography overlay

Basemap options within common R spatial packages are not entirely
satisfactory when mapping along estuarine coastlines. USGS provides a
Hydrography layer that is very useful, but is not built into said
packages. This function adds the USGS Hydrography layer to a mapview
object. This function can be used just like
[`mapview::mapview()`](https://r-spatial.github.io/mapview/reference/mapView.html).

## Usage

``` r
mapview_hydro(x, map.types = "default", layer.name = "data", ...)
```

## Arguments

- x:

  Spatial object (e.g., `sf`, `SpatVector`).

- map.types:

  Character vector of basemaps. Defaults to
  `c("Esri.OceanBasemap", "Esri.WorldGrayCanvas", "Esri.WorldTopoMap", "OpenStreetMap")`
  via an internal function.

- layer.name:

  Character name for data layer. Defaults to "data".

- ...:

  Additional arguments passed to
  [`mapview::mapview()`](https://r-spatial.github.io/mapview/reference/mapView.html).

## Value

A `mapview` object containing the modified leaflet map.

## Examples

``` r
if (FALSE) { # \dontrun{
library(mapview)
# make a map as you would otherwise with mapview
# styling is adjusted automatically
mapview_hydro(MDEQ_beach_stations,
              color = "purple",
              lwd = 2,
              col.regions = "orange",
              legend = NULL)
# give it a layer name
mapview_hydro(MDEQ_beach_stations,
              layer.name = "MDEQ Beach Stations",
              color = "purple",
              lwd = 2,
              col.regions = "orange")
# provide different basemaps
mapview_hydro(MDEQ_beach_stations,
              color = "purple",
              col.regions = "orange",
              legend = NULL,
              map.types = c("Esri.WorldTopoMap",
                            "OpenStreetMap"))
} # }
```
