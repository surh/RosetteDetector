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

#' Crop plate
#' 
#' Crops plate into a grid
#' 
#' @param img Imge object. Recommended to use EBImage objects, but any 3-dimensional
#' matrix would work
#' @param points A list containing topleft, topright, bottomleft, and bottomright entries.
#' Each entry must be a names numeric vector of lecgth two with elements "m.cy" and "m.cy",
#' which correspond to the x and y coordinates of each point
#' @param cols,rows Number of columns and rows desired in the grid.
#' @param prefix String with file prefix to append to filenames of resulting grid files.
#' @param adjust.cell Number of pixels to increase every side of each cell rectangle.
#' @param col.resize,row.resize NOT IMPLEMENTED. Eventually allowing to 
#' @param return.images Logical indicating whether image objects should be returned for the grid.
#' Defaults to FALSE, which only generates output files.
#' 
#' @export
crop_plate <- function(img,points,cols = 4,rows = 3,prefix = "",
                       col.resize = 1, row.resize = 1.2, adjust.cell = 0,
                       return.images = FALSE){

  # Eventually I want to solve it with linear equations
  # origin <- points$topleft
  # end <- points$topright
  # 
  # slope.top <- (origin[ "m.cy" ] - end[ "m.cy" ]) /
  #   (origin[ "m.cx" ] - end[ "m.cx" ])
  # intercept.top <- points$topleft[ "m.cy" ] - slope.top * points$topleft[ "m.cx" ]
  # dist.top <- dist(rbind(points$topleft[ c("m.cx","m.cy")],points$topright[ c("m.cx","m.cy")]))
  # dis.target <- seq(from = 0, to = dist.top, length.out = cols)
  # 
  # # Numbers for quadratic general equation
  # a.quad <- 1 + slope.top^2
  # b.quad <- 2*(intercept.top*slope.top - origin["m.cx"] - origin["m.cy"]*slope.top)
  # c.quad <- intercept.top^2 - 2*origin["m.cy"]*intercept.top + sum(origin^2) + dis.target[2]^2
  # 
  # x.new <- (-b.quad + sqrt(b.quad^2 - 4*a.quad*c.quad)) / (2*a.quad)
  # y.new <- slope.top + intercept.top*x.new
  
  # points <- res.adj
  # cols <- 4
  # rows <- 3
  # adjust.cell <- 30
  
  col.grid <- get_one_grid_dim(A = points$topleft, B = points$topright, n = cols)
  row.grid <- get_one_grid_dim(A = points$topleft, B = points$bottomleft, n = rows)
  
  # # Move points
  # col.borders <- seq(from = points$topleft["m.cx"],to = points$topright["m.cx"],length.out = cols + 1)
  # row.borders <- seq(from = points$topleft["m.cy"],to = points$bottomleft["m.cy"],length.out = rows + 1)
  # col.borders <- round(col.borders)
  # row.borders <- round(row.borders)
  
  Res <- NULL
  Wells <- list()
  for(col_i in 1:cols){
    # col_i <- 2
    for(row_i in 1:rows){
      # row_i <- 2
      
      # A <- c(col.grid[col_i, "x"], row.grid[row_i, "y"])
      # B <- c(col.grid[col_i + 1, "x"], row.grid[row_i, "y"])
      # C <- c(col.grid[col_i, "x"], row.grid[row_i + 1, "y"])
      # D <- c(col.grid[col_i + 1, "x"], row.grid[row_i + 1, "y"])
      
      # # Adjust grid to make it square
      # A["y"] <- B["y"] <- round(min(A["y"],B["y"]))
      # C["y"] <- D["y"] <- round(max(C["x"],D["x"]))
      # A["x"] <- C["x"] <- round(min(A["x"],C["x"]))
      # B["x"] <- D["x"] <- round(max(B["x"],D["x"]))
      
      well <- img[ round(col.grid[col_i, "x"]):round(col.grid[col_i + 1, "x"]),
                   round(row.grid[row_i, "y"]):round(row.grid[row_i + 1, "y"]),  ]
      # display(well)
      
      filename <- paste(prefix,"col",col_i,".row",row_i,".jpeg",sep="")
      writeImage(well, filename)
      res <- data.frame(Col = col_i, Row = row_i, File = filename)
      Res <- rbind(Res,res)
      if(return.images){
        Wells[[cols * rows]] <- well 
      }
    }
  }
  if(return.images)
    Res <- list(Files = Res, Wells = Wells)
  
  return(Res)
}

#' Get onne dimension on grid
#' 
#' Internal
get_one_grid_dim <- function(A,B,n) {
  
  x1 <- y1 <- x2 <- y2 <- NULL
  
  x1 <- A["m.cx"]
  y1 <- A["m.cy"]
  x2 <- B["m.cx"]
  y2 <- B["m.cy"]
  
  if(is.null(x1) || is.null(x2) || is.null(y1) || is.null(y2))
    stop("ERROR: some coordinates missing",call. = TRUE)
  
  delta.x <- (x2 - x1) / sqrt((x2-x1)^2 + (y2-y1)^2)
  delta.y <- (y2 - y1) / sqrt((x2-x1)^2 + (y2-y1)^2)
  dis <- dist(rbind(A[ c("m.cx","m.cy")],B[ c("m.cx","m.cy")]))
  dis.delta <- seq(from = 0, to = dis, length.out = n + 1)
  
  grid.x <- x1 + dis.delta * delta.x
  grid.y <- y1 + dis.delta * delta.y
  
  res <- cbind(x = grid.x, y = grid.y)
  
  return(res)
}