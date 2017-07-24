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

#' Hull area from mask
#' 
#' From an image mask, it calcultates the hull area of the unmasked object
#' 
#' The mask must be a two-dimensional matrix where 0 values indicate masked pixels,
#' and non-zero values unmasked (selected) pixels. The convex hull is the smallest
#' convex polygon that encapsulates all the unmasked pixels, and this function returns
#' the area of that polygon
#' 
#' @param img A two-dimensional matrix representing an image mask. Any non-zero pixel is
#' considered as part of the oject that wants to be encapsulated.
#' 
#' @return The area (in pixels) of the convex hull
#' 
#' @author Sur Herrera Paredes
#' 
#' @export
hull_area_from_masks <- function(img){
  # mask <- readImage("mask/example1.col2.row1.jpeg")
  # display(mask)
  
  indices <- which(img > 0,arr.ind = TRUE)
  if(nrow(indices) == 0){
    return(0)
  }
  hull.index <- chull(indices)
  hull.coords <- indices[ hull.index,]
  hull.area <- splancs::areapl(hull.coords)
  
  return(hull.area)
}