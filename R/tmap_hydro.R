#' Add USGS Hydrography overlay to a tmap object
#'
#' @description
#' Basemap options within common R spatial packages are not entirely satisfactory when
#' mapping along estuarine coastlines. USGS provides a Hydrography layer that is
#' very useful, but is not built into said packages. This function adds the USGS
#' Hydrography layer to a tmap object that has already been created. In view mode,
#' the output is turned into an interactive leaflet object. In plot mode, it
#' remains a tmap object. This function works with vector objects but is currently untested on rasters.
#'
#' @param tm_obj A `tmap` object. **Note**, do not add a `tm_basemap` layer if using plot mode - it will error.
#' @param base_groups Character vector of basemaps, for use in "view" mode. Defaults to `c("Esri.WorldTopoMap", "Esri.WorldGrayCanvas", "OpenStreetMap")` via an internal function.
#'
#' @return A map object: in plot mode, a regular `tmap` object; in view mode,
#' a `leaflet` map object.
#'
#' @examples
#' \dontrun{
#' library(tmap)
#' # make a map as desired with tmap
#' tm <- tm_shape(MDEQ_beach_stations) +
#'     tm_symbols(fill = "blue")
#'
#' # add the tmap_hydro styling to the tmap object
#' # whatever mode tmap happens to be in
#' tmap_hydro(tm)
#'
#' # plot mode specifically
#' tmap_mode("plot")
#' tmap_hydro(tm)
#'
#' # view mode specifically
#' # this provides multiple base layers to choose from
#' # and you can turn off the USGS Hydro layer if you want to
#' tmap_mode("view")
#' tmap_hydro(tm)
#'
#' or pass your own vector of basemaps
#' tmap_hydro(tm,
#' base_groups = c("OpenStreetMap",
#'                 "Esri.WorldTopoMap"))
#' }
#'
#' @export

tmap_hydro <- function(tm_obj,
                       base_groups = "default") {

    # Detect current tmap mode ("plot" or "view")
    current_mode <- tmap::tmap_mode()

    if (current_mode == "plot") {
        # Dummy ?ext so maptiles can build cache filenames
        provider <- maptiles::create_provider(
            name     = "USGS_Hydro",
            url      = paste0(.hydro$url, "?ext=.png"),
            citation = .hydro$attribution
        )

        # find the bounding box(es) for the tm object
        # find every element that carries a shape, and combine their extents
        has_shp <- vapply(tm_obj, function(x) "shp" %in% names(x), logical(1))
        if (!any(has_shp)) {
            stop("Could not find a shape layer in `tm_obj`.", call. = FALSE)
        }

        boxes <- lapply(tm_obj[has_shp], function(x) {
            sf::st_as_sfc(sf::st_bbox(x$shp)) |> sf::st_transform(4326)
        })
        bbox <- sf::st_bbox(do.call(c, boxes))

        bg <- maptiles::get_tiles(
            bbox,
            provider = provider,
            crop = TRUE, project = FALSE
        )

        # Tiles on the bottom, original map on top
        tmap::tm_shape(bg) + tmap::tm_rgb() + tm_obj


    } else {
        # we're in view mode!

        # get the basemaps - use what the user defined, or use the defaults
        if (identical(base_groups, "default")) {
            base_groups <- hydro_basemaps("tmap")
        }

        # make sure the requested basemaps are actually on the map
        tm_obj <- tm_obj + tmap::tm_basemap(base_groups)

        # Convert tmap object to leaflet and inject USGS Hydro layer
        tmap::tmap_leaflet(tm_obj) %>%
            leaflet::addTiles(
                urlTemplate = .hydro$url,
                attribution = .hydro$attribution,
                group       = .hydro$group
            ) %>%
            leaflet::addLayersControl(
                baseGroups    = base_groups,
                overlayGroups = c(.hydro$group),
                options       = leaflet::layersControlOptions(collapsed = TRUE)
            )
    }
}
