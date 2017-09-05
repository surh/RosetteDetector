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
indir <- "~/rhizogenomics/data/rosette_phenotyping/BinaryAssociations/biomass_renamed_cropped/"
#indir <- base::system.file("images", package = "RosetteDetector", mustWork = TRUE)
outdir <- "~/rhizogenomics/experiments/2017/today5/out/"

toplef.min <- c(0.0,0.20,0.25)
topleft.max <- c(0.25,0.3,0.4)
topright.min <- c(0.0,-0.7,0.0)
topright.max <- c(0.15,-0.2,0.2)
bottomleft.min <- c(0.1,-0.2,-0.2)
bottomleft.max <- c(0.4,0.1,0.1)

transform <- "logplus1"
adjust <- 30
plot_all_steps <- TRUE

################ Setup run ########
dir.create(outdir)
if(plot_all_steps){
  dir.create(paste(outdir,"/1.stickers/",sep = ""))
  dir.create(paste(outdir,"/2.four_points/",sep = ""))
  dir.create(paste(outdir,"/3.adjusted/",sep = ""))
}
dir.create(paste(outdir,"/cropped/",sep = ""))

# Read file list
files <- list.files(indir)
# Process files
for(file in files){
  #file <- files[1]
  
  name <- sub(pattern = "[.](jpeg|jpg)", replacement = "",
              x = file, ignore.case = TRUE)
  pic_file <- paste(indir,"/",file, sep = "")
  cat(pic_file,"\n")
  
  
  img <- readImage(pic_file)
  
  ## Find the three stickers
  if(transform == "logplus1"){
    dot <- find_three_stickers(img = log(img) + 1,
                               toplef.min = toplef.min,
                               topleft.max = topleft.max,
                               topright.min = topright.min,
                               topright.max = topright.max,
                               bottomleft.min = bottomleft.min,
                               bottomleft.max = bottomleft.max)
  }else{
    dot <- find_three_stickers(img = img,
                               toplef.min = toplef.min,
                               topleft.max = topleft.max,
                               topright.min = topright.min,
                               topright.max = topright.max,
                               bottomleft.min = bottomleft.min,
                               bottomleft.max = bottomleft.max)
  }
  if(plot_all_steps){
    filename <- paste(outdir,"/1.stickers/",name,".stickers.png", sep = "")
    png(filename = filename, width = dim(img)[1], height = dim(img)[2])
    plot_platecrop(img,dot)
    dev.off()
  }
  
  ## Find fourth 'sticker'
  dot <- find_fourth_point(x = dot)
  if(plot_all_steps){
    filename <- paste(outdir,"/2.four_points/",name,".four_points.png", sep = "")
    png(filename = filename, width = dim(img)[1], height = dim(img)[2])
    plot_platecrop(img,dot)
    dev.off()
  }
  
  # Adjust coordinates of rectangle
  dot.adj <- adjust_rectangle(points = dot, v = adjust, h = 0)
  if(plot_all_steps){
    filename <- paste(outdir,"/3.adjusted/",name,".adjusted.png", sep = "")
    png(filename = filename, width = dim(img)[1], height = dim(img)[2])
    plot_platecrop(img,dot.adj)
    dev.off()
  }
  
  ## Crop images
  prefix <- paste(outdir,"/cropped/",name,".", sep = "")
  crop <- crop_plate(img,dot.adj,prefix=prefix,cols = 4, rows = 3,return.images = FALSE,
                     adjust.cell = 10)
  
}




# # Crop file
# dir.create("output")
# crop <- crop_plate(img,res.adj,prefix="output/example1.",cols = 4, rows = 3,return.images = TRUE,
#                    adjust.cell = 10)
# 
# # 
# data("m1_20141021tiny")
# sizes <- wrapper_predictdir_9feat(img_dir = "output/",overlaydir = "overlay",maskdir = "mask",m1 = m1)
# sizes$Normalized.size <- sizes$npixels / res$size
# sizes
# 
# # Calculate hull area from file
# maskdir <- "mask/"
# sizes$Hull.area <- NULL
# for(i in 1:nrow(sizes)){
#   file <- as.character(sizes$file[i])
#   file <- paste(maskdir,"/",basename(file),sep = "")
#   cat(file,"\n")
#   mask <- readImage(file)
#   sizes$Hull.area[i] <- hull_area_from_masks(mask)
# }
# sizes$Normalized.hull.area <- sizes$Hull.area / res$size
# row.names(sizes) <- NULL
# sizes
# 
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
# 
# 
# # # To generate combinations
# # rows <- c(10,20,30)
# # cols <- c(40,80,120,160)
# # expand.grid(rows = rows, cols = cols)
