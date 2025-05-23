% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/map_mssnd_salinity.R
\name{map_mssnd_salinity}
\alias{map_mssnd_salinity}
\title{Create interactive salinity map for Mississippi Sound data}
\usage{
map_mssnd_salinity(data, palette = "YlGnBu", domain = c(0, 40))
}
\arguments{
\item{data}{A data frame containing salinity data for a single date,
generally created by joining the $daily and $siteInfo components of
output from the get_mssnd_data() function, then filtered to a single date.
  Must include the following columns:
  \itemize{
    \item dec_lon_va: Decimal longitude of station
    \item dec_lat_va: Decimal latitude of station
    \item sal_mean: Daily mean salinity in parts per thousand (ppt)
    \item clean_nm: Station name
    \item site_no: USGS site number
  }}

\item{palette}{Character string specifying the color palette name (default: "YlGnBu")}

\item{domain}{Numeric vector of length 2 specifying the domain range (default: c(0, 40))}
}
\value{
A leaflet map object centered on the Mississippi Sound area (approximately
  30.25°N, 89.15°W) with station markers colored by salinity values.
}
\description{
Creates an interactive leaflet map displaying salinity data from USGS stations
in the Mississippi Sound area. This is a convenience function that combines
the create_mssnd_basemap, add_salinity_points, and add_salinity_legend functions
in a single call.
}
\note{
This function is currently specific to USGS station data format. The input
  should represent data from a single date.
}
\examples{
# Using the included mssnd_salinity example dataset
to_map <- dplyr::left_join(mssnd_salinity$daily, mssnd_salinity$siteInfo) |>
    dplyr::filter(date == as.Date("2023-06-01"))
map_mssnd_salinity(to_map)

# Same example dataset, but a date where only 2 stations have a daily average
to_map <- dplyr::left_join(mssnd_salinity$daily, mssnd_salinity$siteInfo) |>
    dplyr::filter(date == as.Date("2020-06-01"))
map_mssnd_salinity(to_map)

}
