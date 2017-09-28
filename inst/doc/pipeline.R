## ----setup, echo=FALSE---------------------------------------------------
library(knitr)
options(EBImage.display = "raster")
.dpi = 100
opts_chunk$set(fig.align="center", dpi=.dpi)

## ----load----------------------------------------------------------------
library(RosetteDetector)
library(ggplot2)
img_file <- system.file("images","example1.jpeg", package = "RosetteDetector", mustWork = TRUE)
img <- readImage(img_file)

## ----display, fig.width=dim(img)[1L]/.dpi, fig.height=dim(img)[2L]/.dpi, dpi=.dpi/2----
display(img)

## ----findstickers--------------------------------------------------------
# Find rectangle
res <- find_three_stickers(img = img,
                    topleft.min = c(0.1, 0.25, 0.25), topleft.max = c(0.25, 0.3, 0.4),
                    topright.min = c(0.1, 0, 0.1), topright.max = c(0.2, 0.15, 0.3),
                    bottomleft.min = c(0.2, 0.1, 0.1), bottomleft.max = c(0.4, 0.2, 0.2))

## ----four_cornes, fig.width=dim(img)[1L]/.dpi, fig.height=dim(img)[2L]/.dpi, dpi=.dpi/2----
res <- find_fourth_point(x = res)
plot_platecrop(img,res)

## ----adjust,fig.width=dim(img)[1L]/.dpi, fig.height=dim(img)[2L]/.dpi, dpi=.dpi/2----
# Adjust coordinates of rectangle
res.adj <- adjust_rectangle(points = res, v = 30, h = 0)
plot_platecrop(img,res.adj)

## ----crop----------------------------------------------------------------
# Crop image
dir.create("output")
crop <- crop_plate(img,res.adj,prefix="output/example1.",
                   cols = 4, rows = 3,return.images = TRUE,
                   adjust.cell = 10)

## ----well, fig.width=dim(img)[1L]/.dpi, fig.height=dim(img)[2L]/.dpi, dpi=.dpi/2----
display(crop$Wells[[12]])

## ----loadm1--------------------------------------------------------------
data("m1_20141021tiny")

## ----predict-------------------------------------------------------------
sizes <- wrapper_predictdir_9feat(img_dir = "output/",overlaydir = "overlay",maskdir = "mask",m1 = m1)

## ----format--------------------------------------------------------------
row.names(sizes) <- NULL
sizes$Normalized.size <- sizes$npixels / res.adj$size
sizes

## ----hull----------------------------------------------------------------
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
sizes

## ----metadata------------------------------------------------------------
# Some manual plot
sizes$Type <- c(rep("dead",3),rep("+Bacteria",6),rep("No Bacteria",3))

## ----descriptive---------------------------------------------------------
p1 <- ggplot(sizes,aes(x = Normalized.hull.area, y = Normalized.size, col = Type)) +
  geom_point(size = 3) + 
  theme(panel.background = element_blank(),
        axis.text = element_text(color = "black"),
        axis.title = element_text(color = "black", face = "bold"),
        panel.border = element_rect(color = "black", fill = NA, size = 2))
p1
p2 <- ggplot(sizes,aes(x = Type, y = Normalized.hull.area, col = Type)) +
  geom_point(size = 3) +
  theme(panel.background = element_blank(),
        axis.text.y = element_text(color = "black"),
        axis.text.x = element_blank(),
        axis.title = element_text(color = "black", face = "bold"),
        panel.border = element_rect(color = "black", fill = NA, size = 2))
p2

