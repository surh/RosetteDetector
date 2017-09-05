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

#' Find sticker
#' 
#' This functions takes a range of RGB values (minimums and maximums), and
#' finds the largest connected set of pixels that fall within those ranges.
#' 
#' @param img An image object. From the EBImage pacjage
#' @param mins,maxs Vectors of length three indicating the minimum and maxiimum values
#' (inclusive) for each of the RGB channels.
#' @param return.img logical indicating whether the thresholded image object must be reurned.
#' @param show.steps logical indicating whether the image from the different steps should be
#' displayed.
#' 
#' @return A list with elements:
#' \itemize{
#'   \item{pos}{The coordinates of the center of mass of the region found}
#'   \item{size}{The number of pixels in the area found}
#'   \item{img}{If return.img = TRUE, then this is an image object with the thresholded
#'   image}
#' }
#' 
#' @author Sur Herrera Paredes
#' 
#' @export
find_sticker <- function(img,mins,maxs,return.img = FALSE, show.steps = FALSE) {
  # img_file <- base::system.file("images","example1.jpeg", package = "RosetteDetector", mustWork = TRUE)
  # mins <- c(0,0.2,0.3)
  # maxs <- c(0.15,0.3,0.5)
  # img <- EBImage::channel(x = EBImage::readImage(img_file),mode = "rgb")
  # return.img <- TRUE
  
  selected <- list(NA,NA,NA)
  for(rgb.channel in 1:3){
    # rgb.channel <- 1
    # rgb.channel <- 2
    # rgb.channel <- 3
    
    mono.img <- EBImage::channel(x = img[,,rgb.channel],mode = "gray")
    # display(mono.img)
    # display(mono.img >= topleft.min[rgb.channel])
    # display(mono.img <= topleft.max[rgb.channel])
    # 
    # display(mono.img >= 0.3)
    # display(mono.img <= 0.5)
    
    selected[[rgb.channel]] <- (mono.img >= mins[rgb.channel]) & (mono.img <= maxs[rgb.channel])
    if(show.steps){
      display.title <- paste("Channel ",rgb.channel, sep = "")
      cat("\t",display.title,"\n")
      cat("\t",class(selected[[rgb.channel]]),"\n")
      display(selected[[rgb.channel]],title = display.title)
    }
    
  }
  # Merge
  selected <- selected[[1]] & selected[[2]] & selected[[3]]
  if(show.steps){
    display(selected, title = "Merged masks")
  }
  
  # Segment and pick biggest
  selected <- EBImage::bwlabel(selected)
  sizes <- table(selected)
  sizes <- sizes[ -which(names(sizes) == "0") ] 
  sizes <- sort(sizes, decreasing = TRUE)
  spot <- as.numeric(names(sizes[1]))
  selected[ selected != spot ] <- 0
  selected <- EBImage::fillHull(selected)
  selected <- EBImage::bwlabel(selected)
  # table(selected)
  # display(selected)
  
  pos <- EBImage::computeFeatures.moment(x = selected)[1,c("m.cx","m.cy")]
  size <- EBImage::computeFeatures.shape(x = selected)[1,"s.area"]
  
  res <- list(pos = pos, size = size)
  if(return.img)
    res[["img"]] <- selected
  
  return(res)
}
