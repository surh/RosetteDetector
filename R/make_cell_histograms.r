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


make_cell_histograms <- function(x,nbins=9,cellsize=8){
  #   x <- pot1.full
  #   nbins <- 9
  #   cellsize <- 8
  
  bins <- seq(from=-90,to=90,length.out=nbins+1)
  cellsize <- cellsize - 1
  Cells <- NULL
  for(j in 1:(dim(x$x)[2] - cellsize)){
    for(i in 1:(dim(x$x)[1] - cellsize)){
      #   for(j in 1:10){
      #     for(i in 1:10){
      #       i <- 1
      #       j <- 1
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