#' Get data from USGS stations
#'
#' This function is largely a wrapper function for `dataRetrieval::readNWISuv`, but focused on salinity
#' at the 8 USGS stations in the Mississippi portion of the Mississippi Sound.
#'
#' @param stations Character vector of USGS station IDs. Defaults to all 8 USGS stations located in the Mississippi portion of the Mississippi Sound.
#' @param params Character vector of USGS parameter codes. Defaults to `00480`, which corresponds to salinity.
#' @param startDate Date object or character string in `YYYY-MM-DD` format. Defaults to one month ago based on the system date.
#' @param endDate Date object or character string in `YYYY-MM-DD` format. Defaults to the current system date.
#' @param tz Character string indicating the desired time zone. The underlying USGS function retrieves data in UTC,
#'   and this wrapper defaults to `America/Regina` - local standard time (does not adjust for daylight saving time).
#'
#' @details
#' This function downloads high-frequency data via the USGS NWIS portal. It is specific to Mississippi Sound salinity data and does some processing as well.
#' The function downloads high-frequency water quality data (typically salinity) from the USGS National Water Information System
#' for selected monitoring stations in the Mississippi portion of the Mississippi Sound. The function returns raw data, site metadata, and (if salinity
#' data is present) daily summaries of minimum, mean, and maximum salinity values.
#'
#'
#' @return A named list with 2 or 3 components:
#' \describe{
#'   \item{`data`}{A data frame of raw unit-value (instantaneous) data from the USGS.}
#'   \item{`siteInfo`}{Metadata for the stations, extracted from the attributes of the returned data frame.}
#'   \item{`daily`}{(Optional) A data frame summarizing daily minimum, mean, and maximum salinity values for each site and date.
#'     This is only included if salinity data (`Sal`) is detected in the returned dataset.}
#' }
#'
#' @details
#' The function relies on several external packages:
#' \itemize{
#'   \item \pkg{dataRetrieval} for retrieving and renaming USGS data via `readNWISuv()` and `renameNWISColumns()`
#'   \item \pkg{stringr} for pattern matching and replacement in variable names via `str_replace()` and `str_detect()`
#'   \item \pkg{dplyr} for data manipulation, grouping, and summarizing
#'   \item \pkg{lubridate} for date arithmetic (e.g., `%m-% months(1)`)
#' }
#'
#' The default behavior focuses on salinity (parameter code 00480), but any other available parameters can be passed.
#'
#' @importFrom dataRetrieval readNWISuv renameNWISColumns
#' @importFrom stringr str_replace str_detect
#' @importFrom dplyr mutate summarize
#' @importFrom lubridate `%m-%`
#' @importFrom rlang .data
#'
#' @examples
#' \dontrun{
#' # Get salinity data for the past month at default stations
#' result <- get_mssnd_data()
#'
#' # Retrieve water temp data from two stations
# result_wtemp <- get_mssnd_data(
#     stations = c("301001089442600",
#                  "300722089150100"),
#     params = "00010"
# )
#'
#' # View daily summary if salinity was included
#' head(result$daily)
#' }
#'
#' @export


get_mssnd_data <- function(stations = c("301001089442600",
                                        "300722089150100",
                                        "301429089145600",
                                        "301912088583300",
                                        "301527088521500",
                                        "302318088512600",
                                        "301849088350000",
                                        "301141089320300"),
                           params = "00480",
                           startDate = Sys.Date() %m-% months(1),
                           endDate = Sys.Date(),
                           tz = "America/Regina"){

    dat_in <- dataRetrieval::readNWISuv(siteNumbers = stations,
                                        parameterCd = params,
                                        startDate = startDate,
                                        endDate = endDate,
                                        tz = tz)

    dat <-dataRetrieval::renameNWISColumns(dat_in) # gets most parameter names, but not salinity
    names(dat) <- stringr::str_replace(names(dat),
                                       "X_00480",
                                       "Sal")

    out <- list(data = dat,
                siteInfo = attributes(dat)$siteInfo)

    # get daily summaries, if using for salinity
    if(sum(stringr::str_detect(names(dat), "Sal")) >= 1){
        daily <- dat |>
            dplyr::mutate(date = as.Date(.data$dateTime)) |>
            dplyr::summarize(.by = c(.data$site_no, date),
                             sal_mean = mean(.data$Sal_Inst, na.rm = TRUE),
                             sal_min = min(.data$Sal_Inst, na.rm = TRUE),
                             sal_max = max(.data$Sal_Inst, na.rm = TRUE))
        out$daily <- daily
    }

    out

}
