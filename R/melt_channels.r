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

melt_channels <- function(x,varnames=c("R","G","B")){
  #   x <- pot1
  #   varnames <- c("R","G","B") 
  x.molten <- melt(x[,,1])
  temp <- melt(x[,,2])
  x.molten$value2 <- temp$value
  temp <- melt(x[,,3])
  x.molten$value3 <- temp$value
  colnames(x.molten)[3:5] <- varnames
  return(x.molten)
}

