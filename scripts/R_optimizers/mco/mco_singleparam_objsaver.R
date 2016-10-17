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

#1 input, 1 output
k_n50_fit = nsga2(Abyss_n50,idim=1,odim=1,lower.bounds=c(inparam$min), upper.bounds=c(inparam$max),popsize=getpoprange(inparam), generations=100,  mprob=0.01, cprob=0.2)
#SAVE OBJ
save(k_n50_fit, list=character(), file=paste(getwd(), "/scripts/R_optimizers/mco/interm_objs/","k_n50_fit.obj",sep=""))
 
##To load, load(blah_address)

k_n50_l50_fit = nsga2(Abyss_n50_l50,idim=1,odim=2,lower.bounds=c(inparam$min), upper.bounds=c(inparam$max),popsize=getpoprange(inparam), generations=100,mprob = 0.01,cprob=0.2)

save(k_n50_l50_fit, list=character(), file=paste(getwd(), "/scripts/R_optimizers/mco/interm_objs/","k_n50_l50_fit.obj",sep=""))

