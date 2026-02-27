# Package index

## Get Data

Functions for retrieving data for the MSEP area from USGS and EPA
servers

- [`get_mssnd_data()`](https://cmep-ms.github.io/mseptools/reference/get_mssnd_data.md)
  : Get data from USGS stations
- [`get_wqp_data()`](https://cmep-ms.github.io/mseptools/reference/get_wqp_data.md)
  : Retrieve Water Quality Portal (WQP) data for predefined Mississippi
  areas

## Mapping

Functions to map stations and data in the MSEP area

- [`map_mssnd_salinity()`](https://cmep-ms.github.io/mseptools/reference/map_mssnd_salinity.md)
  : Create interactive salinity map for Mississippi Sound data
- [`map_mssnd_usgs()`](https://cmep-ms.github.io/mseptools/reference/map_mssnd_usgs.md)
  : Map USGS Stations in the Mississippi Sound

## Graphing

Functions to graph data in the MSEP area

- [`plot_mssnd_salinity()`](https://cmep-ms.github.io/mseptools/reference/plot_mssnd_salinity.md)
  : Plot Mississippi Sound Salinity Data

## Internal Datasets

Compiled data in the MSEP area

- [`mssnd_salinity`](https://cmep-ms.github.io/mseptools/reference/mssnd_salinity.md)
  : Mississippi Sound Salinity Data from 2010-2024
- [`mssnd_salinity2019`](https://cmep-ms.github.io/mseptools/reference/mssnd_salinity2019.md)
  : Mississippi Sound Salinity Data from 2019
- [`msep_boundary`](https://cmep-ms.github.io/mseptools/reference/msep_boundary.md)
  : Mississippi Sound Watershed Boundary

## Helper functions

Functions used by other functions

- [`create_mssnd_basemap()`](https://cmep-ms.github.io/mseptools/reference/create_mssnd_basemap.md)
  : Create a leaflet base map centered on Mississippi Sound
- [`add_salinity_legend()`](https://cmep-ms.github.io/mseptools/reference/add_salinity_legend.md)
  : Add a salinity legend to a leaflet map
- [`add_salinity_points()`](https://cmep-ms.github.io/mseptools/reference/add_salinity_points.md)
  : Add salinity data points to a leaflet map
- [`clean_station_names()`](https://cmep-ms.github.io/mseptools/reference/clean_station_names.md)
  : Clean and Standardize Station Names
- [`retain_wqp_attributes()`](https://cmep-ms.github.io/mseptools/reference/retain_wqp_attributes.md)
  : Restore WQP attributes after column removal
