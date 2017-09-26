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
opts <- NULL
opts[1] <- "~/rhizogenomics/experiments/2017/2017-09-04.binary_plate_sizes/out/"
opts[2] <- "greenness.txt"

indir <- opts[1]
outfile <- opts[2]


# Get cropped figures
cropped_dir <- paste(indir,"/cropped/",sep = "")
cropped_files <- list.files(cropped_dir)

# Get mask files
mask_dir <- paste(indir,"/mask/", sep = "")
mask_files <- list.files(mask_dir)

# Check that files match
if(any(mask_files != cropped_files)){
  stop("ERROR")
}

Res <- NULL
for (f in cropped_files){
  #f <- cropped_files[1]
  
  cat(f, "\n")
  
  # Read image and mask
  infile <- paste(cropped_dir,"/",f, sep = "")
  img <- readImage(infile)
  infile <- paste(mask_dir,"/",f, sep = "")
  mask <- readImage(infile)
 
  # Calculate greenness
  green <- median(255 * img[,,2][ mask > 0])
  
  # Get info
  info <- strsplit(f, split = "[.]")[[1]]
  #info
  
  res <- data.frame(green = green, filename = f,
                    Strain = info[1],
                    Plate = info[2],
                    Col = info[3],
                    Row = info[4],
                    PlateID = paste(info[1],
                                    info[2],
                                    sep = "."))
  
  Res <- rbind(Res, res)
}

write.table(Res,outfile, sep = "\t", col.names = TRUE, row.names = FALSE,
            quote = FALSE)

