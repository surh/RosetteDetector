library(RosetteDetector)
library(methods)

img_file <- base::system.file("images","example1.jpeg", package = "RosetteDetector", mustWork = TRUE)
# img_file <- base::system.file("images","example2.jpeg", package = "RosetteDetector", mustWork = TRUE)
img <- EBImage::channel(x = EBImage::readImage(img_file),mode = "rgb")

# This finds top left
# res <- find_sticker(img = img, mins = c(0.1,0.25,0.25), maxs = c(0.25,0.3,0.4), return.img = TRUE)
# res
# display(res$img)


mins = c(0.1,0.25,0.25)
maxs = c(0.25,0.3,0.4)

selected <- list(NA,NA,NA)
for(rgb.channel in 1:3){
  # rgb.channel <- 1
  # rgb.channel <- 2
  # rgb.channel <- 3
  
  cat("Hola1\n")
  mono.img <- EBImage::channel(x = img[,,rgb.channel],mode = "gray")
  # display(mono.img)
  # display(mono.img >= topleft.min[rgb.channel])
  # display(mono.img <= topleft.max[rgb.channel])
  # 
  # display(mono.img >= 0.3)
  # display(mono.img <= 0.5)
  cat("Hola2\n")
  selected[[rgb.channel]] <- (mono.img >= mins[rgb.channel]) & (mono.img <= maxs[rgb.channel])
  # display(selected)
}
# Merge
selected <- selected[[1]] & selected[[2]] & selected[[3]]
display(selected)

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
res[["img"]] <- selected
res
display(res$img)



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
