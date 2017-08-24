#!/usr/bin/env Rscript
library("Rmpi")
source("./libhello.R")

n=mpi.universe.size() - 1
print(paste("universe is: ", n))
name='bob'

print("creating mpi machine")
mpi.spawn.Rslaves(nslaves=n)

print("broadcasting names")
mpi.bcast.Robj2slave(name)

print("broacasting functions")
mpi.bcast.Rfun2slave()

print("exec-ing command")
result <- mpi.remote.exec(hello(), ret=TRUE)

print(result)
print("Done")

mpi.close.Rslaves()
mpi.quit()
