\name{SpectrumSimilarity}
\alias{SpectrumSimilarity}
\title{Similarity Between Two Mass Spectra}
\description{Generate a head-to-tail plot of the two mass spectra and calculate a similarity score.}
\usage{
SpectrumSimilarity(spec.top, spec.bottom, t = 0.25, b = 10, 
                   top.label = NULL, bottom.label = NULL, 
                   xlim = c(50, 1200), x.threshold = 0, 
                   print.alignment = FALSE, print.graphic = TRUE,
                   output.list = FALSE)
}
\arguments{
    \item{spec.top}{data frame containing the experimental spectrum's peak list with the \emph{m/z} values in the first column and corresponding intensities in the second}
    \item{spec.bottom}{data frame containing the reference spectrum's peak list with the \emph{m/z} values in the first column and corresponding intensities in the second}
    \item{t}{numeric value specifying the tolerance used to align the \emph{m/z} values of the two spectra.}
    \item{b}{numeric value specifying the baseline threshold for peak identification.  Expressed as a percent of the maximum intensity.}
    \item{top.label}{character string to label the top spectrum.}
    \item{bottom.label}{character string to label the bottom spectrum.}
    \item{xlim}{numeric vector of length 2, defining the beginning and ending values of the x-axis.}
    \item{x.threshold}{numeric value of length 1 specifying the \emph{m/z} threshold used for the similarity score calculation. Only peaks with \emph{m/z} values above the threshold are used in the calculation. This can be used to exclude noise and/or non-specific ions at the low end of the spectrum. By default all ions are used.}
    \item{print.alignment}{TRUE or FALSE value specifying if a data frame showing the aligned \emph{m/z} values should be printed. Default is FALSE. The data frame contains aligned peak intensities from the top and bottom spectra, and is used to check the results. It contains all peaks, not only those subsetted by the \code{b} and \code{x.threshold} arguments.}
    \item{print.graphic}{TRUE or FALSE value specifying if the head-to-tail plot should be printed. The defaut value is TRUE. The unaligned spectra are shown in the plot.}
    \item{output.list}{TRUE or FALSE. If TRUE, will return a list with the similarity score, alignment dataframe, and plot. The plot is a gTree (grid graphics) object.}
}
\details{
The mass spectral similarity score is calculated as (where \eqn{\cdot}{\%*\%} is the dot product) \deqn{\cos \theta = \frac{u \cdot v}{\sqrt{u \cdot u} \sqrt{v \cdot v}}}{cos \theta = (u \%*\% v) / (sqrt(sum(u^2)) * sqrt(sum(v^2)))} where \eqn{u} and \eqn{v} are the aligned intensity vectors of the two spectra, as subsetted by the \code{b} and \code{x.threshold} arguments.  The \code{t} argument is used to align the intensities.  The bottom spectum is used as the reference spectrum, and the \emph{m/z} values of peaks in the top spectrum that are within \code{t} of a reference \emph{m/z} value are paired with that reference peak.  Ideally, a single peak from the top spectrum should be paired with a single peak from the reference spectrum. Peaks without a match are paired with an intensity of zero.

Note that, although both are based on the cosine of the two intensity vectors, the spectral similarity score given by \code{SpectrumSimilarity} is not the same as that given by the NIST MS Search program, described in the reference below. 
}
\references{
"Optimization and Testing of Mass Spectral Library Search Algorithms for Compound Identification," Stein SE, Scott DR, \emph{Journal of the American Society for Mass Spectrometry}, 1994, 5, 859-866.
}
\value{A vector containing the similarity score. By default a base graphics head-to-tail plot of the two mass spectra is printed, and optionally the data frame showing the peak alignment is printed. Alternatively, if \code{output.list = TRUE} the function will return a list with the similarity score, alignment dataframe, and plot. In this case the plot is a gTree (grid graphics) object.}
\author{Nathan G. Dodder}
\seealso{\code{\link{PeptideSpectrum}}}
\examples{

## With output.list = FALSE (default)
SpectrumSimilarity(example.spectrum.unknown, example.spectrum.authentic,
                   top.label = "unknown, electron impact", 
                   bottom.label = "derivatized alanine, electron impact",
                   xlim = c(25, 350))
# label peaks
plot.window(xlim = c(25,350), ylim = c(-125, 125))
text(c(73, 147, 158, 232, 260), c(100, 23, 44, 22, 15) + 10,
     c(73, 147, 158, 232, 260), cex = 0.75)
text(c(73, 147, 158, 232, 260), -c(100, 47, 74, 33, 20) - 10, 
     c(73, 147, 158, 232, 260), cex = 0.75)
mtext("Spectrum similarity", line = 1)

## With output.list = TRUE
x <- SpectrumSimilarity(example.spectrum.unknown, example.spectrum.authentic,
                   top.label = "unknown, electron impact", 
                   bottom.label = "derivatized alanine, electron impact",
                   xlim = c(25, 350), output.list = TRUE)

print(x)
grid.newpage()
grid.draw(x$plot) # draw to device
}
