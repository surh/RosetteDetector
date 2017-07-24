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

#' Get feature values
#' 
#' From an image it calculates 3 values per color chanel.
#' 
#' It obtrains the chanel intensity, as well as the chanel intensity gradient
#' and gradient orientation.
#' 
#' @param Img An image object. Should be from EBImage, but any three dimensional
#' matrix with 3 chanels specified by the last dimension should work.
#' 
#' @return A data.frame with feature values for all pixels
#' 
#' @author Sur Herrera Paredes
#' 
#' @export
get_values <- function(Img){
#   Img <- Images[[1]]
  
  # Get gradients
  Grad_R <- calculate_gradient(Img$img[,,1])
  Grad_G <- calculate_gradient(Img$img[,,2])
  Grad_B <- calculate_gradient(Img$img[,,3])
  
  # make table
  #img.molten <- melt(Img$mask)
  img.molten <- melt_channels(Img$img)
  img.molten$mag_R <- melt(Grad_R$magnitude)$value
  img.molten$mag_G <- melt(Grad_G$magnitude)$value
  img.molten$mag_B <- melt(Grad_B$magnitude)$value
  img.molten$or_R <- melt(Grad_R$orientation)$value
  img.molten$or_G <- melt(Grad_G$orientation)$value
  img.molten$or_B <- melt(Grad_B$orientation)$value
  img.molten[is.na(img.molten)] <- 0
  
  return(img.molten)
}
