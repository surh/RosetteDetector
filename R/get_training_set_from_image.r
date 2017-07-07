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

#' Get training set from image
#' 
#' @export
get_trainig_set_from_image <- function(Img,n_bgpixels=1000){
  #Img <- Images[[1]]
  
  # Get gradients
  Grad_R <- calculate_gradient(Img$img[,,1])
  Grad_G <- calculate_gradient(Img$img[,,2])
  Grad_B <- calculate_gradient(Img$img[,,3])
  
  # make table
  img.molten <- melt(Img$mask)
  img.molten <- cbind(img.molten,melt_channels(Img$img)[,3:5])
  img.molten$mag_R <- melt(Grad_R$magnitude)$value
  img.molten$mag_G <- melt(Grad_G$magnitude)$value
  img.molten$mag_B <- melt(Grad_B$magnitude)$value
  img.molten$or_R <- melt(Grad_R$orientation)$value
  img.molten$or_G <- melt(Grad_G$orientation)$value
  img.molten$or_B <- melt(Grad_B$orientation)$value
  img.molten[is.na(img.molten)] <- 0
  
  # select data
  Dat <- img.molten[ !img.molten$value, ]
  if(!is.null(n_bgpixels)){
    Dat <- Dat[sample(1:nrow(Dat),size=n_bgpixels),]
  }
  Dat <- rbind(Dat,img.molten[ img.molten$value, ])
  
  Dat$Var1 <- NULL
  Dat$Var2 <- NULL
  
  return(Dat)
}

