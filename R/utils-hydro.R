##############################################################
# from Claude; remove once things are working and fixed

# New files:
#     - R/utils-hydro.R:
#     - .hydro is an internal list holding the USGS Hydro tile URL, group name, attribution, and the default basemaps for mapview and for tmap.
# - hydro_basemaps(type = c("mapview", "tmap")) returns the default basemaps for either package, and gives a clear error if type is misspelled.
# - Neither is exported, and the helper is marked @noRd, so NAMESPACE and man/ stay the same.
# - tests/testthat/test-utils-hydro.R: checks that the helper returns what it should and errors on a bad type. It also checks that every default basemap name is a real leaflet::providers entry, so a misspelled name fails the test instead of silently giving a blank basemap. Finally, it checks that the URL contains the {z}/{y}/{x} placeholders.
#
# Using it in the split functions once you've found them:
# - mapview: set map.types = hydro_basemaps("mapview") as the default argument, then call leaflet::addTiles(m@map, urlTemplate = .hydro$url, attribution = .hydro$attribution, group = .hydro$group).
# - tmap: tmap::tm_tiles(.hydro$url, group = .hydro$group), adding tmap::tm_basemap(hydro_basemaps("tmap")) if the user asks for basemaps.
# - Docs: in roxygen, `r paste(hydro_basemaps("mapview"), collapse = ", ")` puts the current defaults into the help page, so it can't go out of date.
#
# I didn't touch R/map_hydro.R or its tests; you can retire them when the split functions go in. I also didn't run devtools::document() or check(), and tmap still isn't installed on this computer.

##############################################################

# Settings shared by mapview_hydro() and tm_hydro()
.hydro <- list(
    url = "https://basemap.nationalmap.gov/arcgis/rest/services/USGSHydroCached/MapServer/tile/{z}/{y}/{x}",
    group = "USGS Hydrography",
    attribution = "USGS Hydrography",
    basemaps = list(
        mapview = c("Esri.OceanBasemap", "Esri.WorldGrayCanvas",
                    "Esri.WorldTopoMap", "OpenStreetMap"),
        tmap = c("Esri.WorldTopoMap", "Esri.WorldGrayCanvas",
                 "OpenStreetMap")
    )
)

#' Default basemaps for a hydro map
#'
#' @param type Character string, `"mapview"` or `"tmap"`.
#'
#' @return Character vector of leaflet provider names.
#'
#' @noRd
hydro_basemaps <- function(type = c("mapview", "tmap")) {
    type <- match.arg(type)
    .hydro$basemaps[[type]]
}
