#' Create interactive salinity map for Mississippi Sound data
#'
#' @description
#' Creates an interactive leaflet map displaying salinity data from USGS stations
#' in the Mississippi Sound area. This is a convenience function that combines
#' the create_mssnd_basemap, add_salinity_points, and add_salinity_legend functions
#' in a single call.
#'
#' @param data A data frame containing salinity data for a single date,
#' generally created by joining the $daily and $siteInfo components of
#' output from the get_mssnd_data() function, then filtered to a single date.
#'   Must include the following columns:
#'   \itemize{
#'     \item dec_lon_va: Decimal longitude of station
#'     \item dec_lat_va: Decimal latitude of station
#'     \item sal_mean: Daily mean salinity in parts per thousand (ppt)
#'     \item clean_nm: Station name
#'     \item site_no: USGS site number
#'   }
#' @param palette Character string specifying the color palette name (default: "YlGnBu")
#' @param domain Numeric vector of length 2 specifying the domain range (default: c(0, 40))
#'
#' @return A leaflet map object centered on the Mississippi Sound area (approximately
#'   30.25°N, 89.15°W) with station markers colored by salinity values.
#'
#' @note This function is currently specific to USGS station data format. The input
#'   should represent data from a single date.
#'
#' @import leaflet
#'
#' @examples
#' # Using the included mssnd_salinity example dataset
#' to_map <- dplyr::left_join(mssnd_salinity$daily, mssnd_salinity$siteInfo) |>
#'     dplyr::filter(date == as.Date("2023-06-01"))
#' map_mssnd_salinity(to_map)
#'
#' # Same example dataset, but a date where only 2 stations have a daily average
#' to_map <- dplyr::left_join(mssnd_salinity$daily, mssnd_salinity$siteInfo) |>
#'     dplyr::filter(date == as.Date("2020-06-01"))
#' map_mssnd_salinity(to_map)
#'
#' @export


map_mssnd_salinity <- function(data, palette = "YlGnBu", domain = c(0, 40)) {
    # Create a shared color function for consistency between points and legend
    color_function <- leaflet::colorNumeric(palette = palette, domain = domain)

    map <- create_mssnd_basemap() %>%
        add_salinity_points(data, color_function = color_function) %>%
        add_salinity_legend(color_function = color_function)

    return(map)
}
