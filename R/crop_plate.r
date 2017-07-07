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
#' Crops plate
#' 
#' @export
crop_plate <- function(img,points,cols = 4,rows = 3,prefix = "",
                       col.resize = 1, row.resize = 1.2){

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
  
  # Move points
  col.borders <- seq(from = points$topleft["m.cx"],to = points$topright["m.cx"],length.out = cols + 1)
  row.borders <- seq(from = points$topleft["m.cy"],to = points$bottomleft["m.cy"],length.out = rows + 1)
  col.borders <- round(col.borders)
  row.borders <- round(row.borders)
  
  Res <- NULL
  for(col_i in 1:cols){
    #col_i <- 1
    for(row_i in 1:rows){
      #row_i <- 1
      well <- img[col.borders[col_i]:col.borders[col_i+1], row.borders[row_i]:row.borders[row_i+1],  ]
      filename <- paste(prefix,"col",col_i,".row",row_i,".jpeg",sep="")
      writeImage(well, filename)
      res <- data.frame(Col = col_i, Row = row_i, File = filename)
      Res <- rbind(Res,res)
    }
  }
  return(Res)
}