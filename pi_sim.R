#!/usr/bin/env Rscript

sim.pi <- function() {
    iterations = iters_per_slave
    x.pos <- runif(iterations, min=-1, max=1)
    y.pos <- runif(iterations, min=-1, max=1)
    # Test if draws are inside the unit circle
    draw.pos <- ifelse(x.pos^2 + y.pos^2 <= 1, TRUE, FALSE)
    draws.in <- length(which(draw.pos == TRUE))
    return(draws.in)
}
