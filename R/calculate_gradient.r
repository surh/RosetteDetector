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

#' Calculate gradient
#' 
#' @export
calculate_gradient <- function(x){
  #   x <- pot1[,,2]
  #   
  grad1 <- matrix(c(-1,0,1),ncol=3)
  grad2 <- matrix(c(-1,0,1),ncol=1)
  x.grad1 <- filter2(x,filter=grad1)
  x.grad2 <- filter2(x,filter=grad2)
  x.magnitude <- sqrt(x.grad1^2 + x.grad2^2)
  x.orientation <- atan(x.grad2 / x.grad1) * 180 / pi
  
  res <- list(x= x, gradx = x.grad1, grady = x.grad2, magnitude = x.magnitude, orientation = x.orientation)
  return(res)
}

