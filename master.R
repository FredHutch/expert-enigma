#!/usr/bin/env Rscript
library("Rmpi")
iterations=100000000

n=mpi.universe.size()-1
print(paste("universe is: ", n))

print(paste("starting ", n, " slaves"))
iters_per_slave <- ceiling(iterations/n)
print(paste("giving", iters_per_slave, "iterations per slave"))

print("creating mpi machine")
mpi.spawn.Rslaves(nslaves=n)

print("broadcasting iters_per_slave")
mpi.bcast(iters_per_slave,1)
print("broadcasting command")
#mpi.bcast.cmd(source('./pi_sim.R'))
print("exec-ing command")
results <- mpi.remote.exec(sim.pi(), ret=TRUE)

print("Done")

mpi.close.Rslaves()
mpi.quit()
