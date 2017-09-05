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

#' Plot platecrop
#' 
#' Plots plate and cropping parameters. Mostly for testing, it uses raster plotting
#' to plot the location of up to 4 circles on top of the image
#' 
#' @param img An image file from EBImage.
#' @param points A list with up to four sets of coordinates indicating the positions were to
#' plot the circles. The list must contains elements \emph{topright}, \emph{topleft},
#' \emph{bottomright}, and \emph{bottomleft}, each of which should ve a vector with entries
#' "m.cx" and "m.cy" for the X- and Y-coordinates respectivelu. The list must also contain
#' an enty called \emph{size} wich has the size in pixels of the circle to draw
#' 
#' @returns The raster image of \emph{img}
#' 
#' @author Sur Herrera Paredes
#' 
#' @export
plot_platecrop <- function(img,points){
  
  # Rasterize image from EBIimage
  img.ras <- raster::brick(img * 255, xmn = 0, xmx = dim(img)[1], ymn = 0, ymx = dim(img)[2],
                           crs = "+proj=merc +datum=WGS84", transpose = TRUE)
  
  raster::plotRGB(img.ras)
  p1 <- plotrix::draw.circle(x = points$bottomright["m.cx"],
                             y = dim(img)[2] - points$bottomright["m.cy"],
                             radius = sqrt(points$size / pi),
                             nv =200,border=NULL,col="yellow",lty=1,lwd=1)
  p2 <- plotrix::draw.circle(x = points$topright["m.cx"],
                             y = dim(img)[2] - points$topright["m.cy"],
                             radius = sqrt(points$size / pi),
                             nv =200,border=NULL,col="magenta",lty=1,lwd=1)
  p3 <- plotrix::draw.circle(x = points$topleft["m.cx"],
                             y = dim(img)[2] - points$topleft["m.cy"],
                             radius = sqrt(points$size / pi),
                             nv =200,border=NULL,col="blue",lty=1,lwd=1)
  p4 <- plotrix::draw.circle(x = points$bottomleft["m.cx"],
                             y = dim(img)[2] - points$bottomleft["m.cy"],
                             radius = sqrt(points$size / pi),
                             nv =200,border=NULL,col="red",lty=1,lwd=1)
  
  return(img.ras)
}