library(RosetteDetector)

img_file <- base::system.file("images","example1.jpeg", package = "RosetteDetector", mustWork = TRUE)
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

res <- find_fourth_point(x = res)
res

plot_platecrop(img,res)

dir.create("output")
files <- crop_plate(img,res,prefix="output/example1.")

data("m1_20141021tiny")
sizes <- wrapper_predictdir_9feat(img_dir = "output/",overlaydir = "overlay",maskdir = "mask",m1 = m1)
sizes$Normalized.size <- sizes$npixels / res$size
sizes

mask <- readImage("mask/example1.col2.row1.jpeg")
display(mask)

# # To generate combinations
# rows <- c(10,20,30)
# cols <- c(40,80,120,160)
# expand.grid(rows = rows, cols = cols)
