##' Metropolis-Hastings MCMC sampling
##'
##' Simple protocol for a MCMC sampling algorithm.
##' Given a set of priors, and a likelihood function, the algorithm
##' samples new values for N parameters from a standard normal with
##' a jump variance that is automatically adjusted. The algoritm
##' accepts new proposal proportional to a random fraction.
##'
##' @param dat dataset to be based to the likelihood function
##' @param start a vector of starting values
##' @param LL a likelihood function that accepts the parameters and data
##' @param priors functions that give the prior probability 
##' for the parameter
##' @param N total number of sampling rounds (one rounds goes through
##' all parameters once).
##' @param giveup after how many rounds of no new accepted values
##' does the algorithm give up and assume convergence?
##' @author Marco D. Visser
##'
##' @export
mh <- function(dat,start,LL,priors,N,giveup = 100){

  accept.hist <- array(dim=c(N,length(start)))
  
  ## create progress bar
  pb <- txtProgressBar(min = 0, max = N, style = 3)
  accepts <- start
  
  for (j in 1:N){
    
  proposals <- priors(start)
  proposal <- accepts

  ## Acceptance prob on log scale
  ## randomly reverse sequence 
  if(runif(1)<=.5) {seq <- 1:length(proposals)} else
    {seq <- length(proposals):1}
  
  for(i in seq){
    proposal[i] <- proposals[i]
  r <- (sum(LL(proposal,dat)-
            LL(accepts,dat)))

  if (log(runif(1))<r) {
    accepts[i] <- proposal[i]
    A <- j
  }
  }
  
  accept.hist[j,] <- accepts

  if(giveup < (A - j)){
  message("Acceptance dropped to giveup value")  
  close(pb)
  return(accept.hist[1:j,])
  }

  setTxtProgressBar(pb, j)

}
  
  close(pb)
  return(accept.hist)
}
 
