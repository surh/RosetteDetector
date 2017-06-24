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
#' Finds position of a sticker based on thresholds
#' 
#' @author Sur Herrera Paredes
#' 
#' @export
find_sticker <- function(img,mins,maxs,return.img = FALSE) {
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
    
    mono.img <- channel(x = img[,,rgb.channel],mode = "gray")
    # display(mono.img)
    # display(mono.img >= topleft.min[rgb.channel])
    # display(mono.img <= topleft.max[rgb.channel])
    # 
    # display(mono.img >= 0.3)
    # display(mono.img <= 0.5)
    
    selected[[rgb.channel]] <- (mono.img >= mins[rgb.channel]) & (mono.img <= maxs[rgb.channel])
    # display(selected)
  }
  # Merge
  selected <- selected[[1]] & selected[[2]] & selected[[3]]
  # display(selected)
  
  # Segment and pick biggest
  selected <- EBImage::bwlabel(selected)
  sizes <- table(selected)
  sizes <- sizes[ -which(names(sizes) == "0") ] 
  sizes <- sort(sizes, decreasing = TRUE)
  spot <- as.numeric(names(sizes[1]))
  selected[ selected != spot ] <- 0
  selected <- EBImage::fillHull(selected)
  selected <- bwlabel(selected)
  # table(selected)
  # display(selected)
  
  pos <- EBImage::computeFeatures.moment(x = selected)[1,c("m.cx","m.cy")]
  size <- EBImage::computeFeatures.shape(x = selected)[1,"s.area"]
  
  res <- list(pos = pos, size = size)
  if(return.img)
    res[["img"]] <- selected
  
  return(res)
}

img_file <- base::system.file("images","example1.jpeg", package = "RosetteDetector", mustWork = TRUE)
img <- EBImage::channel(x = EBImage::readImage(img_file),mode = "rgb")
# mins <- c(0,0.2,0.3)
# maxs <- c(0.15,0.3,0.5)

# This finds top left
res <- find_sticker(img = img, mins = c(0,0.2,0.3), maxs = c(0.15,0.3,0.5), return.img = TRUE)
res
display(res$img)

# This finds top right
res <- find_sticker(img = img, mins = c(0.1,0.0,0.1), maxs = c(0.2,0.15,0.3), return.img = TRUE)
res
display(res$img)


# This finds bottom left
res <- find_sticker(img = img, mins = c(0.2,0.1,0.1), maxs = c(0.4,0.2,0.2), return.img = TRUE)
res
display(res$img)
