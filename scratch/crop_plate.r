devtools::document()

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


stickers <- find_three_stickers(img = img)
stickers



