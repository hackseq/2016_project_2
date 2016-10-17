Abyss_wrapper.py uses a python system call to run Abyss. It parses the output to report the value of N50 (contiguity) on its own.

One can then use ParOpt to optimize k using a grid search - ParOpt will then tell you the optimum value, k.

using: [200k reads:](http://bit.ly/2edvq6T)

```
time ../ParOpt/popt --grid max '../ParOpt/Abyss_wrapper.py {0}' 'fx = (.*)' 30,45,1
    0 f(3.000e+01) = 8329.0
    1 f(3.100e+01) = 7900.0
    2 f(3.200e+01) = 8452.0
    3 f(3.300e+01) = 10592.0
    4 f(3.400e+01) = 8446.0
    5 f(3.500e+01) = 12504.0
    6 f(3.600e+01) = 10589.0
    7 f(3.700e+01) = 10731.0
    8 f(3.800e+01) = 10589.0
    9 f(3.900e+01) = 16452.0
   10 f(4.000e+01) = 15458.0
   11 f(4.100e+01) = 16451.0
   12 f(4.200e+01) = 8755.0
   13 f(4.300e+01) = 8756.0
   14 f(4.400e+01) = 7265.0
Finished optimization after 15 evaluations.
The optimal function value is -16452.000000000000000000000000000000
Optimal variables: 39

real	7m27.480s
user	9m6.533s
sys	0m12.301s
```

Subsequently I have updated the wrapper to optimise two variables simultaneously: k, s.
```
ubuntu@compute001:~/hackseq/ParOpt$ ./popt --grid max '../ParOpt/Abyss_wrapper.py {0} {1}' 'fx = (.*)' 30,46,2 200,1000,200
    0 f(3.000e+01, 2.000e+02) = 12281.0
    1 f(3.000e+01, 4.000e+02) = 10589.0
    2 f(3.000e+01, 6.000e+02) = 10589.0
    3 f(3.000e+01, 8.000e+02) = 8333.0
    4 f(3.200e+01, 2.000e+02) = 11404.0
    5 f(3.200e+01, 4.000e+02) = 10244.0
    6 f(3.200e+01, 6.000e+02) = 9891.0
    7 f(3.200e+01, 8.000e+02) = 8532.0
    8 f(3.400e+01, 2.000e+02) = 14620.0
    9 f(3.400e+01, 4.000e+02) = 12503.0
   10 f(3.400e+01, 6.000e+02) = 12470.0
   11 f(3.400e+01, 8.000e+02) = 8789.0
   12 f(3.600e+01, 2.000e+02) = 14620.0
   13 f(3.600e+01, 4.000e+02) = 12496.0
   14 f(3.600e+01, 6.000e+02) = 12496.0
   15 f(3.600e+01, 8.000e+02) = 10589.0
   16 f(3.800e+01, 2.000e+02) = 14619.0
   17 f(3.800e+01, 4.000e+02) = 12246.0
   18 f(3.800e+01, 6.000e+02) = 10958.0
   19 f(3.800e+01, 8.000e+02) = 9156.0
   20 f(4.000e+01, 2.000e+02) = 16454.0
   21 f(4.000e+01, 4.000e+02) = 16454.0
   22 f(4.000e+01, 6.000e+02) = 15458.0
   23 f(4.000e+01, 8.000e+02) = 15458.0
   24 f(4.200e+01, 2.000e+02) = 16451.0
   25 f(4.200e+01, 4.000e+02) = 16451.0
   26 f(4.200e+01, 6.000e+02) = 9222.0
   27 f(4.200e+01, 8.000e+02) = 9222.0
   28 f(4.400e+01, 2.000e+02) = 7900.0
   29 f(4.400e+01, 4.000e+02) = 7672.0
   30 f(4.400e+01, 6.000e+02) = 7672.0
   31 f(4.400e+01, 8.000e+02) = 7265.0
Finished optimization after 32 evaluations.
The optimal function value is 16454
Optimal variables: 40 200
```
Performing a second round grid search to try and improve k = k_opt - 1 and s_step=s_step-100
```
ubuntu@compute001:~/hackseq/ParOpt$ ./popt --grid max '../ParOpt/Abyss_wrapper.py {0} {1}' 'fx = (.*)' 39,41,1 100,1000,100
    0 f(3.900e+01, 1.000e+02) = 16452.0
    1 f(3.900e+01, 2.000e+02) = 16452.0
    2 f(3.900e+01, 3.000e+02) = 16452.0
    3 f(3.900e+01, 4.000e+02) = 16452.0
    4 f(3.900e+01, 5.000e+02) = 16452.0
    5 f(3.900e+01, 6.000e+02) = 16452.0
    6 f(3.900e+01, 7.000e+02) = 16452.0
    7 f(3.900e+01, 8.000e+02) = 16452.0
    8 f(3.900e+01, 9.000e+02) = 16452.0
    9 f(4.000e+01, 1.000e+02) = 16454.0
   10 f(4.000e+01, 2.000e+02) = 16454.0
   11 f(4.000e+01, 3.000e+02) = 16454.0
   12 f(4.000e+01, 4.000e+02) = 16454.0
   13 f(4.000e+01, 5.000e+02) = 15458.0
   14 f(4.000e+01, 6.000e+02) = 15458.0
   15 f(4.000e+01, 7.000e+02) = 15458.0
   16 f(4.000e+01, 8.000e+02) = 15458.0
   17 f(4.000e+01, 9.000e+02) = 15458.0
Finished optimization after 18 evaluations.
The optimal function value is 16454
Optimal variables: 40 100
```
