#!/usr/bin/env Rscript
library("Rmpi")
source('./pi_sim.R')

iterations=100000

n=mpi.universe.size() - 1
print(paste("universe is: ", n))

print(paste("starting ", n, " slaves"))
iters_per_slave <- ceiling(iterations/n)
print(paste("giving", iters_per_slave, "iterations per slave"))

print("creating mpi machine")
mpi.spawn.Rslaves(nslaves=n)

print("broadcasting iters_per_slave")
mpi.bcast(iters_per_slave,1)

print("broadcasting functions")
mpi.bcast.Rfun2slave()

print("exec-ing command")
results <- mpi.remote.exec(sim.pi(), ret=TRUE)

print(paste("pi is:", 4/(iterations/Reduce("+", results))))
print("Done")

mpi.close.Rslaves()
mpi.quit()
