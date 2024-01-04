# Procedures again: interfaces

So far, we have demanded that all procedures be defined as part of a
module. This has the important advantage that it makes the
_interface_ to the function or subroutine _explicit_ to the compiler,
and to other program units via the `use` statement. The compiler can
then check the order and type of the actual arguments.

Other situations arise where we may need to give the compiler additional
information about the interface.

## An external function

Consider a program unit (which may or may not be a separate file) which
contains a function declaration outside a module scope. E.g.,
```
  function my_mapping(i) result(imap)
    integer, intent(in) :: i
    integer             :: imap
    ...
  end function my_mapping
```
If we compile a program which includes a reference to this function,
an error may result. We have not given the compiler any information
about the function.

It is possible to provide the compiler with some limited information
about the return value of the function with the `external` attribute
(also available as a statement). E.g.,
```
  program example

    implicit none
    integer, external :: my_mapping
    ...
```

However, we have still not given the compiler full information about
the interface. The interface is said to remain _implicit_. To make
it explicit, the `interface` construct is available:
```
  program example

    implicit none
    interface
      function my_mapping(i) result(imap)
        integer, intent(in) :: i
	integer             :: imap
      end function my_mapping
    end interface

    ...
```
This has provided a full, explicit, statement about the interface of the
function `my_mappping()`. (Note that the dummy argument names are not
significant, but the function name is.)

The compiler should now be able to check the arguments are used correctly
in the calling program (as if we had declared the function in a module).

Interface blocks are necessary in other contexts.

### Exercise (5 minutes)

To illustrate the points made above, a very simple external function is
defined in the file `external.f90`, and an accompanying program
`example1.f90` calls the function therein.

Compile the two files, e.g.:
```
$ ftn external.f90 example1.f90
```
(note that there are no modules involved, and no `.mod` files will appear).
What is the result when you try to run the program?

Try adding the appropriate `external` declaration
```
  integer, external :: array_size
```
What happens if you try to run the program now?

Finally, remove the `external` declaration and try to introduce the
correct `interface` block. What happens now?


## Passing functions or subroutines as arguments

Sometimes it is convenient to provide a procedure as an argument to
another function or subroutine. Good examples of this are for
numerical optimisation or numerical integration methods where
a user-defined function needs to be evaluated for a series of
different arguments which cannot be prescribed in advance.

This can be done if an interface block is provided which describes
the function that is the dummy argument. E.g.,
```
  subroutine my_integral(a, b, afunc, result)
    real, intent(in) :: a
    real, intent(in) :: b
    interface
      function afunc(x) result(y)
        real, intent(in) :: x
	real                y
      end function afunc
    end interface
    ...
```
The function dummy argument has no intent. One cannot in general
use intrinsic procedures as actual arguments.


## Limited polymorphism

We have seen a number of intrinsic functions which take arguments of
different types, such as `mod()`. Such a situation where the arguments
can take a different form is sometimes referred to as limited polymorphism
(or overloading).

However, it is not possible in Fortran to define two procedures of the same
name, but different arguments (at least in the same scope). We need different
names; suppose we have two module sub-programs, schematically:

```
   subroutine my_specific_int(ia)
     integer, intent(inout) :: ia
     ... integer implementation ...
   end subroutine my_specific_int

   subroutine my_specfic_real(ra)
     real, intent(inout) :: ra
     ... real implementation ...
   end subroutine my_specific_real
```
A mechanism exists to allow the compiler to identify the correct routine
based on the actual argument when used with a _generic name_. This is:
```
  interface my_generic_name
    module procedure my_specific_int
    module procedure my_specific_real
    ...
  end interface my_generic_name
```
This should appear in the specification part of the relevant module.
The two specific implementations must be distinguishable by the compiler,
that is, at least one non-optional dummy argument must be different.

### Exercise

In section 4.03, we wrote a module to produce a `.pnm` image file. The
accompanying module `pbm_image.f90` provides two implementations
of such a routine: one for a logical array, and another for an integer
array.

Check you can add the appropriate `interface` block with the generic
name `write_pbm` to allow the program `example3.f90` to be compiled
correctly.


## Operator overloading

For simple derived types it may be meaningful to define relational
and arithmetic operators. For example, if we had a date type such as
```
  type :: my_date
    integer :: day
    integer :: month
    integer :: year
  end type my_date
```
it may be meaningful to ask whether two dates are equal and so on (it would
not really be meaningful to add one date to another).

One can write a function to do this:
```
  function my_dates_equal(date1, date2) result(equal)
    type (my_date), intent(in) :: date1
    type (my_date), intent(in) :: date2
    logical                       equal
    ! ...
  end function my_dates_equal
```
As a syntactic convenience, it might be useful to use `==` in a logical
expression using dates. This can be arranged via
```
  interface operator(==)
    module proceduce my_dates_equal
  end interface
```
Again this should appear in the relevant specification part of the
relevant module. Such overloading is possible for relational operators
`==`, `/=`, `>=`, `<=`, `>` and `<`. If appropriate, overloading is also
available for arithmetic operators `+`, `-`, `*`, and `/`.

It is also possible to overload assignment `=`.


## Elemental functions

Again, we have seen that some intrinsic functions allow either scalar
or array actual arguments. The same effect can be achieved for a
user-defined function by declaring it to be _elemental_. The procedure
is declared in terms of a scalar dummy argument, but then may be
applied to an array actual argument element by element.

Such a procedure should be declared:
```
  elemental function my_function(a) result(b)
    integer, intent(in) :: a
    integer             :: b
    ! ...
  end function my_function
```
An invocation should be, e.g.:
```
   iresult(1:4) = my_function(ival(1:4))
```

All arguments (and function results) must conform. An elemental routine
usually must also be `pure`.


### Exercise (5 minutes)

In the `pbm_image.f90` module there is a utility function `logical_to_pbm()`
which is used in `write_logical_pbm()` to translate the logical array to
an integer array. Refactor this part of the code to use an elemental function.


## Exercise (20 minutes)

Write a module/program to perform a very simple numerical integration
of a simple one-dimensional function _f(x)_. We can use a
trapezoidal rule: for lower and upper limits _a_ and _b_, the
integral can be approximated by
```
  (b - a)*(f(a) + f(b))/2.0
```
If we introduce a small interval `h = (b - a)/n` then the same
expression is
```
  h*(f(a) + sum + f(b))/2.0
```
with the sum
```
  sum = 0.0
  do k = 1, n-1
    sum = sum + 2.0*f(a+k*h)
  end do
```
Write a procedure that will take the limits `a` and `b`, the integer number
of steps `n`, and the function, and returns a result.

To check, you can evaluation the function `cos(x) sin(x)` between `a = 0`
and `b = pi/2` (the answer should be 1/2). Check your answer gets better
for value of `n = 10, 100, 1000`.
