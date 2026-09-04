tmp <- get_wqp_data(area = "basinCoastalStreams",
                    startDateLo = "2021-01-01",
                    startDateHi = "2021-01-15")
names_atts <- names(attributes(tmp))

test_that("more than the normal 3 attributes are present", {
    expect_gt(length(names_atts), 3)
})


test_that("a citation can be properly generated", {
    # necessary attributes for citation are present
    # from the help file for create_WQP_bib, these are "queryTime" and "url"
    expect_contains(names_atts, c("queryTime", "url"))

    # making it doesn't throw any errors
    expect_no_condition(dataRetrieval::create_WQP_bib(tmp))
})
