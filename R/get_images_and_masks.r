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

#' Get images and masks
#' 
#' @export
get_images_and_masks <- function(img_dir,mask_dir){
  # Read images
  # mask_dir <- other_mask_dir
  
  mask_files <- dir(mask_dir)
  mask_dir <- mask_dir
  Images <- list()
  for(i in 1:length(mask_files)){
    file <- mask_files[i]
    mask <- paste(mask_dir,file,sep="/")
    img <- paste(img_dir,file,sep="/")
    
    Images[[i]] <- list(img=readImage(img),mask=readImage(mask))
    Images[[i]]$mask <- Images[[i]]$mask[,,1]
  }
  
  return(Images)
}

