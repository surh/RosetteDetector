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

######## General parameters #################
outdir <- "~/rhizogenomics/experiments/2017/today5/out/"





# Crop file
dir.create("output")
crop <- crop_plate(img,res.adj,prefix="output/example1.",cols = 4, rows = 3,return.images = TRUE,
                   adjust.cell = 10)

#
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
