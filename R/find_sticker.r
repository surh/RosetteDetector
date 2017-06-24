

img_file <- base::system.file("images","example1.jpeg", package = "RosetteDetector", mustWork = TRUE)
topleft.min <- c(0,0.2,0.3)
topleft.max <- c(0.15,0.3,0.5)




img <- EBImage::channel(x = EBImage::readImage(img_file),mode = "rgb")
display(img)
dim(img)
img_size <- dim(img)[1:2]

display(img[,,1])
display(img[,,2])
display(img[,,3])

for(rgb.channel in 1:3){
  rgb.channel <- 1
  rgb.channel <- 2
  rgb.channel <- 3
  
  mono.img <- channel(x = img[,,rgb.channel],mode = "gray")
  display(mono.img)
  # display(mono.img >= topleft.min[rgb.channel])
  # display(mono.img <= topleft.max[rgb.channel])
  # 
  # display(mono.img >= 0.3)
  # display(mono.img <= 0.5)

  selected <- (mono.img >= topleft.min[rgb.channel]) & (mono.img <= topleft.max[rgb.channel])
  display(selected)
  
  # Segment and pick biggest
  selected <- EBImage::bwlabel(selected)
  sizes <- table(selected)
  sizes <- sizes[ -which(names(sizes) == "0") ] 
  sizes <- sort(sizes, decreasing = TRUE)
  spot <- as.numeric(names(sizes[1]))
  selected[ selected != spot ] <- 0
  display(selected)
  
}

selected <- (img >= topleft.min) & (img <= topleft.max)
display(selected)
display(selected[,,1])
display(selected[,,2])
display(selected[,,3])

display((img >= topleft.min)[,,3])
