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
#' @export
wrapper_predictdir_9feat <- function(img_dir , overlaydir , maskdir, m1){
  # Get image files and create output directories
  pictures <- paste(img_dir,dir(img_dir),sep="/")
  dir.create(overlaydir)
  dir.create(maskdir)
  
  # Predict
  res <- sapply(pictures,predict_image,
                m1 = m1, size_threshold = 0, predict_class = "plant", outmask = maskdir, outoverlay = overlaydir)
  Res <- data.frame(file = names(res), npixels = res)
  
  return(Res)
}
