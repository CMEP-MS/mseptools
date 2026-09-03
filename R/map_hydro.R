#' Overlay USGS Hydrography on Maps
#'
#' Adds the USGS Hydrography cached tile layer and updates the layer controls on
#' existing `mapview` or `tmap` interactive map objects.
#'
#' @param x An interactive map object of class `mapview` or `tmap`.
#' @param type Character string specifying the object type. Options are `"auto"`
#'   (default, automatically detects class), `"mapview"`, or `"tmap"`.
#' @param base_groups Character vector of basemap names to display in the layer control menu.
#'   If `NULL` (default), base groups are automatically inferred from object properties (given priority) or global options.
#'   If base groups have not been specified in either object properties or global options, defaults
#'   for `"mapview"` objects are: `c("Esri.OceanBasemap", "Esri.WorldGrayCanvas",  "Esri.WorldTopoMap", "OpenStreetMap")`;
#'   and for `"tmap"` objects are: `c("Esri.WorldTopoMap", "Esri.WorldGrayCanvas", "OpenStreetMap")`.
#' @param overlay_name Character string for the layer name in the controls. Defaults to the variable name passed to `x`.
#' @param ... Additional arguments passed to underlying mapping methods.
#'
#' @return A \code{\link[leaflet]{leaflet}} map object containing the added USGS Hydrography layer and modified layer controls.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' library(mapview)
#' m <- mapview(breweries)
#' map_hydro(m)
#' }
map_hydro <- function(x,
                      type = c("auto", "mapview", "tmap"),
                      base_groups = NULL,
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

    # --- CUSTOM DEFAULTS PER PACKAGE ---
    custom_mapview_defaults <- c("Esri.OceanBasemap", "Esri.WorldGrayCanvas",
                                 "Esri.WorldTopoMap", "OpenStreetMap")

    custom_tmap_defaults <- c("Esri.WorldTopoMap", "Esri.WorldGrayCanvas",
                              "OpenStreetMap")

    # --- FACTORY STARTUP SIGNATURES ---
    factory_mapview_defaults <- c("CartoDB.Positron", "CartoDB.DarkMatter",
                                  "OpenStreetMap", "Esri.WorldImagery")

    factory_tmap_defaults <- list(
        c("OpenStreetMap", "Esri.WorldImagery", "CartoDB.Positron"),
        c("OpenStreetMap", "Esri.WorldImagery", "CartoDB.Voyager"),
        c("Esri.WorldCanvas", "OpenStreetMap", "Esri.WorldImagery")
    )

    # 2. Extract base_groups dynamically if not explicitly supplied
    if (is.null(base_groups)) {

        # --- MAPVIEW LOGIC ---
        if (type == "mapview") {
            # Check object-level basemaps inside the mapview structure first
            mv_base <- tryCatch(x@object[[1]]@control$baseGroups, error = function(e) NULL)

            if (!is.null(mv_base) && length(mv_base) > 0) {
                base_groups <- mv_base
            } else {
                current_global <- mapview::mapviewGetOption("basemaps")

                # If sitting on factory default, swap to custom_mapview_defaults
                if (identical(current_global, factory_mapview_defaults)) {
                    base_groups <- custom_mapview_defaults
                } else {
                    base_groups <- current_global
                }
            }

            # --- TMAP LOGIC ---
        } else if (type == "tmap") {
            opts <- tmap::tmap_options()
            current_tmap_base <- if (!is.null(opts$basemap.server)) opts$basemap.server else opts$basemaps

            # Check if current_tmap_base matches any known factory default signatures
            is_tmap_factory_default <- any(sapply(factory_tmap_defaults, function(f_def) {
                identical(current_tmap_base, f_def)
            }))

            # If sitting on factory default, swap to custom_tmap_defaults
            if (is.null(current_tmap_base) || is_tmap_factory_default) {
                base_groups <- custom_tmap_defaults
            } else {
                base_groups <- current_tmap_base
            }
        }
    }

    # 3. Determine layer name to display in control menu
    if (is.null(overlay_name)) {
        overlay_name <- deparse(substitute(x))
    }

    # 4. Extract underlying Leaflet map
    if (type == "mapview") {
        lf_map <- x@map
    } else if (type == "tmap") {
        tmap::tmap_mode("view")
        lf_map <- tmap::tmap_leaflet(x)
    }

    # 5. Inject USGS Hydro layer and dynamic layer controls
    lf_map |>
        leaflet::addTiles(
            urlTemplate = "https://basemap.nationalmap.gov/arcgis/rest/services/USGSHydroCached/MapServer/tile/{z}/{y}/{x}",
            attribution = "USGS Hydrography",
            group = "USGS Hydrography"
        ) |>
        leaflet::addLayersControl(
            baseGroups = base_groups,
            overlayGroups = c("USGS Hydrography", overlay_name),
            options = leaflet::layersControlOptions(collapsed = TRUE)
        )
}
