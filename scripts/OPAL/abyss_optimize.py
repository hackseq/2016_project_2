# Define a parameter optimization problem in relation to ABySS
from opal import ModelStructure, ModelData, Model
from opal.Solvers import NOMAD

from abyss_declaration import AB

# Return the max measure.
def get_max(parameters, measures):
    return max(measures["N50"])

# Define parameter optimization problem.
data = ModelData(AB)
struct = ModelStructure(objective=get_max)  # Unconstrained
model = Model(modelData=data, modelStructure=struct)

# Solve parameter optimization problem.
#NOMAD.set_parameter(name='DISPLAY_STATS',
#                    value='%3dBBE  %7.1eSOL  %8.3eOBJ  %5.2fTIME')
NOMAD.solve(blackbox=model)

#print max(measures["N50"])
#print 'Optimal value is approximately %21.15e' % float(get_max)