# Create a leaflet base map centered on Mississippi Sound

Creates a leaflet base map with CartoDB Positron and Esri tiles centered
at a specified location (defaults to Mississippi Sound).

## Usage

``` r
create_mssnd_basemap(lng = -89.15, lat = 30.25, zoom = 9)
```

## Arguments

- lng:

  Numeric longitude for map center (default: -89.15)

- lat:

  Numeric latitude for map center (default: 30.25)

- zoom:

  Integer zoom level (default: 9)

## Value

A leaflet map object

## Examples

``` r
# Create a base map centered on Mississippi Sound
create_mssnd_basemap()

{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"setView":[[30.25,-89.15000000000001],9,[]],"calls":[{"method":"addProviderTiles","args":["Esri.WorldGrayCanvas",null,"Esri World Gray Canvas",{"errorTileUrl":"","noWrap":false,"detectRetina":false}]},{"method":"addTiles","args":["https://basemap.nationalmap.gov/arcgis/rest/services/USGSHydroCached/MapServer/tile/{z}/{y}/{x}",null,"USGS Hydrography",{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"USGS Hydrography"}]},{"method":"addLayersControl","args":["Esri World Gray Canvas","USGS Hydrography",{"collapsed":true,"autoZIndex":true,"position":"topright"}]}]},"evals":[],"jsHooks":[]}
# Create a base map centered on a different location
create_mssnd_basemap(lng = -88.9, lat = 30.3, zoom = 10)

{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"setView":[[30.3,-88.90000000000001],10,[]],"calls":[{"method":"addProviderTiles","args":["Esri.WorldGrayCanvas",null,"Esri World Gray Canvas",{"errorTileUrl":"","noWrap":false,"detectRetina":false}]},{"method":"addTiles","args":["https://basemap.nationalmap.gov/arcgis/rest/services/USGSHydroCached/MapServer/tile/{z}/{y}/{x}",null,"USGS Hydrography",{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"USGS Hydrography"}]},{"method":"addLayersControl","args":["Esri World Gray Canvas","USGS Hydrography",{"collapsed":true,"autoZIndex":true,"position":"topright"}]}]},"evals":[],"jsHooks":[]}
```
