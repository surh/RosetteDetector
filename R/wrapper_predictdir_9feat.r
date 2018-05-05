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

#' Predict from 9 features
#' 
#' Takes a directory of images, and tries to predict on all images on that directory
#' 
#' @param img_dir Directory name where images files are
#' @param overlaydir directory anem where to save the overlay images
#' @param maskdir directory name where the mask files are saved
#' @param m1 trained SVM model from e1071 used for prediction
#' @param size_threshold the minimum size of of a contiguous set of
#' selected threshold for that group to be included. Size is in number
#' of pixels.
#' 
#' @author Sur Herrera Paredes
#' 
#' @return Data.frame showing file names processed and object size in pixels
#' from each file
#' 
#' @export
wrapper_predictdir_9feat <- function(img_dir , overlaydir , maskdir, m1, size_threshold = 0){
  # Get image files and create output directories
  pictures <- paste(img_dir,dir(img_dir),sep="/")
  dir.create(overlaydir)
  dir.create(maskdir)
  
  # Predict
  res <- sapply(pictures,predict_image,
                m1 = m1, size_threshold = size_threshold,
                predict_class = "plant", outmask = maskdir, outoverlay = overlaydir)
  Res <- data.frame(file = names(res), npixels = res)
  
  return(Res)
}
