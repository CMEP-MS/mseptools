#' Overlay Rivers/Streams from USGS Hydrography onto Maps
#'
#' Adds the USGS Hydrography cached tile layer and updates the layer controls on
#' existing `mapview` or `tmap` interactive map objects.
#'
#' @param x An interactive map object of class `mapview` or `tmap`.
#' @param type Character string specifying the object type. Options are `"auto"`
#'   (default, automatically detects class), `"mapview"`, or `"tmap"`.
#' @param base_groups Controls which basemaps appear in the layer control menu.
#'   One of:
#'   \itemize{
#'     \item `"default"` (default) — applies built-in package default basemaps.
#'     \item `"inherit"` — preserves existing basemaps and layer controls on `x`,
#'       simply overlaying the USGS Hydrography tile layer onto the map as constructed.
#'     \item A character vector — used verbatim as base group names in the layer control.
#'   }
#' @param overlay_name Character string for the layer name in the controls. Defaults to the variable name passed to `x`.
#' @param ... Additional arguments passed to underlying mapping methods.
#'
#' @return A \code{\link[leaflet]{leaflet}} map object containing the added USGS Hydrography layer.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' library(mapview)
#' m <- mapview(MDEQ_beach_stations)
#' map_hydro(m)
#' map_hydro(m, base_groups = "inherit")
#' map_hydro(m, base_groups = c("CartoDB.Positron", "OpenStreetMap"))
#' }
#'
#'
#'
#'
#'
#' NOT APPLYING BASE GROUPS CORRECTLY IN MAPVIEW - names show up
#' but it's still Positron under everything
#'
#'
#'
#'
#'
#'
#'
#'
map_hydro <- function(x,
                      type = c("auto", "mapview", "tmap"),
                      base_groups = "default",
                      overlay_name = NULL,
                      ...) {

    type <- match.arg(type)

    # 1. Auto-detect object class
    if (type == "auto") {
        if (inherits(x, "mapview")) {
            type <- "mapview"
        } else if (inherits(x, "tmap")) {
            type <- "tmap"
        } else {
            stop("Input 'x' must be a 'mapview' or 'tmap' object when type = 'auto'.")
        }
    }

    # --- PACKAGE DEFAULTS ---
    custom_mapview_defaults <- c("Esri.OceanBasemap", "Esri.WorldGrayCanvas",
                                 "Esri.WorldTopoMap", "OpenStreetMap")

    custom_tmap_defaults <- c("Esri.WorldTopoMap", "Esri.WorldGrayCanvas",
                              "OpenStreetMap")

    # Validate single string options
    if (length(base_groups) == 1 && base_groups %in% c("default", "inherit")) {
        if (base_groups == "default") {
            base_groups <- if (type == "mapview") custom_mapview_defaults else custom_tmap_defaults
        }
        # If "inherit", base_groups remains "inherit" to trigger bypass below
    }

    # 2. Determine layer name to display in control menu
    if (is.null(overlay_name)) {
        overlay_name <- deparse(substitute(x))
    }

    # 3. Extract underlying Leaflet map
    if (type == "mapview") {
        lf_map <- x@map
    } else if (type == "tmap") {
        tmap::tmap_mode("view")
        lf_map <- tmap::tmap_leaflet(x)
    }

    # 4. Inject USGS Hydro layer
    lf_map <- leaflet::addTiles(
        lf_map,
        urlTemplate = "https://basemap.nationalmap.gov/arcgis/rest/services/USGSHydroCached/MapServer/tile/{z}/{y}/{x}",
        attribution = "USGS Hydrography",
        group = "USGS Hydrography"
    )

    # 5. Apply or skip layer controls update
    if (identical(base_groups, "inherit")) {
        # Return map as constructed without modifying existing base/overlay controls
        return(lf_map)
    } else {
        # Apply custom or default baseGroups
        return(
            leaflet::addLayersControl(
                lf_map,
                baseGroups = base_groups,
                overlayGroups = c("USGS Hydrography", overlay_name),
                options = leaflet::layersControlOptions(collapsed = TRUE)
            )
        )
    }
}
