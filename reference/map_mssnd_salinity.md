# Create interactive salinity map for Mississippi Sound data

Creates an interactive leaflet map displaying salinity data from USGS
stations in the Mississippi Sound area. This is a convenience function
that combines the create_mssnd_basemap, add_salinity_points, and
add_salinity_legend functions in a single call.

## Usage

``` r
map_mssnd_salinity(data, palette = "YlGnBu", domain = c(0, 40))
```

## Arguments

- data:

  A data frame containing salinity data for a single date, generally
  created by joining the \$daily and \$siteInfo components of output
  from the get_mssnd_data() function, then filtered to a single date.
  Must include the following columns:

  - dec_lon_va: Decimal longitude of station

  - dec_lat_va: Decimal latitude of station

  - sal_mean: Daily mean salinity in parts per thousand (ppt)

  - clean_nm: Station name

  - site_no: USGS site number

- palette:

  Character string specifying the color palette name (default: "YlGnBu")

- domain:

  Numeric vector of length 2 specifying the domain range (default: c(0,
  40))

## Value

A leaflet map object centered on the Mississippi Sound area
(approximately 30.25°N, 89.15°W) with station markers colored by
salinity values.

## Note

This function is currently specific to USGS station data format. The
input should represent data from a single date.

## Examples

``` r
# Using the included mssnd_salinity example dataset
to_map <- dplyr::left_join(mssnd_salinity$daily, mssnd_salinity$siteInfo) |>
    dplyr::filter(date == as.Date("2023-06-01"))
#> Joining with `by = join_by(site_no)`
map_mssnd_salinity(to_map)

{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"setView":[[30.25,-89.15000000000001],9,[]],"calls":[{"method":"addProviderTiles","args":["CartoDB.Positron",null,"Positron (CartoDB)",{"errorTileUrl":"","noWrap":false,"detectRetina":false}]},{"method":"addProviderTiles","args":["Esri",null,"Esri",{"errorTileUrl":"","noWrap":false,"detectRetina":false}]},{"method":"addLayersControl","args":[["Positron (CartoDB)","Esri"],[],{"collapsed":true,"autoZIndex":true,"position":"topright"}]},{"method":"addCircleMarkers","args":[[30.12277778,30.16694444,30.23825405,30.25444444,30.3186111,30.38833333],[-89.25027780000001,-89.74055559999999,-89.24281938999999,-88.86888888999999,-88.9722222,-88.8572222],11,null,null,{"interactive":true,"className":"","stroke":true,"color":"black","weight":0.7,"opacity":0.5,"fill":true,"fillColor":["#64C1C0","#F5FBC3","#83CEBB","#36A7C3","#6FC6BE","#A6DBB8"],"fillOpacity":1},null,null,null,null,["17.5 ppt<br>Grand Pass<br>USGS-300722089150100","2.8 ppt<br>Rigolets, Hwy 90, Slidell<br>USGS-301001089442600","14.7 ppt<br>Merrill Shell Bank Light<br>USGS-301429089145600","22 ppt<br>East Ship Island Light<br>USGS-301527088521500","16.6 ppt<br>Gulfport Light<br>USGS-301912088583300","12.4 ppt<br>Biloxi Bay, Point Cadet Harbor, Biloxi<br>USGS-302318088512600"],{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]},{"method":"addLegend","args":[{"colors":["#FFFFD9 , #EDF8B1 12.5%, #7FCDBB 37.5%, #1D91C0 62.5%, #253494 87.5%, #081D58 "],"labels":["5","15","25","35"],"na_color":null,"na_label":"NA","opacity":0.8,"position":"bottomright","type":"numeric","title":"Salinity<br>(ppt)","extra":{"p_1":0.125,"p_n":0.875},"layerId":null,"className":"info legend","group":null}]}],"limits":{"lat":[30.12277778,30.38833333],"lng":[-89.74055559999999,-88.8572222]}},"evals":[],"jsHooks":[]}
# Same example dataset, but a date where only 2 stations have a daily average
to_map <- dplyr::left_join(mssnd_salinity$daily, mssnd_salinity$siteInfo) |>
    dplyr::filter(date == as.Date("2020-06-01"))
#> Joining with `by = join_by(site_no)`
map_mssnd_salinity(to_map)

{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"setView":[[30.25,-89.15000000000001],9,[]],"calls":[{"method":"addProviderTiles","args":["CartoDB.Positron",null,"Positron (CartoDB)",{"errorTileUrl":"","noWrap":false,"detectRetina":false}]},{"method":"addProviderTiles","args":["Esri",null,"Esri",{"errorTileUrl":"","noWrap":false,"detectRetina":false}]},{"method":"addLayersControl","args":[["Positron (CartoDB)","Esri"],[],{"collapsed":true,"autoZIndex":true,"position":"topright"}]},{"method":"addCircleMarkers","args":[[30.12277778,30.16694444],[-89.25027780000001,-89.74055559999999],11,null,null,{"interactive":true,"className":"","stroke":true,"color":"black","weight":0.7,"opacity":0.5,"fill":true,"fillColor":["#D3EEB3","#FCFED2"],"fillOpacity":1},null,null,null,null,["8.5 ppt<br>Grand Pass<br>USGS-300722089150100","0.8 ppt<br>Rigolets, Hwy 90, Slidell<br>USGS-301001089442600"],{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]},{"method":"addLegend","args":[{"colors":["#FFFFD9 , #EDF8B1 12.5%, #7FCDBB 37.5%, #1D91C0 62.5%, #253494 87.5%, #081D58 "],"labels":["5","15","25","35"],"na_color":null,"na_label":"NA","opacity":0.8,"position":"bottomright","type":"numeric","title":"Salinity<br>(ppt)","extra":{"p_1":0.125,"p_n":0.875},"layerId":null,"className":"info legend","group":null}]}],"limits":{"lat":[30.12277778,30.16694444],"lng":[-89.74055559999999,-89.25027780000001]}},"evals":[],"jsHooks":[]}
```
