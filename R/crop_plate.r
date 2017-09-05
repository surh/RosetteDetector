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
#' @param img Image object. Recommended to use EBImage objects, but any 3-dimensional
#' matrix would work
#' @param points A list containing topleft, topright, bottomleft, and bottomright entries.
#' Each entry must be a names numeric vector of length two with elements "m.cy" and "m.cy",
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
  
  col.grid <- get_one_grid_dim(A = points$topleft, B = points$topright, n = cols)
  row.grid <- get_one_grid_dim(A = points$topleft, B = points$bottomleft, n = rows)
  
  Res <- NULL
  Wells <- list()
  for(col_i in 1:cols){
    # col_i <- 1
    for(row_i in 1:rows){
      # row_i <- 1
      
      # This can be used to then call the adjust_square function and adjust the well size
      A <- c(col.grid[col_i, "m.cx"], row.grid[row_i, "m.cy"])
      B <- c(col.grid[col_i + 1, "m.cx"], row.grid[row_i, "m.cy"])
      C <- c(col.grid[col_i, "m.cx"], row.grid[row_i + 1, "m.cy"])
      D <- c(col.grid[col_i + 1, "m.cx"], row.grid[row_i + 1, "m.cy"])
      
      if(adjust.cell != 0){
        new.points <- adjust_rectangle(points = list(topleft = A,
                                                     topright = B,
                                                     bottomleft = C,
                                                     bottomright = D),
                                       v = adjust.cell,
                                       h = adjust.cell)
        A <- new.points$topleft
        B <- new.points$topright
        C <- new.points$bottomleft
        D <- new.points$bottomright
      }
      
      # well <- img[ round(A["m.cx"]):round(B["m.cx"]),
      #              round(A["m.cy"]):round(C["m.cy"]),  ]
      well <- img[ max(1,round(A["m.cx"])):min(dim(img)[1],round(B["m.cx"])),
                   max(1,round(A["m.cy"])):min(dim(img)[2],round(C["m.cy"])),  ]
      
      # display(well)
      
      
      filename <- paste(prefix,"col",col_i,".row",row_i,".jpeg",sep="")
      writeImage(well, filename)
      res <- data.frame(Col = col_i, Row = row_i, File = filename)
      Res <- rbind(Res,res)
      if(return.images){
        Wells[[(col_i -1) * rows + row_i]] <- well 
      }
    }
  }
  if(return.images)
    Res <- list(Files = Res, Wells = Wells)
  
  return(Res)
}

#' Get one dimension on grid
#' 
#' Takes points defining a segment. And returns a set of n
#' points along that segment that divide the segment in 
#' n-1 equal length segments
#' 
#' Internal
#' 
#' @param A,B point coordinates degfininf the original segment.
#' Must be named vectors with entries named "m.cx" and "m.cy" for
#' x and y coordinates
#' @param n Number of points along the segment to return.
#' 
#' @return A matrix containing the coordinates of the n points
#' 
#' @author Sur Herrera Paredes
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
  
  res <- cbind(m.cx = grid.x, m.cy = grid.y)
  
  return(res)
}