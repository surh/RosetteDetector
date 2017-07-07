library(RosetteDetector)



mat <- matrix(0,nrow = 1000, ncol = 1000)

set.seed(3)
x <- round(100*rnorm(100)) + 500
y <- round(100*rnorm(100)) + 500
mat[ x, y ] <- 1
image(mat)

plot(x,y)
hpts <- chull(x,y)
hpts <- c(hpts, hpts[1])
lines(x[hpts],y[hpts])


chull(x,y)


find_object_points <- function(x){
  x <- mat
  dims <- dim(x)
  dims
  
  object <- which(x > 0)
  object
}



X <- matrix(stats::rnorm(2000), ncol = 2)
image(X)
chull(X)
## Not run: 
# Example usage from graphics package
plot(X, cex = 0.5)
hpts <- chull(X)
hpts <- c(hpts, hpts[1])
lines(X[hpts, ])

## End(Not run)


