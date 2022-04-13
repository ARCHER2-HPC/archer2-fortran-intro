# Array expressions and assignments

Fortran allows some fairly flexible operations on arrays or subsets
of array elements.

## Array sections

A general subset of array elements, an _array section_,  may be constructed
from the triplet
```
  [subscript] : [subscript] [: stride] 
```
Given a rank 1 array `a(:)`, some valid array sub-objects are:
```
  a         ! the whole array
  a(:)      ! the whole array again
  a(1:4)    ! array section [ a(1), a(2), a(3), a(4) ]
  a(:4)     ! all elements up to an including a(4)
  a(2::2)   ! elements a(2), a(4), a(6), ...
```
If an array subscript is present, it must be valid; if the stride is present
it may not be zero.

## Array expressions and assignments

Intrinsic operations can be used to construct expressions which are
arrays. For example:
```
  integer, dimension(8, 16) :: a1, a2
  integer, dimension(8)     :: b1

  a1 = 0                      ! initialise all elements to zero
  a2 = a1 + 1                 ! all elements of a2(:,:) 
  a1 = 2*a1                   ! multiplied element-wise

  b1 = a1(:, 1)               ! b1 set to first column of a1
```
Such expressions and assignments must take place between entities with
the same shape (they are said to _conform_). A scalar conforms
with an array of any shape.

Given the above declarations, the following would not make sense:
```
  b1 = a1
```

### Exercise (1 minute)

A caution. How should we interpret the following assignments?
```
  d = 1.0
  e(:) = 1.0
```

## Elemental intrinsic functions

Many instrinsic functions are _elemental_: that is, a call with a scalar
argument will return a scalar, while a call with an array argument will
return an array with the result of the function for each individual
element of the argument.
For example,
```
   real, dimension(4) :: a, b
   ...
   b(1:4) = cos(a(1:4))
```

## Reductions

Other intrinsic functions can be used to perform reduction operations
on arrays, and usually return a scalar. Common reductions are
```
   a = minval( [1.0, 2.0, 3.0] )
   b = maxval( [1.0, 2.0, 3.0] )
   c = sum(array(:))
```

## Logical expressions and masks

There is an array equivalent of the `if` construct, e.g.,:
```
  real, dimension(20) :: a
  ...
  where (a(:) >= 0.0)
    a(:) = sqrt(a(:))
  end where
```
which performs the appropriate operations element-wise. Formally,
```
  where (array-logical-expr)
    array-assignments
  end where
```
in which all the _array-logical-expr_ and _array-assignments_ must have the
same shape.

Logical functions `any()`, `all()`, and others may be used to reduce
logical arrays or array expressions:
```
   if (any(a(:) < 0.0)) then
     ! ...
   end if
```
Some intrinsic functions have an optional mask argument which can be used to
restrict the operations to certain elements, e.g.,
```
  b = min(array(:), mask = (array(:) > 0.0))
```
These may be useful in certain situations.


### Exercise (5 minutes)

For this section


## Mini-exercise (20 minutes)

Solve a tri-diagonal system.

