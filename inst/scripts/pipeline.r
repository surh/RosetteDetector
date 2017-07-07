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

image(img[,,1] >= 0)
p1 <- plotrix::draw.circle(x = res$bottomright["m.cx"],
                     y = dim(img)[2] - res$bottomright["m.cy"],
                     radius = sqrt(res$size / pi),
                     nv =200,border=NULL,col="yellow",lty=1,lwd=1)
p2 <- plotrix::draw.circle(x = res$topright["m.cx"],
                     y = dim(img)[2] - res$topright["m.cy"],
                     radius = sqrt(res$size / pi),
                     nv =200,border=NULL,col="magenta",lty=1,lwd=1)
p3 <- plotrix::draw.circle(x = res$topleft["m.cx"],
                     y = dim(img)[2] - res$topleft["m.cy"],
                     radius = sqrt(res$size / pi),
                     nv =200,border=NULL,col="blue",lty=1,lwd=1)
p4 <- plotrix::draw.circle(x = res$bottomleft["m.cx"],
                     y = dim(img)[2] - res$bottomleft["m.cy"],
                     radius = sqrt(res$size / pi),
                     nv =200,border=NULL,col="red",lty=1,lwd=1)


test <- img

test[ round(p1$x), round (p1$y) , 1:3] <- 1
display(img)



# library(raster)
# library(plotrix)
r1 <- raster::brick(system.file("external/rlogo.grd", package="raster"))
width <- 50
height <- 40
x <- raster::crop(r1, raster::extent(0,width,0,height))
raster::plotRGB(x)
circlex=20
circley=15
radius=10
plotrix::draw.circle(circlex,circley,radius,border="blue")



img.ras <- raster::brick(img * 255, xmn = 0, xmx = dim(img)[1], ymn = 0, ymx = dim(img)[2],
                         crs = "+proj=merc +datum=WGS84", transpose = TRUE)
img.ras
x
raster::plotRGB(img.ras)
p1 <- plotrix::draw.circle(x = res$bottomright["m.cx"],
                           y = dim(img)[2] - res$bottomright["m.cy"],
                           radius = sqrt(res$size / pi),
                           nv =200,border=NULL,col="yellow",lty=1,lwd=1)
p2 <- plotrix::draw.circle(x = res$topright["m.cx"],
                           y = dim(img)[2] - res$topright["m.cy"],
                           radius = sqrt(res$size / pi),
                           nv =200,border=NULL,col="magenta",lty=1,lwd=1)
p3 <- plotrix::draw.circle(x = res$topleft["m.cx"],
                           y = dim(img)[2] - res$topleft["m.cy"],
                           radius = sqrt(res$size / pi),
                           nv =200,border=NULL,col="blue",lty=1,lwd=1)
p4 <- plotrix::draw.circle(x = res$bottomleft["m.cx"],
                           y = dim(img)[2] - res$bottomleft["m.cy"],
                           radius = sqrt(res$size / pi),
                           nv =200,border=NULL,col="red",lty=1,lwd=1)
