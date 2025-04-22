#' Clean and Standardize Station Names
#'
#' This function cleans and standardizes station names by performing several transformations:
#'
#' @param name A character vector of station names to be cleaned.
#'
#' @return A character vector of cleaned station names with standardized formatting.
#'
#' @importFrom stringr str_remove_all str_trim str_remove str_replace_all str_squish
#'
#' @examples
#' stations <- c("Mississippi Sound near Grand Pass", "Rigolets at Hwy 90 near
#' Slidell, LA", "EAST PEARL RIVER AT CSX RAILROAD NR CLAIBORNE, MS",
#' "MISSISSIPPI SOUND AT USGS MERRILL SHELL BANK LIGHT", "MISSISSIPPI SOUND AT
#' USGS ROUND ISLAND LIGHT, MS", "BILOXI BAY AT POINT CADET HARBOR AT BILOXI, MS")
#' clean_station_names(stations)
#'
#' @export


clean_station_names <- function(name) {
    to_remove <- c("Mississippi Sound", "Usgs", "Ms", "La") |>
        paste(collapse = "|")

    name |>
        stringr::str_to_title() |>
        stringr::str_remove_all(to_remove) |>
        stringr::str_trim() |>
        stringr::str_remove_all(",") |>
        stringr::str_remove("^\\s*(Near|At)\\b\\s*") |>
        stringr::str_replace_all("\\b(Near|Nr|At)\\b", ",") |>
        stringr::str_replace_all("\\s*,\\s*", ", ") |>
        stringr::str_squish()
}
