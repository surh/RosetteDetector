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

#' Train on 3 classes and 9 functions
#' 
#' @export
wrapper_train_3class_9feat <- function(img_dir,plant_mask_dir,soil_mask_dir,other_mask_dir,
                                       kernel = "radial",pixels_per_class = 1000000, probability = TRUE){
  #   img_dir <- "test_images/pots/"
  #   plant_mask_dir <- "test_images/plant_mask/"
  #   soil_mask_dir <- "test_images/soil_mask/"
  #   other_mask_dir <- "test_images/other_mask/"
  #   kernel <- "radial"
  #   pixels_per_class <- 1000
  #   probability <- TRUE
  #   set.seed(21312)
  
  # Read images
  plant_images <- get_images_and_masks(img_dir,plant_mask_dir)
  soil_images <- get_images_and_masks(img_dir,soil_mask_dir)
  other_images <- get_images_and_masks(img_dir,other_mask_dir)
  # plant_images <- get_images_and_masks(img_dir,plant_mask_dir)
  # soil_images <- get_images_and_masks(img_dir,soil_mask_dir)
  # other_images <- get_images_and_masks(img_dir,other_mask_dir)
  
  # Process images
  other_set <- lapply(other_images,get_masked_pixels_training_set)
  other_set <- do.call(rbind,other_set)
  other_set$value <- "other"
  
  plant_set <- lapply(plant_images,get_masked_pixels_training_set)
  plant_set <- do.call(rbind,plant_set)
  plant_set$value <- "plant"
  
  soil_set <- lapply(soil_images,get_masked_pixels_training_set)
  soil_set <- do.call(rbind,soil_set)
  soil_set$value <- "soil"
  
  # Select pixels
  other_set <- other_set[ sample(nrow(other_set),size = pixels_per_class,replace = FALSE), ]
  soil_set <- soil_set[ sample(nrow(soil_set),size = pixels_per_class,replace = FALSE), ]
  plant_set <- plant_set[ sample(nrow(plant_set),size = pixels_per_class,replace = FALSE), ]
  
  # Merge dataset and train
  Dat <- rbind(other_set,soil_set,plant_set)
  Dat$value <- factor(Dat$value)
  m1.svm <- svm(value ~ .,data = Dat,kernel = kernel,probability = probability)
  
  return(list(m1 = m1.svm, Dat = Dat))
}
