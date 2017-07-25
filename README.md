This set of MATLAB functions simulates diffusion-advection flow in a doubly-periodic domain ![](https://latex.codecogs.com/png.latex?%5Clarge%20%5B0%2C2%5Cpi%5D%5Ctimes%5B0%2C2%5Cpi%5D). The equation for the scalar field ![c(x,y,t)](https://latex.codecogs.com/png.latex?c%28x%2Cy%2Ct%29) is

![](https://latex.codecogs.com/png.latex?%5CLARGE%20%5Cfrac%7B%5Cpartial%20c%7D%7B%5Cpartial%20t%7D&plus;%5Cvec%20v%20%5Ccdot%5Cvec%5Cnabla%20c%3D%5Ceta%20%5Cnabla%20%5E2c)

where ![](https://latex.codecogs.com/png.latex?%5Clarge%20v) is independent of time and is divergence free. ![](https://latex.codecogs.com/png.latex?%5Clarge%20v) is calculated by the function `generate_v_field` and is a sum of terms of the form 

![](https://latex.codecogs.com/png.latex?%5ClargeE%20m%20%5Ccos%20%28%5Cbeta%20&plus;m%20y%29%20%5Ccos%20%28%5Calpha%20&plus;n%20x%29%20%5Chat%20%7B%5Cmathbf%20x%7D%20&plus;%20n%20%5Csin%20%28%5Cbeta%20&plus;m%20y%29%20%5Csin%20%28%5Calpha%20&plus;n%20x%29%5Chat%7B%5Cmathbf%20y%7D)

where `m` and `n` are random integers and ![c(x,y,t)](https://latex.codecogs.com/png.latex?\alpha,\beta) are random real numbers. 

The equations are solved by explicit finite differences conservative scheme. 

### Importnat functions
* `one_run` performs a single realization by generating a velocity field, integrating the equations, and returning the result
* `run_collect_save` is a script (not a function) to perform multiple runs with a given set of parameters and store the result in a handy `hdf5` file.
