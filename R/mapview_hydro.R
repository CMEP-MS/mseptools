#' Interactive mapview plot with USGS Hydrography overlay
#'
#' @description
#' Basemap options within common R spatial packages are not entirely satisfactory when
#' mapping along estuarine coastlines. USGS provides a Hydrography layer that is
#' very useful, but is not built into said packages. This function adds the USGS
#' Hydrography layer to a mapview object. This function can be used just like
#' `mapview::mapview()`.
#'
#' @param x Spatial object (e.g., `sf`, `SpatVector`).
#' @param map.types Character vector of basemaps. Defaults to `\r hydro_basemaps("mapview")`.
#' @param layer.name Character name for data layer. Defaults to "data".
#' @param ... Additional arguments passed to [mapview::mapview()].
#'
#' @return A `mapview` object containing the modified leaflet map.
#'
#' @examples
#' \dontrun{
#' library(mapview)
#' # make a map as you would otherwise with mapview
#' # styling is adjusted automatically
#' mapview_hydro(MDEQ_beach_stations,
#'               color = "purple",
#'               lwd = 2,
#'               col.regions = "orange",
#'               legend = NULL)
#' # give it a layer name
#' mapview_hydro(MDEQ_beach_stations,
#'               layer.name = "MDEQ Beach Stations",
#'               color = "purple",
#'               lwd = 2,
#'               col.regions = "orange")
#' }
#'
#' @export

mapview_hydro <- function(x, map.types = hydro_basemaps("mapview"), layer.name = "data", ...) {
    # deparse1 prevents multi-line expressions from returning vectors of length > 1
    # layer_name <- deparse1(substitute(x))

    # Generate base mapview object
    mv <- mapview::mapview(x, map.types = map.types, layer.name = layer.name, ...)

    # Inject USGS Hydro layer into the underlying leaflet slot and retain mapview object structure
    mv@map <- mv@map %>%
        leaflet::addTiles(
            urlTemplate = .hydro$url,
            attribution = .hydro$attribution,
            group       = .hydro$group
        ) %>%
        leaflet::addLayersControl(
            baseGroups    = map.types,
            overlayGroups = c(.hydro$group, layer.name),
            options       = leaflet::layersControlOptions(collapsed = TRUE)
        )

    mv
}
