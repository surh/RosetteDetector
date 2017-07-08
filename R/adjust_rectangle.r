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
#' @param points A list containing topleft, topright, bottomleft, and bottomright entries.
#' Each entry must be a names numeric vector of lecgth two with elements "m.cy" and "m.cy",
#' which correspond to the x and y coordinates of each point
#' @param v,h Adjustment distance in vertical and horizontal direction respectively. Must
#' be an integer in pixels. 0 doesn't change anything in that direction.
#'  
#' @export
adjust_rectangle <- function(points,v = 0,h = 0) {
  
  if(any(sapply(points[1:4], is.null))){
    stop("ERROR: All four points must be defined",call. = TRUE)
  }
  
  if(v != 0){
    # Left
    #dis <- dist(rbind(points$topleft,points$bottomleft))
    new.points <- increase_segment(x1 = points$topleft["m.cx"],
                                   y1 = points$topleft["m.cy"],
                                   x2 = points$bottomleft["m.cx"],
                                   y2 = points$bottomleft["m.cy"],
                                   increase = v)
    points$topleft <- new.points$A
    points$bottomleft <- new.points$B
    # plot_platecrop(img,points)
    
    # Right
    # dis <- dist(rbind(points$topright,points$bottomright))
    new.points <- increase_segment(x1 = points$topright["m.cx"],
                                   y1 = points$topright["m.cy"],
                                   x2 = points$bottomright["m.cx"],
                                   y2 = points$bottomright["m.cy"],
                                   increase = v)
    points$topright <- new.points$A
    points$bottomright <- new.points$B
    
  }
  
  if(h != 0){
    # Top
    # dis <- dist(rbind(points$topleft,points$topright))
    new.points <- increase_segment(x1 = points$topleft["m.cx"],
                                   y1 = points$topleft["m.cy"],
                                   x2 = points$topright["m.cx"],
                                   y2 = points$topright["m.cy"],
                                   increase = h)
    points$topleft <- new.points$A
    points$topright <- new.points$B
    
    # Bottom
    # dis <- dist(rbind(points$bottomleft,points$bottomright))
    new.points <- increase_segment(x1 = points$bottomleft["m.cx"],
                                   y1 = points$bottomleft["m.cy"],
                                   x2 = points$bottomright["m.cx"],
                                   y2 = points$bottomright["m.cy"],
                                   increase = h)
    points$bottomleft <- new.points$A
    points$bottomright <- new.points$B
  }
  
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

