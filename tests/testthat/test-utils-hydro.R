test_that("hydro_basemaps returns non-empty character vectors", {
    expect_type(hydro_basemaps("mapview"), "character")
    expect_type(hydro_basemaps("tmap"), "character")
    expect_gt(length(hydro_basemaps("mapview")), 0)
    expect_gt(length(hydro_basemaps("tmap")), 0)
})

test_that("hydro_basemaps defaults to mapview", {
    expect_identical(hydro_basemaps(), hydro_basemaps("mapview"))
})

test_that("hydro_basemaps errors on an unknown type", {
    expect_error(hydro_basemaps("ggplot"))
})

test_that("default basemaps are valid leaflet providers", {
    all_basemaps <- unique(unlist(.hydro$basemaps))
    expect_true(all(all_basemaps %in% names(leaflet::providers)),
                info = paste(setdiff(all_basemaps, names(leaflet::providers)),
                             collapse = ", "))
})

test_that("hydro tile URL has z/y/x placeholders", {
    expect_match(.hydro$url, "{z}", fixed = TRUE)
    expect_match(.hydro$url, "{y}", fixed = TRUE)
    expect_match(.hydro$url, "{x}", fixed = TRUE)
})
