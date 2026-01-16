test_that("basic plotlys of salinity work", {
    # shouldn't fail
    expect_no_condition(p <- plot_mssnd_salinity(mssnd_salinity2019))

    # should have plotly and html widget in its class
    expect_setequal(class(p), c("plotly", "htmlwidget"))

    # make sure there are two plots
    expect_length(p$x$attrs, 2)

    # make sure they have the same colors
    expect_equal(p$x$attrs[[1]]$colors, p$x$attrs[[2]]$colors)

    # top one should be instantaneous salinity
    expect_equal(rlang::as_label(p$x$attrs[[1]]$y), "~Sal_Inst")

    # second one should be mean salinity
    expect_equal(rlang::as_label(p$x$attrs[[2]]$y), "~sal_mean")
})
