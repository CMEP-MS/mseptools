#' Restore WQP attributes after column removal
#'
#' This function restores attributes that are lost when empty columns are
#' removed from a Water Quality Portal (WQP) data download. It is intended
#' to be used after applying \code{janitor::remove_empty("cols")} (or similar)
#' to a WQP data frame, which drops important metadata stored as attributes
#' (e.g., site information, characteristic metadata, and request URLs).
#'
#' The function copies attributes from the original full data frame and
#' re-attaches any attributes that are missing from the reduced data frame,
#' returning a data frame with fewer columns but the original WQP metadata
#' intact.
#'
#' @param data_full A data frame returned directly from the Water Quality
#'   Portal (WQP) download function \code{dataRetrieval::readWQPdata()},
#'   containing the full set of WQP attributes.
#' @param data_reduced A data frame derived from \code{data_full} with empty
#'   columns removed (e.g., via \code{janitor::remove_empty("cols")}), which
#'   has lost some or all of the original attributes.
#'
#' @return A data frame with the same columns as \code{data_reduced} and the
#'   attributes from \code{data_full} restored where missing. The returned
#'   object preserves WQP metadata such as site information, variable
#'   descriptions, and request details.
#'
#' @seealso
#' \code{\link[janitor]{remove_empty}},
#' \code{\link[mseptools]{get_wqp_data}}
#'
#' @examples
#' \dontrun{
#' full <- get_wqp_data(...)
#' reduced <- janitor::remove_empty(full, "cols")
#' restored <- retain_wqp_attributes(full, reduced)
#' }
#'
#' @export



retain_wqp_attributes <- function(data_full, data_reduced){
    # data_full is the download from WQP
    # data_reduced is data_full |> janitor::remove_empty("cols"),
    # which removes the attributes
    # but we want those attributes!
    # this function grabs them and attaches them to data_reduced
    # to return a data frame with fewer columns, but otherwise
    # the same attributes (site info, variable info, url, etc.)

    x <- data_full
    y <- data_reduced

    attr_x <- attributes(x)
    attr_y <- attributes(y)

    keep <- setdiff(names(attr_x), names(attr_y))
    attr_to_move <- attr_y[keep]

    attributes(data_full) <- c(attr_x, attr_to_move)
    return(data_full)

}
