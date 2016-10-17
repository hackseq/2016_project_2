library("testthat")
s_default = 2 #Converts to 2 within functions
#' Runs Abyss
#'
#' Runs abyss with the specified parameters.
#' @param input     Path to the input fastq files seperated by space
#' @param name      The name of this assembly
#' @param k         size of a single k-mer in a k-mer pair (bp)
#' @export
runAbyss<-function(input, name, k, s=200, l=25) {
    outdir = paste(name, "_abyss_k", k, "_s",s, "_l", l, sep="")
    dir.create(file.path(".", "runs"), showWarnings = FALSE)
    dir.create(file.path("runs", outdir), showWarnings = FALSE)
    outdir <- paste("runs/", outdir, sep="")

    cmd <- paste("abyss-pe",
                 " -C ", outdir,
                 " k=", k,
                 " s=", s,
		 " l=", l,
                 " name=", name,
                 " in=\"", input, "\"",
                 sep = "")
    print("Running:")
    print(cmd)

    t1 <- try(system(cmd,
                     intern = TRUE,
                     #ignore.stderr = TRUE,
                     #ignore.stdout = TRUE
                     ),
              silent = TRUE)

    if (inherits(t1, "try-error") || !is.null(attr(t1,"status"))) {
        print("[FAILED]")
        return(NULL)
    }

    statsFilename = paste(outdir, "/", name, "-stats.csv", sep="")
    stats <<- read.csv(statsFilename)
    print(stats)
    print("[DONE]")
    return(stats)
}

#' Runs Abyss for the test data
#'
#' @param k size of a single k-mer in a k-mer pair (bp)
#' @export
runAbyssTest <- function(k) {
    stats <- runAbyss("$PWD/data/test-data/reads1.fastq $PWD/data/test-data/reads2.fastq",
             "test",
             k)
    if (is.null(stats)) {
        return(-1)
    }

    return(stats[[which(stats$name=="test-scaffolds.fa"), "N50"]])
    #L50 as the second metric (quality?)
}

#' Runs Abyss for the hsapiens chromosme 3 with 200k reads
#'
#' @param k size of a single k-mer in a k-mer pair (bp)
#' @export
runAbyss200k <- function(k) {
    stats <- runAbyss("$PWD/data/200k.fq",
                      "200k",
                      k)
    if (is.null(stats)) {
        return(-1)
    }
    return(stats[[which(stats$name=="200k-scaffolds.fa"), "N50"]])
}

#' Runs Abyss for the hsapiens chromosme 3 with 500k reads
#'
#' @param k size of a single k-mer in a k-mer pair (bp)
#' @export
runAbyss500k <- function(k) {
    stats <- runAbyss("$PWD/data/500k.fq",
                      "500k",
                      k)
    if (is.null(stats)) {
        return(-1)
    }
    return(stats[[which(stats$name=="500k-scaffolds.fa"), "N50"]])
}


#runAbyss200k(k=25)
##Since we don't want to test every plausible value of s, only multiples of 10^(something)
##We will 'rescale' the input s value
##Input s values of format m.nyz transforms into (100*m) + (10*n)
##Ex. s input 2.534 will convert to 250
stepadjust <- function(x){
	return(round(x,1)*100)	
}
##Define shared functions for k, s inputs and N50, L50 output calls
Abyss_n50 <- function(paramlist, infile="$PWD/data/200k.fq", outpref="200k", maximizer=-1){
	#paramlist=c(k,s,l)
	#maximizer= -1 when optimization function is a minimization function
	#maximizer=1 when optimization function is a maximization function
	k = round(paramlist[1])
	s = ifelse(length(paramlist)==1, s_default, round(paramlist[2]))
	s = stepadjust(s)
	l = ifelse(length(paramlist)<3, 25, round(paramlist[3]))
	#Launch Abyss with input params
	stats <- runAbyss(input=infile, name=outpref, k=k, s=s, l=l)
	if (is.null(stats)){
		return(-1)
	}
	#Need to fix this so name matching is for <whatever>-scaffolds.fa
	return(stats[[which(stats$name=="200k-scaffolds.fa"), "N50"]]*maximizer)
}

Abyss_n50_l50 <- function(paramlist, infile="$PWD/data/200k.fq", outpref="200k", maximizer=-1){
	#paramlist=c(k,s)
	#maximizer= -1 when optimization function is a minimization function
	#maximizer=1 when optimization function is a maximization function
        k = round(paramlist[1])
        s = ifelse(length(paramlist)==1, s_default, round(paramlist[2]))
	l = ifelse(length(paramlist)<3, 25, round(paramlist[3]))
        #Launch Abyss with input params
	s = stepadjust(s)
	stats <- runAbyss(input=infile, name=outpref, k=k, s=s, l=l)
	if (is.null(stats)){return(c(-1,1))} #This needs to be fixed later, nul
	#Need to fix this so name matching is for <whatever>-scaffolds.fa
	return(c(stats[[which(stats$name=="200k-scaffolds.fa"), "N50"]]*maximizer, stats[[which(stats$name=="200k-scaffolds.fa"), "L50"]] * maximizer * -1))
}

Abyss_n50_n <- function(paramlist, infile="$PWD/data/200k.fq", outpref="200k", maximizer=-1){
        #paramlist=c(k,s)
        #maximizer= -1 when optimization function is a minimization function
        #maximizer=1 when optimization function is a maximization function
        k = round(paramlist[1])
        s = ifelse(length(paramlist)==1, s_default, round(paramlist[2]))
	l = ifelse(length(paramlist)<3, 25, round(paramlist[3]))
	
        #Launch Abyss with input params
        s = stepadjust(s)
        stats <- runAbyss(input=infile, name=outpref, k=k, s=s, l=l)
        if (is.null(stats)){return(c(-1,1))}
        #Need to fix this so name matching is for <whatever>-scaffolds.fa
        return(c(stats[[which(stats$name=="200k-scaffolds.fa"), "N50"]]*maximizer, stats[[which(stats$name=="200k-scaffolds.fa"), "n"]] * maximizer))
}


