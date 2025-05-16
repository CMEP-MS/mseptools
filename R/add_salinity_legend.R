#' Add a salinity legend to a leaflet map
#'
#' Adds a legend for salinity values to the bottom right of a leaflet map.
#'
#' @param map A leaflet map object
#' @param palette Character string specifying the color palette name (default: "YlGnBu")
#' @param domain Numeric vector of length 2 specifying the domain range for colors (default: c(0, 40))
#' @param color_function Optional pre-created color function (overrides palette and domain if provided)
#' @param position Character string specifying the position of the legend (default: "bottomright")
#' @param opacity Numeric opacity of the legend (default: 0.8)
#'
#' @return A leaflet map object with added legend
#'
#' @import leaflet
#'
#' @examples
#' # generate salinity data to map
#' to_map <- dplyr::left_join(mssnd_salinity$daily, mssnd_salinity$siteInfo) |>
#'     dplyr::filter(date == as.Date("2023-06-01"))
#'
#' # create base map
#' my_map <- create_mssnd_basemap()
#'
#' # Add points, using default color palette
#' my_map  |>
#'     add_salinity_points(to_map)
#'
#' # Add points and legend, using default color palette
#' my_map  |>
#'     add_salinity_points(to_map) |>
#'     add_salinity_legend()
#'
#' # Add points and legend, using non-default existing palette
#' my_map  |>
#'     add_salinity_points(to_map, palette = "Spectral") |>
#'     add_salinity_legend(palette = "Spectral")
#'
#' # Add points and legend, using custom domain
#' my_map  |>
#'     add_salinity_points(to_map, domain = c(5, 35)) |>
#'     add_salinity_legend(domain = c(5, 35))
#'
#' @export



add_salinity_legend <- function(map, palette = "YlGnBu", domain = c(0, 40),
                                color_function = NULL, position = "bottomright", opacity = 0.8) {
    # Use provided color function or create one from parameters
    if (is.null(color_function)) {
        color_function <- leaflet::colorNumeric(palette = palette, domain = domain)
    }

    map %>%
        leaflet::addLegend(
            position = position,
            title = "Salinity<br>(ppt)",
            pal = color_function,
            values = c(0, 10, 20, 30, 40),
            bins = c(5, 15, 25, 35),
            opacity = opacity
        )
}
