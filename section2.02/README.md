# Arrays

Unlike C, which often uses pointers to handle array data, Fortran has arrays
which are an intrinsic feature of the language.

## A one-dimensional array

Arrays may be declared with addition of the `dimension` attribute, e.g.,
```
program example1

  implicit none

  real, dimension(3) :: a    ! declare a with elements a(1), a(2), a(3)

end program example1
```
The _size_ of the array is the total number of elements (here 3).
The default _lower bound_ is 1 and the _upper bound_ is 3.


### Lower and upper bounds
```
  real, dimension(-2:1) :: b ! elements b(-2), b(1), b(0), b(1)
```
Here we specify, explicitly, the lower and upper bounds. The
_size_ of this array is 4.


### Array constructor

One may specify array values as a constructor
```
  integer, dimension(3), parameter :: s = (/ -1, 0, +1 /)   ! F2003 or
  integer, dimension(3), parameter :: t = [  -1, 0, +1 ]    ! F2008
```

## A two-dimensional array
```
  real, dimension(2,3) :: a   ! elements a(1,1), a(1,2), a(1,3)
                              !          a(2,1), a(2,2), a(2,3)
```
This two-dimensional array (said to have _rank_ 2) has two elements
in the first dimension (or _extent_ 2), and 3 elements in the second
dimension (_extent_ 3). It is said to have _shape_ (2,3), which is
the sequence of extents in each dimension. Its size is 6 elements.

There is an array element order which in which we expect the implementation
to store contiguously in memory. In Fortran this has to be the left-most
dimension counting fastest. For array `a` we expect the order in
memory to be
```
a(1,1), a(2,1), a(1,2), a(2,2), a(1,3), a(2,3)
```
that is, the opposite the the convention in C.

### `reshape`

A constructor for an array of rank 2 or above might be used, e.g.,
```
  integer, dimension(2,3) :: m = reshape([1,2,3,4,5,6], shape = [2,3])
```
where we have used the intrinsic function `reshape()`.

### Exercise (2 minutes)

Check the accompanying `example1.f90` to see examples of intrinsic functions
available to interrogate array size and shape at run time.


## Allocatable arrays

If we wish to establish storage with shape determined at run time,
the _allocatable_ attribute can be used. The rank must be specified:
```
  real, dimension(:, :), allocatable :: a

  ! ... establish shape required, say (imax, jmax) ...

  allocate(a(imax, jmax))

  ! ... use and then release storage ...

  deallocate(a)
```
Again, this array will take on the default lower bound of 1 in each
dimension.

Formally,
```
  allocate(allocate-list [, source = array-expr] [ , stat = scalar-int-var])
```
The optional `source` argument may be used to provide a template for
the newly allocated object (values will be copied). We will return to
this in more detail in the context of dynamic type.

A successful allocation with the optional `stat` argument will assign a
value of zero to the argument.

### Allocation status

An array declared with the _allocatable_ attribute is initially in
an unallocated state. When allocated, this status will change; this
status can be interrogated via the intrinsic function `allocated()`.
```
  integer, dimension(:), allocatable :: m
  ...
  if (allocated(m)) then
    ! ... we can do something ...
  end if
```
Attempt to `deallocate` a variable which is not allocated is an error.


### Exercise (5 minutes)

Return again to the program to compute the approximation of pi via
the Gauss-Legendre expansion (last seen in section2.01). You may use
your own version or the new template provided in this directory
(see `exercise1.f90`).

Introduce array storage for the quantites `a`, `b` and `t`. Use a
fixed number of terms. Assign appropriate values in a first loop.
In a second loop, compute the approximation of pi at each iteration.

What might you do if you wanted to storage only the number of terms
taken to reach a converged answer?
