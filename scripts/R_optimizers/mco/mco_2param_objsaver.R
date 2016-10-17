library("mco")

print(getwd())
source(paste(getwd(), "scripts/R_optimizers/common/AbyssWrapper.R", sep="/"))

library("rjson")
json_file <- paste(getwd(), "scripts/R_optimizers/common/config.json", sep="/")
json_data <- fromJSON(paste(readLines(json_file), collapse=""))
params = json_data$variables
#By default, if there is an integer ranged parameter, we will initialize the genetic algorithm population to half the size of the range of this parameter
#If parameter is float, genetic algorithm population will be set by default to the range to the parameter
getpoprange <- function(x){ifelse(x$type=="INT",(round((x$max-x$min)/2) - (round((x$max-x$min)/2) %% 4)), ((x$max-x$min) - ((x$max-x$min) %% 4)))}

inparam=params$k
inparam1 = params$k
inparam2 = params$s
inparam3 = params$l

##Call GA algorithm (two param fit)
#2 inputs, 1-2 outputs
ks_n50_fit = nsga2(Abyss_n50,idim=2,odim=1,lower.bounds=c(inparam1$min, inparam2$min), upper.bounds=c(inparam1$max, inparam2$max),popsize=max(getpoprange(inparam1), getpoprange(inparam2)), generations=100, mprob=0.01, cprob=0.2) 

save(ks_n50_fit, list=character(), file=paste(getwd(), "/scripts/R_optimizers/mco/interm_objs/","ks_n50_fit.obj",sep=""))

ks_n50_l50_fit = nsga2(Abyss_n50_l50,idim=2,odim=2,lower.bounds=c(inparam1$min, inparam2$min), upper.bounds=c(inparam1$max, inparam2$max),popsize=max(getpoprange(inparam1), getpoprange(inparam2)), generations=100,mprob = 0.01,cprob=0.2)

save(ks_n50_l50_fit, list=character(), file=paste(getwd(), "/scripts/R_optimizers/mco/interm_objs/","ks_n50_l50_fit.obj",sep=""))

#3 inputs, 1-2 outputs
#ksl_n50_fit = nsga2(Abyss_n50,idim=3,odim=1,lower.bounds=c(inparam1$min, inparam2$min, inparam3$min), upper.bounds=c(inparam1$max, inparam2$max, inparam3$max),popsize=max(getpoprange(inparam1), getpoprange(inparam2), getpoprange(inparam3)), generations=100, mprob=0.01, cprob=0.2)

#save(ksl_n50_fit, list=character(), file=paste(getwd(), "/scripts/R_optimizers/mco/interm_objs/","ksl_n50_fit.obj",sep=""))
 
#ksl_n50_l50_fit = nsga2(Abyss_n50_l50,idim=3,odim=2,lower.bounds=c(inparam1$min, inparam2$min, inparam3$min), upper.bounds=c(inparam1$max, inparam2$max, inparam3$max),popsize=max(getpoprange(inparam1), getpoprange(inparam2), getpoprange(inparam3)), generations=100,mprob = 0.01,cprob=0.2)

#save(ksl_n50_l50_fit, list=character(), file=paste(getwd(), "/scripts/R_optimizers/mco/interm_objs/","ksl_n50_l50_fit.obj",sep=""))
