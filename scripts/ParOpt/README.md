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

Next steps:
- Skip the Nelder–Mead algorithm as is not good for this type of problem (integer based - non-convex).
- For each value of k tested - output contiguity vs k and completeness metrics. Plot.
