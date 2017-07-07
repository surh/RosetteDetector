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
#' Plots plate and cropping parameters
#' 
#' Mostly for testing
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