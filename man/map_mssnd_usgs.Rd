% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/map_mssnd_usgs.R
\name{map_mssnd_usgs}
\alias{map_mssnd_usgs}
\title{Map USGS Stations in the Mississippi Sound}
\usage{
map_mssnd_usgs(stations, color_function = NULL)
}
\arguments{
\item{stations}{A data frame of station metadata, typically the `stnInfo` data frame
from the list generated by `get_mssnd_data()`. Must include columns `station_nm`,
`site_no`, `dec_lat_va`, and `dec_lon_va`.}

\item{color_function}{Optional. A function for mapping station names to colors,
such as one created by [leaflet::colorFactor()]. If not provided, a default
palette will be generated using the khroma package "roma" palette.}
}
\value{
A `leaflet` map widget displaying the station locations.
}
\description{
Creates an interactive map of USGS monitoring stations in the Mississippi Sound,
primarily in the state of Mississippi.
}
\details{
If the `stations` data frame does not include a `clean_nm` column, one
  will be generated using [clean_station_names()]. The map includes selectable
  tile layers (CartoDB Positron and Esri) and circle markers with popups displaying
  station names and USGS site numbers.
}
\examples{
map_mssnd_usgs(mssnd_salinity2019$siteInfo)
}
