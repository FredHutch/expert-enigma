
hello <- function(){
    paste(
      "I am",mpi.comm.rank(),
      "of",mpi.comm.size(),
      "on host", Sys.info()[c("nodename")]
    )
    return(1)
}
