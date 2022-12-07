# Functions and subroutines

Functions and subroutines, referred to colletively as _procedures_, may be
defined as module sub-programs, where the compiler will automatically
generate the contract block (aka. forward declaration, prototype) as
part of the module file.

## What's the difference?

The difference between functions and subroutines is to a degree one of
context. A function returns a result and is generally used where it
is best invoked as part of an expression or assignment, schematically:
```
  value = my_function(arg1, arg2, ...)
```
Unlike C, it is not possible simply to discard a function result.
A subroutine, by contrast, does not return a result (it may be thought of as a
`void` function in C terms), but it is also invoked differently:
```
  call my_subroutine(arg1, arg2, ...)
```
Subroutines are generally used to express more lengthy algorithms.

Note that in the calling context, the arguments `arg1`, `arg2`, etc
are referred to as the _actual arguments_.


## Dummy arguments and `intent` attribute

Procedures may have zero or more arguments (referred to as the _dummy
arguments_ at the point at which the procedure is defined). Three
different cases can be identified:

1. read-only arguments whose values are not updated by the procedure;
2. read-write arguments whose values are expected to be defined on
   entry, and may also be updated by the procedure;
3. write-only arguments whose values are only defined on exit.

These three cases may be encoded in the declarations of the dummy
arguments of a procedure via the `intent` attribute . For example:
```
  subroutine print_x(x)

    real, intent(in) :: x

    print *, "The value of x is: ", x

  end subroutine print_x
```
Here, dummy argument `x` has `intent(in)` which tells the compiler that
any attempt to modify the value is erroneous (a compiler error will result).
This is different from C, where a change to an argument passed by value is
merely not reflected in the caller.

If one wants to alter the existing value of the argument, `intent(inout)`
is appropriate:
```
  subroutine increment_x(x)

    real, intent(inout) :: x

    x = x + 1.0

  end subroutine increment_x
```
If the dummy argument is undefined on entry, or has a value which is
simply to be overwritten, use `intent(out)`, e.g.:
```
  subroutine assign_x(x)

    real, intent(out) :: x

    x = 1.0

  end subroutine assign_x
```
The `intent` attribute, as well as allowing the compiler to detect
inadvertent errors, provides some useful documentation for the
reader.

Local variables do not have intent; otherwise, they are declared as
usual.


### Exercise (2 minutes)

Attempt to compile the accompanying `module1.f90` and associated main
program `program1.f90`. Check the error message emitted, and sort out
the intent of the dummy arguments in `module1.f90`.


## Functions
A function may be defined as:
```
function my_mapping(value) result(a)

  real, intent(in) :: value
  real             :: a

  a = ...

end function my_mapping
```

Formally,
```
[prefix] function function-name (dummy-arg-list) [suffix]
  [ specification-part ]
  [ executable-part ]
end [ function [function-name] ]
```
As ever, there is some elasticity in the exact form of the declarations
you may see. In particular, older versions did not have the `result()`
suffix, and the _function-name_ was used as the variable to which the
return value was assigned. E.g.,
```
real function length(area)
  real area
  length = sqrt(area)
end function length
```
The modern form should be preferred; the `result()` part allows the two
names to be decoupled.

### `pure` procedures

Procedures which have no side effects may be declared with the
`pure` prefix; this may provide useful information to the compiler
in some circumstances. E.g.,
```
pure function special_function(x) result(y)
  real, intent(in) :: x
  ! ...
end function special_function
```
There are a number of conditions which must be met to qualify for
`pure` status:
1. For a function, any dummy arguments must be intent(in);
2. No variables accessed by host association can be updated (and no variables with `save` attribute);
3. there must be no operations on external files;
4. there must be no `stop` statement.


### `recursive` procedures

If recursion is required, a procedure must be declared with the
`recursive` prefix. E.g.,
```
recursive function fibonacci(n) result(nf)
  ! ... implementation...
  nf = fibonacci(n-1) + fibonacci(n-2)
end function fibonacci
```
Such a declaration must be included for both direct or indirect recursion.

## Subroutines

Subroutines follow the same rules as functions, except that there is no
`result()` suffix specification.

### `return` statement

One may have a `return` statement to indicate that control should
be returned to the caller, but it is not necessary (the `end`
statement does the same job). We will use `return` when we consider
error handling later.


## Exercise (5 minutes)

1. Can your function for the evaluation of pi from the previous section safely be declared `pure`? You can use the accompanying template `exercise_module1.f90` and `exercise_program1.f90` to check.
2. Add a new version of this calculation: a subroutine which takes the number of terms as an argument, and also returns the computed value in the argument list.
3. Complete the recursive function to compute the nth Fibonacci number, and test it. See, for example https://en.wikipedia.org/wiki/Fibonacci_number.
