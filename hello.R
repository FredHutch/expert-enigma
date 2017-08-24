#!/usr/bin/env Rscript
library("Rmpi")
source("./libhello.R")

n=mpi.universe.size() - 1
print(paste("universe is: ", n))

print("creating mpi machine")
mpi.spawn.Rslaves(nslaves=n)

print("broacasting functions")
mpi.bcast.Rfun2slave()
print("exec-ing command")
mpi.remote.exec(hello(), ret=TRUE)

print("Done")

mpi.close.Rslaves()
mpi.quit()
