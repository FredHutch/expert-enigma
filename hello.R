#!/usr/bin/env Rscript
library("Rmpi")

n=mpi.universe.size() - 1
print(paste("universe is: ", n))

print("creating mpi machine")
mpi.spawn.Rslaves(nslaves=n)

mpi.bcast.cmd(cmd=source("./libhello.R"))
print("exec-ing command")
mpi.remote.exec(hello(), ret=TRUE)

print("Done")

mpi.close.Rslaves()
mpi.quit()
