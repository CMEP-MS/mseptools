# Add a salinity legend to a leaflet map

Adds a legend for salinity values to the bottom right of a leaflet map.

## Usage

``` r
add_salinity_legend(
  map,
  palette = "YlGnBu",
  domain = c(0, 40),
  color_function = NULL,
  position = "bottomright",
  opacity = 0.8
)
```

## Arguments

- map:

  A leaflet map object

- palette:

  Character string specifying the color palette name (default: "YlGnBu")

- domain:

  Numeric vector of length 2 specifying the domain range for colors
  (default: c(0, 40))

- color_function:

  Optional pre-created color function (overrides palette and domain if
  provided)

- position:

  Character string specifying the position of the legend (default:
  "bottomright")

- opacity:

  Numeric opacity of the legend (default: 0.8)

## Value

A leaflet map object with added legend

## Examples

``` r
# generate salinity data to map
to_map <- dplyr::left_join(mssnd_salinity$daily, mssnd_salinity$siteInfo) |>
    dplyr::filter(date == as.Date("2023-06-01"))
#> Joining with `by = join_by(site_no)`

# create base map
my_map <- create_mssnd_basemap()

# Add points, using default color palette
my_map  |>
    add_salinity_points(to_map)

{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"setView":[[30.25,-89.15000000000001],9,[]],"calls":[{"method":"addProviderTiles","args":["CartoDB.Positron",null,"Positron (CartoDB)",{"errorTileUrl":"","noWrap":false,"detectRetina":false}]},{"method":"addProviderTiles","args":["Esri",null,"Esri",{"errorTileUrl":"","noWrap":false,"detectRetina":false}]},{"method":"addLayersControl","args":[["Positron (CartoDB)","Esri"],[],{"collapsed":true,"autoZIndex":true,"position":"topright"}]},{"method":"addCircleMarkers","args":[[30.12277778,30.16694444,30.23825405,30.25444444,30.3186111,30.38833333],[-89.25027780000001,-89.74055559999999,-89.24281938999999,-88.86888888999999,-88.9722222,-88.8572222],11,null,null,{"interactive":true,"className":"","stroke":true,"color":"black","weight":0.7,"opacity":0.5,"fill":true,"fillColor":["#64C1C0","#F5FBC3","#83CEBB","#36A7C3","#6FC6BE","#A6DBB8"],"fillOpacity":1},null,null,null,null,["17.5 ppt<br>Grand Pass<br>USGS-300722089150100","2.8 ppt<br>Rigolets, Hwy 90, Slidell<br>USGS-301001089442600","14.7 ppt<br>Merrill Shell Bank Light<br>USGS-301429089145600","22 ppt<br>East Ship Island Light<br>USGS-301527088521500","16.6 ppt<br>Gulfport Light<br>USGS-301912088583300","12.4 ppt<br>Biloxi Bay, Point Cadet Harbor, Biloxi<br>USGS-302318088512600"],{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"limits":{"lat":[30.12277778,30.38833333],"lng":[-89.74055559999999,-88.8572222]}},"evals":[],"jsHooks":[]}
# Add points and legend, using default color palette
my_map  |>
    add_salinity_points(to_map) |>
    add_salinity_legend()

{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"setView":[[30.25,-89.15000000000001],9,[]],"calls":[{"method":"addProviderTiles","args":["CartoDB.Positron",null,"Positron (CartoDB)",{"errorTileUrl":"","noWrap":false,"detectRetina":false}]},{"method":"addProviderTiles","args":["Esri",null,"Esri",{"errorTileUrl":"","noWrap":false,"detectRetina":false}]},{"method":"addLayersControl","args":[["Positron (CartoDB)","Esri"],[],{"collapsed":true,"autoZIndex":true,"position":"topright"}]},{"method":"addCircleMarkers","args":[[30.12277778,30.16694444,30.23825405,30.25444444,30.3186111,30.38833333],[-89.25027780000001,-89.74055559999999,-89.24281938999999,-88.86888888999999,-88.9722222,-88.8572222],11,null,null,{"interactive":true,"className":"","stroke":true,"color":"black","weight":0.7,"opacity":0.5,"fill":true,"fillColor":["#64C1C0","#F5FBC3","#83CEBB","#36A7C3","#6FC6BE","#A6DBB8"],"fillOpacity":1},null,null,null,null,["17.5 ppt<br>Grand Pass<br>USGS-300722089150100","2.8 ppt<br>Rigolets, Hwy 90, Slidell<br>USGS-301001089442600","14.7 ppt<br>Merrill Shell Bank Light<br>USGS-301429089145600","22 ppt<br>East Ship Island Light<br>USGS-301527088521500","16.6 ppt<br>Gulfport Light<br>USGS-301912088583300","12.4 ppt<br>Biloxi Bay, Point Cadet Harbor, Biloxi<br>USGS-302318088512600"],{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]},{"method":"addLegend","args":[{"colors":["#FFFFD9 , #EDF8B1 12.5%, #7FCDBB 37.5%, #1D91C0 62.5%, #253494 87.5%, #081D58 "],"labels":["5","15","25","35"],"na_color":null,"na_label":"NA","opacity":0.8,"position":"bottomright","type":"numeric","title":"Salinity<br>(ppt)","extra":{"p_1":0.125,"p_n":0.875},"layerId":null,"className":"info legend","group":null}]}],"limits":{"lat":[30.12277778,30.38833333],"lng":[-89.74055559999999,-88.8572222]}},"evals":[],"jsHooks":[]}
# Add points and legend, using non-default existing palette
my_map  |>
    add_salinity_points(to_map, palette = "Spectral") |>
    add_salinity_legend(palette = "Spectral")

{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"setView":[[30.25,-89.15000000000001],9,[]],"calls":[{"method":"addProviderTiles","args":["CartoDB.Positron",null,"Positron (CartoDB)",{"errorTileUrl":"","noWrap":false,"detectRetina":false}]},{"method":"addProviderTiles","args":["Esri",null,"Esri",{"errorTileUrl":"","noWrap":false,"detectRetina":false}]},{"method":"addLayersControl","args":[["Positron (CartoDB)","Esri"],[],{"collapsed":true,"autoZIndex":true,"position":"topright"}]},{"method":"addCircleMarkers","args":[[30.12277778,30.16694444,30.23825405,30.25444444,30.3186111,30.38833333],[-89.25027780000001,-89.74055559999999,-89.24281938999999,-88.86888888999999,-88.9722222,-88.8572222],11,null,null,{"interactive":true,"className":"","stroke":true,"color":"black","weight":0.7,"opacity":0.5,"fill":true,"fillColor":["#FFEC9E","#C42F4B","#FED07E","#F3FAAC","#FEE593","#FDB365"],"fillOpacity":1},null,null,null,null,["17.5 ppt<br>Grand Pass<br>USGS-300722089150100","2.8 ppt<br>Rigolets, Hwy 90, Slidell<br>USGS-301001089442600","14.7 ppt<br>Merrill Shell Bank Light<br>USGS-301429089145600","22 ppt<br>East Ship Island Light<br>USGS-301527088521500","16.6 ppt<br>Gulfport Light<br>USGS-301912088583300","12.4 ppt<br>Biloxi Bay, Point Cadet Harbor, Biloxi<br>USGS-302318088512600"],{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]},{"method":"addLegend","args":[{"colors":["#9E0142 , #DD4B4D 12.5%, #FED480 37.5%, #D8EF9B 62.5%, #4596B7 87.5%, #5E4FA2 "],"labels":["5","15","25","35"],"na_color":null,"na_label":"NA","opacity":0.8,"position":"bottomright","type":"numeric","title":"Salinity<br>(ppt)","extra":{"p_1":0.125,"p_n":0.875},"layerId":null,"className":"info legend","group":null}]}],"limits":{"lat":[30.12277778,30.38833333],"lng":[-89.74055559999999,-88.8572222]}},"evals":[],"jsHooks":[]}
# Add points and legend, using custom domain
my_map  |>
    add_salinity_points(to_map, domain = c(5, 35)) |>
    add_salinity_legend(domain = c(5, 35))
#> Warning: Some values were outside the color scale and will be treated as NA
#> Warning: Some values were outside the color scale and will be treated as NA

{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"setView":[[30.25,-89.15000000000001],9,[]],"calls":[{"method":"addProviderTiles","args":["CartoDB.Positron",null,"Positron (CartoDB)",{"errorTileUrl":"","noWrap":false,"detectRetina":false}]},{"method":"addProviderTiles","args":["Esri",null,"Esri",{"errorTileUrl":"","noWrap":false,"detectRetina":false}]},{"method":"addLayersControl","args":[["Positron (CartoDB)","Esri"],[],{"collapsed":true,"autoZIndex":true,"position":"topright"}]},{"method":"addCircleMarkers","args":[[30.12277778,30.16694444,30.23825405,30.25444444,30.3186111,30.38833333],[-89.25027780000001,-89.74055559999999,-89.24281938999999,-88.86888888999999,-88.9722222,-88.8572222],11,null,null,{"interactive":true,"className":"","stroke":true,"color":"black","weight":0.7,"opacity":0.5,"fill":true,"fillColor":["#6EC5BE","#808080","#9ED8B8","#32A2C2","#7BCBBC","#C8E9B4"],"fillOpacity":1},null,null,null,null,["17.5 ppt<br>Grand Pass<br>USGS-300722089150100","2.8 ppt<br>Rigolets, Hwy 90, Slidell<br>USGS-301001089442600","14.7 ppt<br>Merrill Shell Bank Light<br>USGS-301429089145600","22 ppt<br>East Ship Island Light<br>USGS-301527088521500","16.6 ppt<br>Gulfport Light<br>USGS-301912088583300","12.4 ppt<br>Biloxi Bay, Point Cadet Harbor, Biloxi<br>USGS-302318088512600"],{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]},{"method":"addLegend","args":[{"colors":["#808080 , #FFFFD9 12.5%, #99D6B9 37.5%, #2280B8 62.5%, #081D58 87.5%, #808080 "],"labels":["5","15","25","35"],"na_color":null,"na_label":"NA","opacity":0.8,"position":"bottomright","type":"numeric","title":"Salinity<br>(ppt)","extra":{"p_1":0.125,"p_n":0.875},"layerId":null,"className":"info legend","group":null}]}],"limits":{"lat":[30.12277778,30.38833333],"lng":[-89.74055559999999,-88.8572222]}},"evals":[],"jsHooks":[]}
```
