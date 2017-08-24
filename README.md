# Breaking things with R

These two "master" examples demonstrate a difference in
behavior when using `mpi.bcast()` and `mpi.bcast.Robj2slave()`
functions.  The former causes the script to hang with slaves
running at 100%.  The latter seems to work.

## to run:

Start an interactive job on multiple nodes:

    srun -N 4 -n 4 --pty /bin/bash -i

Load R (3.3.3) via `ml`

    ml R

Run `master.R` via `mpirun`:

```
gizmof2[~/Work/]: mpirun -n 1 ./master.R 
[1] "universe is:  4"
[1] "starting  4  slaves"
[1] "giving 25000 iterations per slave"
[1] "creating mpi machine"
  4 slaves are spawned successfully. 0 failed.
master (rank 0, comm 1) of size 5 is running on: gizmof2 
slave1 (rank 1, comm 1) of size 5 is running on: gizmof3 
slave2 (rank 2, comm 1) of size 5 is running on: gizmof4 
slave3 (rank 3, comm 1) of size 5 is running on: gizmof5 
slave4 (rank 4, comm 1) of size 5 is running on: gizmof6 
[1] "broadcasting iters_per_slave"
[1] "broadcasting functions"
[1] "exec-ing command"
[1] "pi is: 3.14192"
[1] "Done"
[1] 1
```

This works.  The broken one is run similarly, but you will
see different behavior:

```
gizmof2[~/Work/]: mpirun -n 1 ./master-broken.R 
[1] "universe is:  4"
[1] "starting  4  slaves"
[1] "giving 25000 iterations per slave"
[1] "creating mpi machine"
  4 slaves are spawned successfully. 0 failed.
master (rank 0, comm 1) of size 5 is running on: gizmof2 
slave1 (rank 1, comm 1) of size 5 is running on: gizmof3 
slave2 (rank 2, comm 1) of size 5 is running on: gizmof4 
slave3 (rank 3, comm 1) of size 5 is running on: gizmof5 
slave4 (rank 4, comm 1) of size 5 is running on: gizmof6 
[1] "broadcasting iters_per_slave"
[1] 25000
[1] "broadcasting functions"
[1] "exec-ing command"
```

The job will hang at this point.  If you check the slaves you
will see `R` processes running at 100%.  The intermediate log
files produced by `rmpi` will only show:

```
gizmof2[~/Work/]: cat gizmof5.8740+1.3709.log 
  Host: gizmof5   Rank(ID): 3   of Size: 5 on comm 1 
```

Two `^C` in succession will kill the job

