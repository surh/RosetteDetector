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
#' Makes a list of matching images and their mask. Useful to bulk display mask
#' images
#' 
#' Takes two directories, one for images and another for masks, then for every
#' file in the mask directory (mask_dir), it looks for an \strong{identically} named file in the image
#' directory (img_dir), creating a list of matching images and masks.
#' 
#' @param img_dir A directory where images are located
#' @param mask_dir A directory containing \strong{only} mask files
#' 
#' @return A lust where each element is a list with elements img and
#' mask. Each of those elements is an EBImage image object.
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

