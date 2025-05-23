% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_mssnd_salinity.R
\name{plot_mssnd_salinity}
\alias{plot_mssnd_salinity}
\title{Plot Mississippi Sound Salinity Data}
\usage{
plot_mssnd_salinity(data, nrow = 2, colors = NULL)
}
\arguments{
\item{data}{A list with three required elements:
\code{data} (instantaneous measurements), \code{daily} (daily averages), and \code{siteInfo}
(station metadata). This is typically the output from the \code{get_mssnd_data()} function.}

\item{nrow}{Integer. Number of rows in the subplot layout. Default is 2 (instantaneous data on top,
daily means on bottom). Change to 1 if you prefer the graphs side-by-side.}

\item{colors}{Character vector of color codes to use for different stations. Can be a named vector.
If NULL (default), the khroma package's "roma" scheme will be used.}
}
\value{
A plotly object with interactive time series plots of salinity data. The top plot shows
  instantaneous measurements, and the bottom plot shows daily means. Both plots share x and y axes.
  A date range slider is included for easier navigation of the time series.
}
\description{
Creates a plotly visualization of salinity data from USGS monitoring stations in the
Mississippi portion of the Mississippi Sound. The plot is stacked by default, with
instantaneous values in the top graph and daily means on the bottom. A range slider
is on the bottom to allow viewing of a smaller portion of time.
}
\examples{
plot_mssnd_salinity(mssnd_salinity2019)
\dontrun{
# Get Mississippi Sound data
ms_data <- get_mssnd_data()

# Create default plot


Use custom colors -
create a palette and subset to the number of stations in the data
custom_palette <- c("#1f77b4", "#ff7f0e", "#2ca02c", "#d62728",
                   "#9467bd", "#8c564b", "#e377c2", "#7f7f7f",
                   "#bcbd22", "#17becf")
n_stations <- length(unique(ms_data$data$site_no))
station_colors <- custom_palette[1:min(n_stations, length(custom_palette))]

# Use the subset palette for plotting
plot_mssnd_salinity(ms_data, colors = station_colors)


# Change layout to single row
plot_mssnd_salinity(ms_data, nrow = 1)
}

}
