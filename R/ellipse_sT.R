ellipse_sT <- function(center, shape, radius, log="", center.pch=19, center.cex=1.5, segments=51, draw=TRUE, add=draw, 
                    xlab="", ylab="", col=palette()[2], lwd=2, fill=FALSE, fill.alpha=0.3,
                    grid=TRUE, ...) {
  trans.colors <- function(col, alpha=0.5, names=NULL) {
    # this function by Michael Friendly
    nc <- length(col)
    na <- length(alpha)
    # make lengths conform, filling out to the longest
    if (nc != na) {
      col <- rep(col, length.out=max(nc,na))
      alpha <- rep(alpha, length.out=max(nc,na))
    }
    clr <-rbind(col2rgb(col)/255, alpha=alpha)
    col <- rgb(clr[1,], clr[2,], clr[3,], clr[4,], names=names)
    col
  }
  logged <- function(axis=c("x", "y")){
    axis <- match.arg(axis)
    0 != length(grep(axis, log))
  }
  if (! (is.vector(center) && 2==length(center))) stop("center must be a vector of length 2")
  if (! (is.matrix(shape) && all(2==dim(shape)))) stop("shape must be a 2 by 2 matrix")
  if (max(abs(shape - t(shape)))/max(abs(shape)) > 1e-10) stop("shape must be a symmetric matrix")
  angles <- (0:segments)*2*pi/segments 
  unit.circle <- cbind(cos(angles), sin(angles)) 
  #	ellipse <- t(center + radius*t(unit.circle %*% chol(shape,pivot=TRUE))) 
  Q <- chol(shape, pivot=TRUE)
  order <- order(attr(Q, "pivot"))
  ellipse <- t( center + radius*t( unit.circle %*% Q[,order]))
  colnames(ellipse) <- c("x", "y")
  if (logged("x")) ellipse[, "x"] <- exp(ellipse[, "x"])
  if (logged("y")) ellipse[, "y"] <- exp(ellipse[, "y"])
  fill.col <- trans.colors(col, fill.alpha)
  if (draw) {
    if (add) {
      lines(ellipse, col=col, lwd=lwd, ...) 
      if (fill) polygon(ellipse, col=fill.col, border=NA)
    }
    else {
      plot(ellipse, type="n", xlab = xlab, ylab = ylab, ...) 
      if(grid){
        grid(lty=1, equilogs=FALSE)
        box()}
      lines(ellipse, col=col, lwd=lwd, ... )
      if (fill) polygon(ellipse, col=fill.col, border=NA)
    } 	
    if ((center.pch != FALSE) && (!is.null(center.pch))) points(center[1], center[2], pch=center.pch, cex=center.cex, col=col)
  }
  invisible(ellipse)
}
