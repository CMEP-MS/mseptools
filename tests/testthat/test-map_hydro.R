testthat::test_that("map_hydro errors on unsupported class when type = 'auto'", {
  testthat::expect_error(
    map_hydro(list(a = 1)),
    "must be a 'mapview' or 'tmap' object"
  )
})

testthat::test_that("map_hydro works on a mapview object and returns a leaflet map", {
  testthat::skip_if_not_installed("mapview")
  testthat::skip_if_not_installed("leaflet")

  m <- mapview::mapview(mapview::breweries)
  result <- map_hydro(m)

  testthat::expect_s3_class(result, "leaflet")

  # USGS Hydrography layer should be present in the leaflet call tree
  layer_groups <- unlist(lapply(result$x$calls, function(call) call$args[[3]]$group))
  testthat::expect_true("USGS Hydrography" %in% layer_groups)
})

testthat::test_that("map_hydro respects explicit base_groups override", {
  testthat::skip_if_not_installed("mapview")
  testthat::skip_if_not_installed("leaflet")

  m <- mapview::mapview(mapview::breweries)
  result <- map_hydro(m, base_groups = c("MyCustomBase"))

  layers_control_call <- result$x$calls[[length(result$x$calls)]]
  testthat::expect_equal(layers_control_call$args[[1]]$baseGroups, "MyCustomBase")
})

testthat::test_that("map_hydro derives overlay_name from the variable name by default", {
  testthat::skip_if_not_installed("mapview")
  testthat::skip_if_not_installed("leaflet")

  my_special_map <- mapview::mapview(mapview::breweries)
  result <- map_hydro(my_special_map)

  layers_control_call <- result$x$calls[[length(result$x$calls)]]
  testthat::expect_true("my_special_map" %in% layers_control_call$args[[1]]$overlayGroups)
})

testthat::test_that("map_hydro respects an explicit overlay_name", {
  testthat::skip_if_not_installed("mapview")
  testthat::skip_if_not_installed("leaflet")

  m <- mapview::mapview(mapview::breweries)
  result <- map_hydro(m, overlay_name = "Breweries Layer")

  layers_control_call <- result$x$calls[[length(result$x$calls)]]
  testthat::expect_true("Breweries Layer" %in% layers_control_call$args[[1]]$overlayGroups)
})

testthat::test_that("map_hydro works on a tmap object and returns a leaflet map", {
  testthat::skip_if_not_installed("tmap")
  testthat::skip_if_not_installed("leaflet")

  tm <- tmap::qtm(mapview::breweries)
  result <- map_hydro(tm)

  testthat::expect_s3_class(result, "leaflet")
})

# ---------------------------------------------------------------------------
# CANARY TESTS
#
# These do NOT test map_hydro()'s logic. They test an assumption map_hydro()
# is built on: the current factory-default basemap vectors for mapview and
# tmap. map_hydro() hardcodes what it believes those factory defaults are
# so it can detect "user hasn't customized this" and swap in nicer defaults.
# If the upstream package changes its factory default, that detection
# silently stops working -- no error, it just quietly stops swapping in your
# custom basemaps. These tests exist purely to fail loudly when that happens,
# so you don't have to remember to check manually.
#
# If a canary test below fails, don't "fix" the test to match the new
# default -- go update the *_defaults vectors inside map_hydro() itself,
# then update the canary to match.
# ---------------------------------------------------------------------------

testthat::test_that("CANARY: mapview's factory default basemaps haven't changed", {
  testthat::skip_if_not_installed("mapview")

  # Reset to the package's out-of-the-box state, uncontaminated by any
  # earlier mapviewOptions() calls in this R session.
  withr::local_options(list())
  old_opts <- mapview::mapviewGetOption("basemaps")
  on.exit(mapview::mapviewOptions(basemaps = old_opts), add = TRUE)

  # NOTE: there isn't a clean "restore to install-time factory defaults"
  # call in mapview, so this asserts against a *fresh session* value.
  # Run this test in a clean R session (e.g. via devtools::test(), which
  # starts a new process) for a reliable result -- if you've already called
  # mapviewOptions() earlier in an interactive session, this test will be
  # comparing against your customized state, not the real factory default.
  known_factory_default <- c("CartoDB.Positron", "CartoDB.DarkMatter",
                              "OpenStreetMap", "Esri.WorldImagery")

  testthat::expect_identical(
    mapview::mapviewGetOption("basemaps"),
    known_factory_default,
    info = paste(
      "mapview's factory default basemaps have changed.",
      "Update `factory_mapview_defaults` (and likely `custom_mapview_defaults`)",
      "inside map_hydro(), then update this canary to match the new default."
    )
  )
})

testthat::test_that("CANARY: tmap's factory default basemaps still match a known signature", {
  testthat::skip_if_not_installed("tmap")

  opts <- tmap::tmap_options()
  current_tmap_base <- if (!is.null(opts$basemap.server)) opts$basemap.server else opts$basemaps

  known_factory_signatures <- list(
    c("OpenStreetMap", "Esri.WorldImagery", "CartoDB.Positron"),
    c("OpenStreetMap", "Esri.WorldImagery", "CartoDB.Voyager"),
    c("Esri.WorldCanvas", "OpenStreetMap", "Esri.WorldImagery")
  )

  is_known_signature <- any(sapply(known_factory_signatures, function(sig) {
    identical(current_tmap_base, sig)
  }))

  testthat::expect_true(
    is_known_signature,
    info = paste(
      "tmap's default basemap/basemap.server value doesn't match any signature",
      "map_hydro() currently recognizes as a factory default:",
      paste(deparse(current_tmap_base), collapse = " "),
      "-- update `factory_tmap_defaults` inside map_hydro() to include this",
      "new signature, then update this canary to match."
    )
  )
})
