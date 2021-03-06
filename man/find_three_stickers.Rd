% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/find_three_stickers.r
\name{find_three_stickers}
\alias{find_three_stickers}
\title{Find the three stickers in standard positions}
\usage{
find_three_stickers(img, topleft.min = c(0.1, 0.25, 0.25),
  topleft.max = c(0.25, 0.3, 0.4), topright.min = c(0.1, 0, 0.1),
  topright.max = c(0.2, 0.15, 0.3), bottomleft.min = c(0.2, 0.1, 0.1),
  bottomleft.max = c(0.4, 0.2, 0.2), return.img = FALSE)
}
\arguments{
\item{img}{Image object. From EBImage.}

\item{topleft.min, topleft.max}{The minimum and maximum RGB values defining a range on
which a feature at position "topleft" is expected to exist.}

\item{topright.min, topright.max}{Similar to above, but for an element at position topright.}

\item{bottomleft.min, bottomleft.max}{Similar to above, but for an element at position bottomleft.}

\item{return.img}{NOT IMPLEMENTED. Logical, indicating whether to return the masked object(s).}
}
\description{
Wrapper for \link{find_sticker} it finds three similar objects. It assumes that there are
three objects that can be found with \link{find_sticker} which are named "topleft", "topright",
and "bottomleft".
}
\details{
This function was designed with a specific setup in mind. Namely the need to identify a rectangular
area that is defined by three colored points on each of three of its vertices. See the file
example1.jpeg included with this package for an example.
}
\author{
Sur Herrera Paredes
}
