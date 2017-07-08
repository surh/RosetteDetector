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

#' Adjust rectangle
#' 
#' Increases the distance between points by some factor.
#'  
#' @export
adjust_rectangle <- function(points,v = 1,h = 1) {
  points <- res
  v <- 30
  #https://math.stackexchange.com/questions/352828/increase-length-of-line
  
  new.points <- increase_segment(x1 = points$topleft["m.cx"],
                                 y1 = points$topleft["m.cy"],
                                 x2 = points$bottomleft["m.cx"],
                                 y2 = points$bottomleft["m.cy"],
                                 increase = v)
  new.points
  res <- points
  
  res$topleft <- new.points$A
  res$bottomleft <- new.points$B
  plot_platecrop(img,res)
  
  
  # Left
  dis <- dist(rbind(points$topleft,points$bottomleft))
  delta.x <- 
  
  return(points)
  
}

#' Increase segment
#' 
#' internal
increase_segment <- function(x1,y1,x2,y2,increase){
  delta.x <- (x2 - x1) / sqrt((x2-x1)^2 + (y2-y1)^2)
  delta.y <- (y2 - y1) / sqrt((x2-x1)^2 + (y2-y1)^2)
  
  point.A <- c( x1 - increase*delta.x,
                y1 - increase*delta.y)
  
  point.B <- c( x2 + increase*delta.x,
                y2 + increase*delta.y)
  
  res <- list(A = point.A, B = point.B)
  return(res)
}

