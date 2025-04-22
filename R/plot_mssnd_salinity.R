#' Plot Mississippi Sound Salinity Data
#'
#' @description
#' Creates a plotly visualization of salinity data from USGS monitoring stations in the
#' Mississippi portion of the Mississippi Sound. The plot is stacked by default, with
#' instantaneous values in the top graph and daily means on the bottom. A range slider
#' is on the bottom to allow viewing of a smaller portion of time.
#'
#'
#' @param data A list with three required elements:
#'   \code{data} (instantaneous measurements), \code{daily} (daily averages), and \code{siteInfo}
#'   (station metadata). This is typically the output from the \code{get_mssnd_data()} function.
#' @param nrow Integer. Number of rows in the subplot layout. Default is 2 (instantaneous data on top,
#'   daily means on bottom). Change to 1 if you prefer the graphs side-by-side.
#' @param colors Character vector of color codes to use for different stations. Can be a named vector.
#'  If NULL (default), the khroma package's "roma" scheme will be used.
#'
#' @return A plotly object with interactive time series plots of salinity data. The top plot shows
#'   instantaneous measurements, and the bottom plot shows daily means. Both plots share x and y axes.
#'   A date range slider is included for easier navigation of the time series.
#'
#'
#' @importFrom dplyr left_join
#' @importFrom plotly plot_ly subplot layout
#' @importFrom khroma color
#'
#' @examples
#' \dontrun{
#' # Get Mississippi Sound data
#' ms_data <- get_mssnd_data()
#'
#' # Create default plot
#'
#'
#' Use custom colors -
#' create a palette and subset to the number of stations in the data
#' custom_palette <- c("#1f77b4", "#ff7f0e", "#2ca02c", "#d62728",
#'                    "#9467bd", "#8c564b", "#e377c2", "#7f7f7f",
#'                    "#bcbd22", "#17becf")
#' n_stations <- length(unique(ms_data$data$site_no))
#' station_colors <- custom_palette[1:min(n_stations, length(custom_palette))]
#'
#' # Use the subset palette for plotting
#' plot_mssnd_salinity(ms_data, colors = station_colors)
#'
#'
#' # Change layout to single row
#' plot_mssnd_salinity(ms_data, nrow = 1)
#' }
#'
#' @export


plot_mssnd_salinity <- function(data,
                                nrow = 2,
                                colors = NULL){
    # data is a list output from the get_mssnd_data() function
    # it must have all three sections: data, daily, and stnInfo

    dat <- data

    if(!exists("clean_nm", dat$siteInfo)){
        dat$siteInfo$clean_nm <- clean_station_names(dat$siteInfo$station_nm)
    }

    to_plo <- dplyr::left_join(dat$data, dat$siteInfo,
                               by = "site_no")
    to_ploDaily <- dplyr::left_join(dat$daily, dat$siteInfo,
                                    by = "site_no")

    if(is.null(colors)){
        colors <- as.character(khroma::color("roma")(length(unique(to_plo$station_nm))))
    }


    p <- plotly::plot_ly(to_plo,
                         type = "scatter",
                         mode = "lines",
                         x = ~dateTime,
                         y = ~Sal_Inst,
                         color = ~clean_nm,
                         colors = colors,
                         legendgroup = ~clean_nm,
                         showlegend = TRUE)

    p2 <- plotly::plot_ly(to_ploDaily,
                          type = "scatter",
                          mode = "lines",
                          x = ~date,
                          y = ~sal_mean,
                          color = ~clean_nm,
                          colors = colors,
                          legendgroup = ~clean_nm,
                          showlegend = FALSE)

    plotly::subplot(p, p2, nrows = nrow,
                    shareX = TRUE, shareY = TRUE,
                    margin = 0.03)|>
        plotly::layout(
            xaxis = list(
                title = list(
                    text = "Date<span style='font-size:smaller'> (adjust visible range with slider)</span>",
                    font = list(size = 14)
                ),
                rangeslider = list(
                    type = "date",
                    thickness = 0.04
                ),
                zerolinecolor = '#ffff',
                zerolinewidth = 1
            ),
            yaxis = list(
                title = "Salinity (ppt)"
            ),
            yaxis2 = list(
                title = ""
            ),
            annotations = list(
                # Title for the top plot (instantaneous values)
                list(
                    x = 0,
                    y = 1.0,
                    text = "Instantaneous",
                    xref = "paper",
                    yref = "paper",
                    xanchor = "left",
                    yanchor = "bottom",
                    showarrow = FALSE,
                    font = list(size = 16)
                ),
                # Title for the bottom plot (daily mean)
                list(
                    x = 0,
                    y = 0.47,  # This positions it at the top of the second plot
                    text = "Daily Mean",
                    xref = "paper",
                    yref = "paper",
                    xanchor = "left",
                    yanchor = "bottom",
                    showarrow = FALSE,
                    font = list(size = 16)
                )
            ))
}

