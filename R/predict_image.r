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

#' Predict image
#' 
#' Takes an image file and a trained SVM model and predicts every pixel
#' of the image.
#' 
#' @param picture filename of image to be analyzed
#' @param m1 Trained SVM model from e1071
#' @param size_threshold Minimum size in pixels that a feature must have to be kept
#' @param predict_class Name of the class to be predicted. Must match a class name
#' in \emph{m1}.
#' @param outmask Directory name where to save the masks resulting from the pipeline.
#' @param outoverlay Directory name where to save the overlay images.
#' 
#' @return Size of the found feature
#' 
#' @author Sur Herrera Paredes
#' 
#' @export
predict_image <- function(picture,m1,size_threshold=0,predict_class="plant",outmask = "outmask/",outoverlay = "outoverlay/"){
  #   picture <- pictures[1]
  #   size_threshold <- 0
  #   predict_class <- "plant"
  #   outmask <- "outmask/"
  #   outoverlay <- "outoverlay/"
  #   m1 <- m1.svm
  
  Img <- list(img = readImage(picture))
  Dat <- get_values(Img = Img)
  Dat$pred <- predict(m1,Dat)
  Dat$predn <- 0
  Dat$predn[ Dat$pred == predict_class ] <- 1
  
  Pred <- acast(Dat,Var1 ~ Var2,value.var="predn")
  Pred <- bwlabel(Pred)
  elements <- table(Pred)[-1]  
  elements <- elements > size_threshold
  elements <- names(elements)[elements]
  Pred[!(Pred %in% elements)] <- 0
  Pred <- fillHull(Pred)
  Disp <- paintObjects(Pred,Img$img,col="#ff00ff")
  writeImage(x=Disp,file=paste(outoverlay,basename(picture),sep="/"))
  writeImage(x=Pred,file=paste(outmask,basename(picture),sep="/"))
  
  total_size <- sum(Pred > 0)
  return(total_size)
}

