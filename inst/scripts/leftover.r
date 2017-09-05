img_file1 <- system.file("images","example1.jpeg", package = "RosetteDetector", mustWork = TRUE)
img_file2 <- base::system.file("images","example2.jpeg", package = "RosetteDetector", mustWork = TRUE)
img1 <- readImage(img_file1)
img2 <- readImage(img_file2)

display(img1)
display(sqrt(img1))
display(log(img1) + 1)

display(img1[,,3])
display(img2[,,3])

display(sqrt(img1[,,2]))
display(sqrt(img2[,,2]))

display(log(img1[,,3]) + 1)
display(log(img2[,,3]) + 1)

display(log(img1[,,1]+ 1))
display(log(img2[,,1]+ 1))

# This finds top left
res <- find_sticker(img = log(img1) + 1, mins = c(0.0,0.20,0.25), maxs = c(0.25,0.3,0.4),
                    return.img = TRUE, show.steps = TRUE)
display(res$img)

res <- find_sticker(img = log(img2) + 1, mins = c(0.0,0.20,0.25), maxs = c(0.25,0.3,0.4),
                    return.img = TRUE, show.steps = TRUE)

display(res$img)


# This finds top right
res <- find_sticker(img = log(img1) + 1, mins = c(0.0,-0.7,0.0), maxs = c(0.15,-0.2,0.2),
                    return.img = TRUE, show.steps = TRUE)
display(res$img)

res <- find_sticker(img = log(img2) + 1, mins = c(0.0,-0.7,0.0), maxs = c(0.15,-0.2,0.2),
                    return.img = TRUE, show.steps = TRUE)
res
display(res$img)


# This finds bottom left
res <- find_sticker(img = log(img1) + 1, mins = c(0.1,-0.2,-0.2), maxs = c(0.4,0.1,0.1),
                    return.img = TRUE, show.steps = TRUE)
display(res$img)

res <- find_sticker(img = log(img2) + 1, mins = c(0.1,-0.2,-0.2), maxs = c(0.4,0.1,0.1), return.img = TRUE)
display(res$img)
