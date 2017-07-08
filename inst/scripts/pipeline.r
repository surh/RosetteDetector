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

library(RosetteDetector)

img_file <- base::system.file("images","example1.jpeg", package = "RosetteDetector", mustWork = TRUE)
# img_file <- base::system.file("images","example2.jpeg", package = "RosetteDetector", mustWork = TRUE)
img <- EBImage::channel(x = EBImage::readImage(img_file),mode = "rgb")
# mins <- c(0,0.2,0.3)
# maxs <- c(0.15,0.3,0.5)

# # This finds top left
# res <- find_sticker(img = img, mins = c(0.1,0.25,0.25), maxs = c(0.25,0.3,0.4), return.img = TRUE)
# res
# display(res$img)
# 
# # This finds top right
# res <- find_sticker(img = img, mins = c(0.1,0.0,0.1), maxs = c(0.2,0.15,0.3), return.img = TRUE)
# res
# display(res$img)
# 
# # This finds bottom left
# res <- find_sticker(img = img, mins = c(0.2,0.1,0.1), maxs = c(0.4,0.2,0.2), return.img = TRUE)
# res
# display(res$img)

res <- find_three_stickers(img = img)
res
# plot_platecrop(img,res)

res <- find_fourth_point(x = res)
res

plot_platecrop(img,res)

adjust_rectangle(points = res, v = 1.2, h = 1)



dir.create("output")
files <- crop_plate(img,res,prefix="output/example1.")

data("m1_20141021tiny")
sizes <- wrapper_predictdir_9feat(img_dir = "output/",overlaydir = "overlay",maskdir = "mask",m1 = m1)
sizes$Normalized.size <- sizes$npixels / res$size
sizes

# Calculate hull area from file
maskdir <- "mask/"
sizes$Hull.area <- NULL
for(i in 1:nrow(sizes)){
  file <- as.character(sizes$file[i])
  file <- paste(maskdir,"/",basename(file),sep = "")
  cat(file,"\n")
  mask <- readImage(file)
  sizes$Hull.area[i] <- hull_area_from_masks(mask)
}
sizes$Normalized.hull.area <- sizes$Hull.area / res$size
row.names(sizes) <- NULL
sizes

# Some manual plot
sizes$Type <- c(rep("dead",3),rep("+Bacteria",6),rep("No Bacteria",3))
sizes

p1 <- ggplot2::ggplot(sizes,ggplot2::aes(x = Type, y = Normalized.hull.area, col = Type)) +
  ggplot2::geom_point() +
  AMOR::theme_blackbox
p1

p1 <- ggplot2::ggplot(sizes,ggplot2::aes(x = Type, y = Normalized.size, col = Type)) +
  ggplot2::geom_point() + 
  AMOR::theme_blackbox
p1

p1 <- ggplot2::ggplot(sizes,ggplot2::aes(x = Normalized.hull.area, y = Normalized.size, col = Type)) +
  ggplot2::geom_point() + 
  AMOR::theme_blackbox
p1


# # To generate combinations
# rows <- c(10,20,30)
# cols <- c(40,80,120,160)
# expand.grid(rows = rows, cols = cols)
