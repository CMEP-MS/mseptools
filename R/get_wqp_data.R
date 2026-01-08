#' Retrieve Water Quality Portal (WQP) data for predefined Mississippi areas
#'
#' A wrapper around \code{dataRetrieval::readWQPdata()} that simplifies
#' data retrieval for commonly used Mississippi Sound Estuary Program watershed, basin, and
#' coastal-county groupings. The function handles multi-county queries
#' internally and binds results into a single data frame.
#'
#' @param area Character string specifying the spatial area to query.
#'   Must be one of:
#'   \describe{
#'     \item{\code{"watershedComplete"}}{complete Mississippi Sound Watershed, HUCs 0317 and 0318. May return data from Alabama and Louisiana as well as Mississippi.}
#'     \item{\code{"3coastalCounties"}}{Jackson, Harrison, and Hancock counties (MS)}
#'     \item{\code{"6coastalCounties"}}{Jackson, Harrison, Hancock, George,
#'       Stone, and Pearl River counties (MS)}
#'     \item{\code{"basinCoastalStreams"}}{MDEQ's Coastal Streams Basin: HUC 03170009}
#'   }
#'
#' @param sampleMedia Character string passed to
#'   \code{dataRetrieval::readWQPdata()} specifying the sample media
#'   (default is \code{"Water"}).
#'
#' @param service Character string specifying the WQP service to query
#'   (default is \code{"Result"}).
#'
#' @param dataProfile Character string specifying the WQP data profile
#'   (default is \code{"resultPhysChem"}, as this format includes method detection limit information).
#'
#' @param ... Additional arguments passed directly to
#'   \code{dataRetrieval::readWQPdata()}, such as \code{startDateLo},
#'   \code{startDateHi}, \code{characteristicName}, \code{characteristicType}
#'   (anything you would put in 'Characteristic Group' in the WQP Advanced Query page to narrow down data types -
#'   some desirable ones are \code{"Physical"}, \code{"Nutrients"}, \code{"Biological, Algae, Phytoplankton"},
#'   \code{"Inorganic, Major, Metals"}, \code{"Inorganic, Minor, Metals"},
#'   or \code{siteType}.
#'
#' @returns A data frame containing WQP results for the requested area. Empty columns are removed.
#'
#' @details
#' For county-based areas (\code{"3coastalCounties"} and
#' \code{"6coastalCounties"}), the function queries each county separately
#' and then combines the results.
#'
#' This function preserves Water Quality Portal (WQP) metadata stored as
#' attributes on the returned data frame, even when empty columns are
#' removed during post-processing. As a result, the output can be passed
#' directly to \code{dataRetrieval::create_WQP_bib()} to generate an
#' appropriate data citation for the WQP query.
#'
#' @seealso
#' \code{\link[mseptools]{retain_wqp_attributes}},
#' \code{\link[dataRetrieval]{create_WQP_bib}},
#' \code{\link[dataRetrieval]{readWQPdata}}
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Retrieve data for MDEQ's Coastal Streams Basin for 2020
#' dat1 <- get_wqp_data(
#'   area = "basinCoastalStreams",
#'   startDateLo = "2020-01-01",
#'   startDateHi = "2020-12-31"
#' )
#'
#' # Retrieve DO only data for the three coastal counties in 2020
#' dat2 <- get_wqp_data(
#'   area = "3coastalCounties",
#'   characteristicName = "Dissolved oxygen (DO)",
#'   startDateLo = "2020-01-01",
#'   startDateHi = "2020-12-31"
#' )
#'
#' # Retrieve Nutrient data for the six coastal counties in 2020
#' dat3 <- get_wqp_data(
#'     area = "6coastalCounties",
#'     characteristicType = "Nutrient",
#'     startDateLo = "2020-01-01",
#'     startDateHi = "2020-12-31"
#' )
#' }


get_wqp_data <- function(area = c("watershedComplete",
                                  "3coastalCounties",
                                  "6coastalCounties",
                                  "basinCoastalStreams"),
                         # "basinPascagoula",
                         # "basinPearl"),
                         sampleMedia = "Water",
                         service = "Result",
                         dataProfile = "resultPhysChem",
                         ...){

    area <- match.arg(area)
    # Collect user-supplied extra arguments
    dots <- list(...)

    if(area %in% c("3coastalCounties", "6coastalCounties")){

        cts <- switch(
            area,
            "3coastalCounties" = c("Jackson", "Harrison", "Hancock"),
            "6coastalCounties" = c("Jackson", "Harrison", "Hancock",
                                   "George", "Stone", "Pearl River")
        )
        # cts <- c("Jackson", "Harrison", "Hancock")

        tmp_out <- list()

        for(i in seq_along(cts)){
            area_args <- list(statecode = "MS",
                              countycode = cts[i])
            args <- c(
                list(
                    sampleMedia = sampleMedia,
                    service = service,
                    dataProfile = dataProfile
                ),
                area_args,
                dots
            )

            # Call the original function
            tmp_outdf <- do.call(dataRetrieval::readWQPdata, args)
            # remove empty columns
            tmp_outdf <- janitor::remove_empty(tmp_outdf, "cols")
            tmp_out[[i]] <- tmp_outdf

        }

        # bind together
        tmp <- dplyr::bind_rows(tmp_out)


    } else {
        # do it the already outined way
        area_args <- switch(
            area,
            watershedComplete = list(huc = "0317;0318"),
            basinCoastalStreams = list(huc = "03170009")
        )

        # Combine everything into one argument list
        args <- c(
            list(
                sampleMedia = sampleMedia,
                service = service,
                dataProfile = dataProfile
            ),
            area_args,
            dots
        )

        # Call the original function
        tmp <- do.call(dataRetrieval::readWQPdata, args)

        # remove empty columns
        tmp2 <- janitor::remove_empty(tmp, "cols")

        tmp <- retain_wqp_attributes(tmp, tmp2)
    }

    # return the data frame
    tmp
}

