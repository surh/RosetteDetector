# (C) Copyright 2017 Sur Herrera Paredes
# 
# This file is part of RosetteDetector.
# 
# RosetteDetector is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# RosetteDetector is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with RosetteDetector.  If not, see <http://www.gnu.org/licenses/>.

#' Make cell histograms
#' 
#' This functions makes histograms of gradients per \emph{cells} in a figure. It is intendend
#' to be the first step in the \strong{histograms of oriented gradients} (HOG) method which can be
#' used as input for object detection. The following steps of the method are not implemented
#' and thus this function is here for experimental reasons. It might be rewritten, modified,
#' updated or deprecated in the future
#' 
#' @param x An image object. Must be a two-dimensional matrix
#' @param nbins Number of bins to use for the histograms that are th inpit to HOG.
#' @param cellsize Cell size for HOG. Algorithm will make squre cells of whre each side is
#' of size \emph{cellsize}.
#' 
#' @author Sur Herrera Paredes
#' 
#' @return A data.frame where each row corresponds to  cell. The data.frame has \emph{nbins} + 2 columns
#' whre the firs two columns indicate the cell position, followd by  *nbins* columns corresponding
#' to each of the histogram bins.
#' 
#' @export
make_cell_histograms <- function(x,nbins=9,cellsize=8){
  
  bins <- seq(from=-90,to=90,length.out=nbins+1)
  cellsize <- cellsize - 1
  Cells <- NULL
  for(j in 1:(dim(x$x)[2] - cellsize)){
    for(i in 1:(dim(x$x)[1] - cellsize)){
      cell.orientation <- as.vector(x$orientation[i:(i+cellsize),j:(j+cellsize)])
      cell.magnitude <- as.vector(x$magnitude[i:(i+cellsize),j:(j+cellsize)])
      
      cell.bins <- cut(cell.orientation,breaks=bins)
      cell.hist <- tapply(cell.magnitude,cell.bins,sum)
      Cells <- rbind(Cells,c(i,j,cell.hist)) 
    }
  }
  Cells <-as.data.frame(Cells)
  return(Cells)
}
