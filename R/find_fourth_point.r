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

#' Find fourth point
#' 
#' @export
find_fourth_point <- function(x){
  if(is.null(x$bottomright)){
    x.new <- (x$topright[ "m.cx" ] - x$topleft[ "m.cx" ]) + x$bottomleft[ "m.cx" ]
    y.new <- x$topright["m.cy"] + (x$bottomleft[ "m.cy" ] - x$topleft[ "m.cy" ])
    
    x$bottomright <- c(x.new, y.new)
  }else{
    stop("ERROR: Not implemented",call. = TRUE)
  }
  
  return(x)
}
