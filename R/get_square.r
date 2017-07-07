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

#' Get square
#' 
#' Get gets the final point in the rectangle
#' 
#' @export
get_square <- function(topright = NULL, topleft = NULL,
                       bottomright = NULL, bottomleft = NULL) {
  topright <- stickers$pos[ stickers$pos$Location == "topright", c("m.cx","m.cy") ]
  topleft <- stickers$pos[ stickers$pos$Location == "topleft", c("m.cx","m.cy") ]
  bottomleft <- stickers$pos[ stickers$pos$Location == "bottomleft", c("m.cx","m.cy") ]
  bottomright <- NULL
  
  n.nulls <- is.null(topright) + is.null(topleft) + is.null(bottomright) + is.null(bottomleft)
  if(n.nulls > 1){
    stop("ERROR: only one point can be missing")
  }
  
  if(is.null(bottomright)){
    bottomright <- topright + bottomleft
  }else{
    stop("ERROR: not implemented yet")
  }
  
  ncols <- 4
  nrows <- 3
  
  topleft <- round(topleft)
  topright <- round(topright)
  bottomleft <- round(bottomleft)
  bottomright <- round(bottomright)
  
  # get colums
  disleft <- dist(rbind(topleft,bottomleft))
  left.segment <- disleft / nrows
  disright <- dist(rbind(topright,bottomright))
  right.segment <- disright / nrows
  
  left.points <- seq(from = topleft[1,"m.cy"], to = bottomleft[1,"m.cy"], length.out = nrows + 1)
  right.points <- seq(from = topright[1,"m.cy"], to = bottomright[1,"m.cy"], length.out = nrows + 1)
  
  
}