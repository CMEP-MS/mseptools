# Add USGS Hydrography overlay to a tmap object

Basemap options within common R spatial packages are not entirely
satisfactory when mapping along estuarine coastlines. USGS provides a
Hydrography layer that is very useful, but is not built into said
packages. This function adds the USGS Hydrography layer to a tmap object
that has already been created. In view mode, the output is turned into
an interactive leaflet object. In plot mode, it remains a tmap object.
This function works with vector objects but is currently untested on
rasters.

## Usage

``` r
tmap_hydro(tm_obj, base_groups = "default")
```

## Arguments

- tm_obj:

  A `tmap` object. **Note**, do not add a `tm_basemap` layer if using
  plot mode - it will error.

- base_groups:

  Character vector of basemaps, for use in "view" mode. Defaults to
  `c("Esri.WorldTopoMap", "Esri.WorldGrayCanvas", "OpenStreetMap")` via
  an internal function.

## Value

A map object: in plot mode, a regular `tmap` object; in view mode, a
`leaflet` map object.

## Examples
