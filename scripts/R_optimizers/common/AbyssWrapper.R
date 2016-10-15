library("readr")
library("testthat")

#' Runs Abyss
#'
#' Runs abyss with the specified parameters.
#' @param input     Path to the input fastq files seperated by space
#' @param name      The name of this assembly
#' @param k         size of a single k-mer in a k-mer pair (bp)
#' @export
runAbyss<-function(input, name, k) {
    outdir = paste(name, "_abyss_k", k, sep="")
    dir.create(file.path(".", "runs"), showWarnings = FALSE)
    dir.create(file.path("runs", outdir), showWarnings = FALSE)
    outdir <- paste("runs/", outdir, sep="")

    cmd <- paste("abyss-pe",
                 " -C ", outdir,
                 " k=", k,
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
        return()
    }

    stats <- read_csv(paste(outdir, "/", name, "-stats.csv", sep=""))
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
    return(stats[[which(stats$name=="test-scaffolds.fa"), "N50"]])
}

runAbyssTest(k=32)


