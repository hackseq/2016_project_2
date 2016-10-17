# Description of the foward finite-difference "algorithm".
from opal.core.algorithm import Algorithm
from opal.core.parameter import Parameter
from opal.core.measure   import Measure

# Define Algorithm object.
AB = Algorithm(name='AB', description='ABySS')

# Register executable command.
AB.set_executable_command('python abyss_run.py')

# Define parameter and register it with algorithm.
k = Parameter(kind='integer', default=30, bound=(16, 48),
              name='k', description='Step size')
AB.add_param(k)

# Define relevant measure and register with algorithm.
n50 = Measure(kind='integer', name='N50', description='N50 value')
AB.add_measure(n50)

#error = Measure(kind='real', name='ERROR', description='Error in derivative')
#AB.add_measure(error)

