#' Create interactive salinity map for Mississippi Sound data
#'
#' @description
#' Creates an interactive leaflet map displaying salinity data from USGS stations
#' in the Mississippi Sound area. The function visualizes salinity measurements using
#' color-coded markers, with popups showing the salinity value, station name, and ID.
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
# to_map <- dplyr::left_join(mssnd_salinity$daily, mssnd_salinity$siteInfo) |>
#     dplyr::filter(date == as.Date("2023-06-01"))
# map_mssnd_salinity(to_map)
#'
#' # Same example dataset, but a date where only 2 stations have a daily average
#' to_map <- dplyr::left_join(mssnd_salinity$daily, mssnd_salinity$siteInfo) |>
#'     dplyr::filter(date == as.Date("2020-06-01"))
#' map_mssnd_salinity(to_map)
#'
#' @export


map_mssnd_salinity <- function(data){
    # this function is specifically for data from USGS stations at this point
    # it needs to be a data frame of a single date

    color_function <- leaflet::colorNumeric(palette = "YlGnBu",
                                            domain = c(0, 40))

    m <- leaflet::leaflet(data) |>
        setView(-89.1500, 30.2500, zoom = 9) |>
        leaflet::addProviderTiles(provider = leaflet::providers$CartoDB.Positron,
                                  group = "Positron (CartoDB)") |>
        leaflet::addProviderTiles(provider = leaflet::providers$Esri,
                                  group = "Esri") |>
        leaflet::addLayersControl(baseGroups = c("Positron (CartoDB)",
                                                 "Esri")) |>
        leaflet::addCircleMarkers(lng = ~dec_lon_va,
                                  lat = ~dec_lat_va,
                                  fillColor = ~color_function(sal_mean),
                                  color = "black",
                                  weight = 0.7,
                                  radius = 11,
                                  fillOpacity = 1,
                                  popup = ~paste0(round(sal_mean, 1), " ppt<br>",
                                                  clean_nm, "<br>USGS-",
                                                  site_no)) |>
        leaflet::addLegend(position = "bottomright",
                           title = "Salinity<br>(ppt)",
                           pal = color_function,
                           values = c(0, 10, 20, 30, 40),
                           bins = c(5, 15, 25, 35),
                           opacity = 0.8)
    m
}
