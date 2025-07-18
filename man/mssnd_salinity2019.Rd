% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mssnd_salinity2019.R
\docType{data}
\name{mssnd_salinity2019}
\alias{mssnd_salinity2019}
\title{Mississippi Sound Salinity Data from 2019}
\format{
## `mssnd_salinity`
A list containing 3 data frames:
\describe{
  \item{data}{data frame of all salinity readings}
  \item{siteInfo}{data frame of station metadata, including lat/long coordinates
  and cleaned names. Cleaned names are a factor, ordered from west to east.}
  \item{daily}{data frame of min, max, and mean salinity per day by station.}
  ...
}
}
\usage{
mssnd_salinity2019
}
\description{
Salinity data from 8 Mississippi Sound USGS stations, subsetted from `mssnd_salinity`
to only include the year 2019. All available readings were downloaded through
the USGS NWIS API using `get_mssnd_salinity()`, a wrapper for
`dataRetrieval::readNWISuv`. Readings were also processed into daily min, mean,
and max. Station metadata is provided in `siteInfo`.
}
\keyword{datasets}
