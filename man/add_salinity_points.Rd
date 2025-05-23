% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_salinity_points.R
\name{add_salinity_points}
\alias{add_salinity_points}
\title{Add salinity data points to a leaflet map}
\usage{
add_salinity_points(
  map,
  data,
  palette = "YlGnBu",
  domain = c(0, 40),
  color_function = NULL
)
}
\arguments{
\item{map}{A leaflet map object}

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

\item{domain}{Numeric vector of length 2 specifying the domain range for colors (default: c(0, 40))}

\item{color_function}{Optional pre-created color function (overrides palette and domain if provided)}
}
\value{
A leaflet map object with added circle markers
}
\description{
Adds circle markers to a leaflet map representing salinity measurements,
with popups showing the salinity value and site information.
}
\examples{

# generate salinity data to map
to_map <- dplyr::left_join(mssnd_salinity$daily, mssnd_salinity$siteInfo) |>
    dplyr::filter(date == as.Date("2023-06-01"))

# create base map
my_map <- create_mssnd_basemap()

# Add points, using default color palette
my_map  |>
    add_salinity_points(to_map)

# Add points and legend, using default color palette
my_map  |>
    add_salinity_points(to_map) |>
    add_salinity_legend()

# Add points and legend, using non-default existing palette
my_map  |>
    add_salinity_points(to_map, palette = "Spectral") |>
    add_salinity_legend(palette = "Spectral")

# Add points and legend, using custom domain
my_map  |>
    add_salinity_points(to_map, domain = c(5, 35)) |>
    add_salinity_legend(domain = c(5, 35))

}
