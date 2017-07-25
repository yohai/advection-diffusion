This set of MATLAB functions simulates diffusion-advection flow in a doubly-periodic domain ![](https://latex.codecogs.com/png.latex?%20%5B0%2C2%5Cpi%5D%5Ctimes%5B0%2C2%5Cpi%5D). The equation for the scalar field ![c(x,y,t)](https://latex.codecogs.com/png.latex?c%28x%2Cy%2Ct%29) is

![](https://latex.codecogs.com/png.latex?%5CLARGE%20%5Cfrac%7B%5Cpartial%20c%7D%7B%5Cpartial%20t%7D&plus;%5Cvec%20v%20%5Ccdot%5Cvec%5Cnabla%20c%3D%5Ceta%20%5Cnabla%20%5E2c)

where ![](https://latex.codecogs.com/png.latex?%5Clarge%20v) is independent of time and is divergence free. ![](https://latex.codecogs.com/png.latex?%5Clarge%20v) is calculated by the function `generate_v_field` and is a sum of terms of the form

![](https://latex.codecogs.com/png.latex?%5ClargeE%20m%20%5Ccos%20%28%5Cbeta%20&plus;m%20y%29%20%5Ccos%20%28%5Calpha%20&plus;n%20x%29%20%5Chat%20%7B%5Cmathbf%20x%7D%20&plus;%20n%20%5Csin%20%28%5Cbeta%20&plus;m%20y%29%20%5Csin%20%28%5Calpha%20&plus;n%20x%29%5Chat%7B%5Cmathbf%20y%7D)

where `m` and `n` are random integers and ![](https://latex.codecogs.com/png.latex?\alpha,\beta) are random real numbers.

The equations are solved by explicit finite differences conservative scheme. `one_run` performs a single realization by generating a velocity field, integrating the equations, and returning the result. `run_collect_save` is a script (not a function) to perform multiple runs with a given set of parameters and store the result in a handy `hdf5` file.

`convert_to_single.py` contains a useful python function that converts an `h5` file created by `run_collect_save` to a file with identical data but in `float16` precision, which makes it more manageable.

### Structure of the `hdf5` files
The file produced by `run_collect_save` have this format:
* The name of the file is the value of ![](https://latex.codecogs.com/png.latex?\eta)
* `/t` is the list of times for which the solutions are calculated (uniformly spaced)
* `/x` and `/y` are matrices of shape `[n,n]` with the `x` and `y` coordinates of the finite-differences grid for ![](https://latex.codecogs.com/png.latex?c%28x%2Cy%2Ct%29)
* Each file contains 50 realizations, which are at groups `/001`, `/002`, ..., `/050`:
  * `/XXX/c` is an `ndarray` of shape `[n,n,len(t)]` that contains the concentration field. `c[i,j,k]` is the value of the concentration field at position `x[i,j]` and `y[i,j]` at time `t[k]`. In other words, `c[...,i]` is the snapshot of the concentration field at time `t[i]`.
  * The group `/XXX` also contains `/XXX/u`,`/XXX/v`, which are the `x` and `y` components of the velocity field. Note that `u` and `v` are not evaluated at the same grid points as c since we use a staggered scheme to ensure conservation. The functional form of `u` and `v` is given in both MATLAB and Mathematica syntax in the attributes of `/XXX`.

### Data
Here are generated `hdf5` files. The data is released under [Creative Commons CC-BY license](https://creativecommons.org/licenses/by/4.0).
* [`eta=1.0e-03`](https://www.dropbox.com/s/wn69xu9en1417pn/1.0e-03_single.h5?dl=0)
* [`eta=2.2e-03`](https://www.dropbox.com/s/23z795d2je14n8f/2.2e-03_single.h5?dl=0)
* [`eta=4.6e-03`](https://www.dropbox.com/s/58nz08kcfjevw7y/4.6e-03_single.h5?dl=0)
* [`eta=1.0e-02`](https://www.dropbox.com/s/1ib6t0813mw7myx/1.0e-02_single.h5?dl=0)
* [`eta=2.2e-02`](https://www.dropbox.com/s/p69ikan43fq3ip5/2.2e-02_single.h5?dl=0)
* [`eta=4.6e-02`](https://www.dropbox.com/s/1gk64n49nlw1w53/4.6e-02_single.h5?dl=0)
* [`eta=1.1e-01`](https://www.dropbox.com/s/1l3f1o0sqxau7uk/1.0e-01_single.h5?dl=0)
* [`eta=2.2e-01`](https://www.dropbox.com/s/0bes16hrrgi8rfz/2.2e-01_single.h5?dl=0)
* [`eta=4.6e-01`](https://www.dropbox.com/s/bithdc020dceiyd/4.6e-01_single.h5?dl=0)

[![Creative Commons License](https://i.creativecommons.org/l/by/4.0/88x31.png)](http://creativecommons.org/licenses/by/4.0/)
