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

date()

######## General parameters #################
indir <- "~/rhizogenomics/experiments/2017/today5/out/"

outdir <- indir

# Predict size directory
data("m1_20141021tiny")
img_dir <- paste(indir,"/cropped/", sep = "")
overlay_dir <- paste(indir,"/overlay/", sep = "")
mask_dir <- paste(indir,"/mask/", sep = "")
sizes <- wrapper_predictdir_9feat(img_dir = img_dir,
                                  overlaydir = overlay_dir,
                                  maskdir = mask_dir,
                                  m1 = m1)

# Read sticker sizes
Stickers <- read.table(paste(outdir,"/sticker.sizes.txt", sep = ""), sep = "\t", header = TRUE)
head(Stickers)

# Reformat sizes
row.names(sizes) <- NULL
sizes$name <- basename(as.character(sizes$file))
sizes <- cbind(sizes, do.call(rbind,strsplit(sizes$name,split = "[.]")))
colnames(sizes) <- c("file","npixels","filename","Strain","Plate", "Col", "Row", "format")
sizes$format <- NULL
sizes$PlateID <- paste(sizes$Strain,sizes$Plate,sep = ".")
sizes$file <- NULL
head(sizes)

# Normalize
sizes$Sticker.size <- Stickers$Size[ match(x = sizes$PlateID,table = as.character(Stickers$Name))]
sizes$Normalized.size <- sizes$npixels / sizes$Sticker.size
head(sizes)


# Calculate hull area from maskfile
sizes$Hull.area <- NA
for(i in 1:nrow(sizes)){
  file <- as.character(sizes$filename[i])
  file <- paste(mask_dir,"/",basename(file),sep = "")
  cat(file,"\n")
  mask <- readImage(file)
  sizes$Hull.area[i] <- hull_area_from_masks(mask)
}
sizes$Normalized.hull.area <- sizes$Hull.area / sizes$Sticker.size
head(sizes)

filename <- paste(indir,"/sizes.txt", sep = "")
write.table(sizes, filename, sep = "\t", quote = FALSE, col.names = TRUE, row.names = FALSE)

# # Some manual plot
# sizes$Type <- c(rep("dead",3),rep("+Bacteria",6),rep("No Bacteria",3))
# sizes
# 
# p1 <- ggplot2::ggplot(sizes,ggplot2::aes(x = Type, y = Normalized.hull.area, col = Type)) +
#   ggplot2::geom_point() +
#   AMOR::theme_blackbox
# p1
# 
# p1 <- ggplot2::ggplot(sizes,ggplot2::aes(x = Type, y = Normalized.size, col = Type)) +
#   ggplot2::geom_point() +
#   AMOR::theme_blackbox
# p1
# 
# p1 <- ggplot2::ggplot(sizes,ggplot2::aes(x = Normalized.hull.area, y = Normalized.size, col = Type)) +
#   ggplot2::geom_point() +
#   AMOR::theme_blackbox
# p1


# # To generate combinations
# rows <- c(10,20,30)
# cols <- c(40,80,120,160)
# expand.grid(rows = rows, cols = cols)

date()
