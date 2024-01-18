# More on dummy arguments

There are some additional considerations to think about when dummy arguments
are arrays.

## Array dummy arguments

### Explicit shape

One is entitled to make explicit the shape of an array in a procedure
definition, e.g.,
```fortran
  subroutine array_action1(nmax, a)
    integer, intent(in)                    :: nmax
    real, dimension(1:nmax), intent(inout) :: a
    ...
  end subroutine array_action1
```
and similarly for arrays of higher rank. As before, if the lower bound
of the array is unspecified, it takes on the default value of `1`.


### Assumed shape
However, it may be more desirable to leave the exact shape
implicit in the array itself, e.g.,
```fortran
  subroutine array_action2(a, b)
    real, dimension(:,:), intent(in   ) :: a
    real, dimension(:,:), intent(inout) :: b
    ...
  end subroutine array_action2
```
Note that the rank is always explicit.

There are pros and cons to this: it is slightly more concise and general,
but some care may need to be exercised with the distinction between
_extents_ and bounds. It is the _shape_ that is passed along with the
actual arguments.


### `lbound()` and `ubound()` again

The `lbound()` and `ubound()` functions return a rank one array which
is the relevant bound in each dimension. The optional argument `dim`
can be used to obtain the bound in the corresponding rank or dimension
e.g.,
```fortran
  real, dimension(:,:), intent(in) :: a
  integer :: lb1, lb2

  lb1 = lbound(a, dim = 1)  ! lower bound in first dimension
  lb2 = ubound(a, dim = 2)  ! lower bound in second dimension
```

### Exercise (4 minutes)

Consider the accompanying example in `program1.f90` and `module1.f90`.
Is the code correct? Add calls to `lbound()` and `ubound()` in the
subroutine to check.

What do you think was the intention of the programmer? What remedies
are available?


### Automatic arrays

One is allowed to bring into existence `automatic' arrays on the stack.
These are usually related to temporary workspace, e.g.,
```fortran
subroutine array_swap1(a, b)
  integer, dimension(:), intent(inout) :: a, b
  integer, dimension(size(a))          :: tmp

  tmp(:) = a(:)
  a(:)   = b(:)
  b(:)   = tmp(:)
end subroutine array_swap1
```
In this example, the same effect could have been achieved using a
loop and a temporary scalar.


### Allocatable dummy arguments

It may occasionally be appropriate to have a dummy
argument with both an intent and `allocatable` attribute.
```fortran
  subroutine my_storage(lb, ub, a)

    integer, intent(in) :: lb, ub
    integer, dimension(:), allocatable, intent(out) :: a

    allocate(a(lb:ub))

  end subroutine my_storage
```
There are a number of conditions to such usage.
1. The corresponding actual argument must also be allocatable (and have the same type and rank);
2. If the intent is `intent(in)` the allocation status cannot be changed;
3. If the intent is `intent(out)` and the array is allocated on entry, the array is automatically deallocated.

The intent applies to both the allocation status and to the array itself.
Some care may be required.

A `function` may have an allocatable result which is an array; this might
be thought of as returning a temporary array which is automatically
deallocated when the relevant expression has been evaluated.


## Optional arguments

We have encountered a number of intrinsic procedures with optional dummy
arguments. Such procedures may be constructed with the `optional`
attribute for a dummy argument, e.g.:
```fortran
  subroutine do_something(a, flag, ierr)
    integer, intent(in)            :: a
    logical, intent(in),  optional :: flag
    integer, intent(out), optional :: ierr

  end subroutine do_something
```
Any operations on such optional arguments should guard against the
possibility that the corresponding actual argument was not present
using the intrinsic function `present()`. E.g.,
```fortran
  local_flag = some_default_value
  if (present(flag)) local_flag = flag
```
Any attempt to reference a missing optional argument will generate an error.

The one exception is that an optional argument may be passed directly
as an actual argument to another procedure where the corresponding
dummy argument is also optional.

### Positional and keyword arguments

Procedures will often have a combination of a number of mandatory
(non-optional) dummy arguments, and optional arguments. These may be
mixed via the use of keywords, which are the dummy argument name. E.g.,
using the subroutine defined above:,
```fortran
  call do_something(a, ierr = my_error_var)
```
Here, `a` is appearing as a conventional positional argument, while
a keyword argument is used to select the appropriate optional
argument `ierr`. The rules are:
1. no further positional arguments can appear after the first keyword argument;
2. positional arguments must appear exactly once, keyword arguments at most once.



## Exercise (10 minutes)

Consider again the problem of the tri-diagonal matrix.

Refactor your existing stand-alone program (or use the template
`exercise.f90`) to provide a module subroutine such as
```fortran
  subroutine tridiagonal_solve(b, a, c, rhs, x)
```
where `b`, `a`, and `c` are arrays of the relevant
extent to represent the diagonal elements, the lower diagonal elements
and the upper diagonal elements respectively. Use the `size()` intrinsic
to determine the current size of the matrix in the subroutine. The extent
of the off-diagonal arrays should be one less element. The `rhs` is the
vector of right-hand side elements, and `x` should hold the solution on
exit. Assume, in the first instance, that all the arrays are of the
correct extent on entry.

Check your result by calling the subroutine from a main program with some
tests values. (You may wish to take two copies of the template `exercise.f90`
and use one as the basis of a module, and the other as the basis of the main
program.)

What do you need to do if the diagonal and the right-hand side arrays
should be declared `intent(in)`?

What checks would be required in a robust implementation of such a routine?
