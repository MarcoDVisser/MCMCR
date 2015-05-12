MCMCR (0.1)
=====

Markov Chain Monte Carlo algorithms and rejection sampling in R. MCMCR provides general-purpose MCMC algorithms for use in R. Algorithms will be optimized for speed and efficiency in general use as this packages continues to develop.

## Installation

Currently there isn't a release on [CRAN](http://cran.r-project.org/),
though one day, when I am statisfied with the optimizations, there may be.
You can still  download the [zip](https://github.com/MarcoDVisser/choosecolor/zipball/master) or [tar ball](https://github.com/MarcoDVisser/choosecolor/tarball/master).
Then decompress and run `R CMD INSTALL` on it, 
or use the **devtools** package to install the development version.

```r
## Make sure your current packages are up to date
update.packages()
## devtools is required
library(devtools)
install_github("MCMCR", "MarcoDVisser")
```

## Examples

```r
 require(MCMCR)

 priors<-function(a){
 a[1]<-runif(1,-1000,1000)
 a[2]<-runif(1,0,1000)
 return(a)
 }

 LL<-function(a,dat){
  dnorm(dat,a[1],a[2],log=TRUE)
 }


 dat<-rnorm(100,20,220)
 results<-rs(dat,c(1,1),LL,priors,N=1000)
 
  
```

** Package is being tested.. more to follow **


