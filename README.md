# Accelerated-globalSA-of-constraint-based-models
Accelerated global sensitivity analysis of genome-wide constraint-based metabolic models.

## Dependencies
An implementation of the Message Passing Interface (MPI) standard for running parallel applications.

## Example
Only matlab contraint-based models (.mat file extension) are supported.

Saltelli's scheme generates model parameterizations that are optimized using flux balance analysis:

<code>mpiexec -n <NUMBER_OF_LOGICAL_PROCESSORS> python saltelli_sample.py <MODEL_PATH> --num_samples <NUMBER_OF_SAMPLES></code>

Sobol sequence calculates sensitivity indices of target reactions:

<code>python sobol_analyze</code>
