test_that("mapping USGS stations works", {
    # shouldn't fail
    expect_no_condition(m <- map_mssnd_usgs(mssnd_salinity2019$siteInfo))

    # should have leaflet and html widget in its class
    expect_setequal(class(m), c("leaflet", "htmlwidget"))

    # should be 8 points on the map
    expect_length(m$x$calls[[4]]$args[[1]], 8)  # this feels fragile but it's the vector of latitudes for the points

    # make sure there's a legend and the first 3 labels are correct
    expect_equal(m$x$calls[[5]]$method, "addLegend")
    labs_expected <- c("Rigolets, Hwy 90, Slidell",
                       "East Pearl River, Csx Railroad, Claiborne",
                       "Grand Pass")
    expect_equal(as.character(m$x$calls[[5]]$args[[1]]$labels[1:3]),
                 labs_expected)
})
