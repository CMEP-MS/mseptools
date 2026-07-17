#' MDEQ Beach Stations
#'
#' Station information for MDEQ's recreational beach sampling program
#'
#' The Mississippi Department of Environmental Quality (MDEQ) regularly samples
#' 21 stations across the MS coast for Enterococcus, a fecal indicator bacteria,
#' as well as various nutrients, chlorophyll *a*, and Total Suspended Solids.
#' Data is available through their [beach website](https://beaches.mdeq.ms.gov/)
#' and through the [Water Quality Portal](https://www.waterqualitydata.us/),
#' using Organization ID '21MSWQ_WQX' and Project ID 'BCHYY', where 'YY' is the
#' last two digits of the year of interest.
#'
#' @format
#' An `sf` object, using CRS NAD83 (EPSG:4269) with 21 features (rows) and 3
#' fields (columns), with point geometry for each.
#' \describe{
#'   \item{`DEQStationID`}{character, station ID matching that on DEQ's beach
#'   website. In WQX, this station is provided as part of the
#'   'MonitoringLocationDescriptionText' field.}
#'   \item{`WQXStationID`}{character, station ID matching that in the
#'   'MonitoringLocationIdentifier field from a Water Quality Portal download.}
#'   \item{`StationName`}{character, station name as converted to title case from
#'   all caps in the 'MonitoringLocationName' field of a Water Quality Portal
#'   download. This corresponds to the station names as given on the DEQ beach
#'   website, with some minor differences that do not affect station identification
#'   (e.g. 'Long Beach' here is 'Long Beach Beach' on the beach website).}
#'   \item{`geometry`}{POINT, degrees longitude and latitude, obtained from WQX.}
#' }
#' @source Combination of data download from a [query of stations in the BCH24 project](https://www.waterqualitydata.us/#organization=21MSWQ_WQX&project=BCH24&mimeType=csv&providers=NWIS&providers=STORET)
#' in the Water Quality Portal and cross-checking with stations on the [MDEQ beach website](https://beaches.mdeq.ms.gov/).
#'

"MDEQ_beach_stations"
