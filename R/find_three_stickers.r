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

#' Find the three stickers in standard positions
#' 
#' @export
find_three_stickers <- function(img,
                                toplef.min = c(0.1,0.25,0.25),
                                topleft.max = c(0.25,0.3,0.4),
                                topright.min = c(0.1,0.0,0.1),
                                topright.max = c(0.2,0.15,0.3),
                                bottomleft.min = c(0.2,0.1,0.1),
                                bottomleft.max = c(0.4,0.2,0.2),
                                return.img = FALSE) {
  
  topleft <- find_sticker(img = img,mins = toplef.min, maxs = topleft.max, return.img = return.img)
  topright <- find_sticker(img = img,mins = topright.min, maxs = topright.max, return.img = return.img)
  bottomleft <- find_sticker(img = img,mins = bottomleft.min, maxs = bottomleft.max, return.img = return.img)
  bottomright <- list(pos = NULL,size = NULL)
  
  mean.size <- mean(topleft$size, topright$size, bottomleft$size)
  
  return(list(topleft = topleft$pos, topright = topright$pos,
              bottomleft = bottomleft$pos, bottomright = bottomright$pos,
              size = mean.size))
}