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
#' Wrapper for \link{find_sticker} it finds three similar objects. It assumes that there are
#' three objects that can be found with \link{find_sticker} which are named "topleft", "topright",
#' and "bottomleft".
#' 
#' This function was designed with a specific setup in mind. Namely the need to identify a rectangular
#' area that is defined by three colored points on each of three of its vertices. See the file
#' example1.jpeg included with this package for an example.
#' 
#' @param img Image object. From EBImage.
#' @param topleft.min,topleft.max The minimum and maximum RGB values defining a range on
#' which a feature at position "topleft" is expected to exist.
#' @param topright.min,topright.max Similar to above, but for an element at position topright.
#' @param bottmleft.min,bottomleft.max Similar to above, but for an element at position bottomleft.
#' @param return.image NOT IMPLEMENTED. Logical, indicating whether to return the masked object(s).
#' 
#' @author Sur Herrera Paredes
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
