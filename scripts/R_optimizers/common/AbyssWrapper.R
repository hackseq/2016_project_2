library("testthat")

#' Runs Abyss
#'
#' Runs abyss with the specified parameters.
#' @param input     Path to the input fastq files seperated by space
#' @param name      The name of this assembly
#' @param k         size of a single k-mer in a k-mer pair (bp)
#' @export
runAbyss<-function(input, name, k, s=1000) {
    outdir = paste(name, "_abyss_k", k, "_s",s, sep="")
    dir.create(file.path(".", "runs"), showWarnings = FALSE)
    dir.create(file.path("runs", outdir), showWarnings = FALSE)
    outdir <- paste("runs/", outdir, sep="")

    cmd <- paste("abyss-pe",
                 " -C ", outdir,
                 " k=", k,
                 " s=", s,
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

##Define shared functions for k, s inputs and N50, L50 output calls
Abyss_n50 <- function(paramlist, infile="$PWD/data/200k.fq", outpref="200k", maximizer=-1){
	#paramlist=c(k,s)
	#maximizer= -1 when optimization function is a minimization function
	#maximizer=1 when optimization function is a maximization function
	k = round(paramlist[1])
	s = ifelse(length(paramlist)==1, 1000, round(paramlist[2]))
	#Launch Abyss with input params
	stats <- runAbyss(input=infile, name=outpref, k=k, s=s)
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
        s = ifelse(length(paramlist)==1, 1000, round(paramlist[2]))
        #Launch Abyss with input params
	stats <- runAbyss(input=infile, name=outpref, k=k, s=s)
	if (is.null(stats)){return(-1)}
	#Need to fix this so name matching is for <whatever>-scaffolds.fa
	return(c(stats[[which(stats$name=="200k-scaffolds.fa"), "N50"]]*maximizer, stats[[which(stats$name=="200k-scaffolds.fa"), "L50"]] * maximizer))
}
