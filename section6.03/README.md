# Exercise

These exercises can, largely, be done in any order.

## Conjugate gradient solver

The conjugate gradient method provides a slightly more general
method for the solution of linbear systems _Ax = b_ for symmetric
matrices. The algorithm is explained here:

https://en.wikipedia.org/wiki/Conjugate_gradient_method

It is not necessary to understand the details, as we are just
interested in implementing the algorithm.

There are two main steps involved. The first is to perform a
matrix-vector multiplication. This can be done using the Fortran
intrinsic function `matmul()`. (Or you can have a go at
implementing your own version - it's not too difficult.)

The second step is to compute a scalar residual from a vector
residual. If we have an array (vector) `r(1:n)` this can be
done with:
```
  residual = sum(r(:)*r(:))
```

All the operations in the algorithm can be composed of these,
as well as vector additions and multiplications by a scalar.

A template program is provided with a small matrix to use as a
test. You need to implement a module `cgradient` which supplies
a function `cg_test()` taking the arguments set out in the template.

Remember that you can always check your answer by multiplying out
_Ax_ to recover the original right-hand side _b_.


## Larger matrices

The Matrix Market provides a number of archived matrices of different
types. It also defines a simple ASCII format for the storage of
sparse matrices.

https://math.nist.gov/MatrixMarket/

The Matrix Market Exchange format `.mtx` files are structured as
follows.
```
%% Exactly one header line starting %%
% Zero or more comment lines starting %
nrows ncols nnonzero
i1 j1 a(i1,j1)
i2 j2 a(i2,j2)
...
```
where `nrows` and `ncols` are the number of rows and columns in the
matrix, respectively. `nnonzero` is the number of non-zero entries
in the matrix. For each non-zero entry there then follows a single
line which the row index, the column index, and the value of the
matrix element itself.

Download an example, e.g.,
```
$ wget https://math.nist.gov/pub/MatrixMarket2/Harwell-Boeing/laplace/gr_30_30.mtx.gz
$ gunzip gr_30_30.mtx
```

If you look at the fist few line of this example, you should see
```
%%MatrixMarket matrix coordinate real symmetric
900 900 4322
1 1  8.0000000000000e+00
2 1 -1.0000000000000e+00
31 1 -1.0000000000000e+00
32 1 -1.0000000000000e+00
2 2  8.0000000000000e+00
```

### Exercise

* Define a type that can hold the sparse representation
and provide a procedure which initialises such a type from a
file.

* Provide a procedure which brings into exsitance a dense matrix
(just a two-dimensional array) initialised with the correct non-zero
elements.

* Use the `.pbm` file generator to produce an image of the non-zero
elements to provide a check the file has been read correctly.

* Try some other matrices from the Matrix Market.
