#' Create a leaflet base map centered on Mississippi Sound
#'
#' Creates a leaflet base map with CartoDB Positron and Esri tiles
#' centered at a specified location (defaults to Mississippi Sound).
#'
#' @param lng Numeric longitude for map center (default: -89.15)
#' @param lat Numeric latitude for map center (default: 30.25)
#' @param zoom Integer zoom level (default: 9)
#'
#' @return A leaflet map object
#'
#' @import leaflet
#'
#' @examples
#' # Create a base map centered on Mississippi Sound
#' create_mssnd_basemap()
#'
#' # Create a base map centered on a different location
#' create_mssnd_basemap(lng = -88.9, lat = 30.3, zoom = 10)
#'
#' @export


create_mssnd_basemap <- function(lng = -89.15, lat = 30.25, zoom = 9) {
    leaflet::leaflet() %>%
        leaflet::setView(lng, lat, zoom = zoom) %>%
        leaflet::addProviderTiles(provider = leaflet::providers$CartoDB.Positron,
                                  group = "Positron (CartoDB)") %>%
        leaflet::addProviderTiles(provider = leaflet::providers$Esri,
                                  group = "Esri") %>%
        leaflet::addLayersControl(
            baseGroups = c("Positron (CartoDB)", "Esri")
        )
}
