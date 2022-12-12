# Variables

Fortran provides the following intrinsic data types: numeric types `integer`,
`real` and `complex`; non-numeric types `logical` and `character`.

## Numeric variables of intrinsic type

The following program declares a variable with each of the three intrinsic
numeric types, and provides an initial value in each case.
```
program example1

   implicit none

   integer :: i = 1            ! A default integer kind
   real    :: a = 2.0          ! A default floating point kind
   complex :: z = (0.0, 1.0)   ! A complex kind with (real-part, imag-part)

end program example1
```
Initial values are optional. If a declaration does not specify an initial
value, the variable is said to be _undefined_.

### Variable names

The valid Fortran character set for names is `a-z`, `A-Z`, `0-9` and the
underscore `_`. Valid names must begin with a character. The maximum
length of a name is 63 characters (F2003) with no spaces allowed.
This includes names for programs, and names for variables.

Other special characters recognised by Fortran are given in
[F-SPECIAL-CHARACTERS.md](../docs/F-SPECIAL-CHARACTERS.md).


### `implicit` statement

The `implicit` statement defines a type for variable names not explicitly
declared.  So, the default situation can be represented by
```
  implicit integer (i-n), real (a-h, o-z)
```
that is, variables with names beginning with letters `i-n` are implicitly
of type `integer`, while anything else is of type `real` (unless
explicitly declared otherwise).

By modern standards this is tantamount to recklessness. The general solution
to prevent errors involving undeclared variables (usually arising from
typos) is to declare that no names have implicit type via `implicit none`.

In this case, all variable names must be declared explicitly before they
are referenced.

However, it is still common to see the idiom that variables beginning
with `i-n` are integers and so on.


### Exercise (1 minute)

Compile and run the accompanying program `exercise1.f90`. What's
the problem and how should we avoid it? Check the compiler can trap
the problem.

### `kind` of type

The declarations above give us variables of some (implementation-defined)
default type (typically 4-byte integers, 4-byte reals). A mechanism to
control the exact kind, or representation,  is provided. For example
(see `example2.f90`),
```
  use iso_fortran_env, only : int64, real64
  implicit none

  integer (kind = int64)   :: i = 100
  real    (kind = real64)  :: a = 1.0
  complex (kind = real64)  :: z = (0.0, 1.0)
```
Here we use _kind type parameters_ `int64` and `real64` to specify that
we require 64-bit integers and 64-bit floating point storage, respectively.

A standard conforming Fortran implementation must provide at least one
`integer` precision with a decimal exponent range of at least 18 (experience
suggests all provide at least two kinds). Note that Fortran does not have
any equivalent of C/C++ unsigned integer types.

An implementation must provide at least two `real` precisions, one default
precision, and one extended precision (sometimes referenced as
`double precision`).

Formally, the numeric types are introduced
```
  numeric-type-spec [kind-selector] ...
```
where the `numeric-type-spec` is one of `integer`, `real`, or `complex`.
The optional _kind selector_ is
```
  ([kind = ] scalar-integer-initialisation-expr)
```

The upshot of this is that the syntax of declarations is quite elastic,
and you may see a number of different styles. A reasonable form of
concise declaration with an explicit kind type parameter is:
```
  integer (int32)  :: i
  real    (real32) :: a
  complex (real32) :: z
```

### Example (2 minutes)

Take a moment to compare the output of the programs `example1.f90` and
`example2.f90`, which declare and initialise a variable of each type and
print out their values to the screen.

### Numeric literal constants

One may (optionally) specify the kind of an integer literal by appending the
kind type parameter with an underscore `_`, e.g.:
```
123
+123
-123
12345678910_int64
```
Floating point literal constants can take a number of forms. Examples are:
```
-3.14
.314
1.0e0             ! default precision
1.0d0             ! extended (double) precision
3.14_real128      ! may be available
3.14e-1           ! Scientific notation
3.14d+1           ! Scientific notation extended precision
```

Complex literals are constructed with real and imaginary parts, with each
part real.
```
(0.0, 1.0)        ! square root of -1
```

### Parameters

Suppose we did not want to hardwire our kind type parameters throughout
the code. Consider:
```
program example3

  implicit none

  integer, parameter :: my_e_k = kind(1.e0)
  integer, parameter :: my_d_k = kind(1.d0)

  real (my_e_k) :: a
  real (my_d_k) :: b

  ! ...

end program example3
```
Here we have introduced an `integer` with the `parameter` _attribute_. This is
an instruction to the compiler that the associated name should be a constant
(similar to a `const` declaration in C). Any subsequent attempt to assign a
value to a parameter will result in a compile time error.

The value specified in the parameter declaration must be a constant expression
(which the compiler may be able to evaluate at compile time). Here we have made
use of the _intrinsic function_ `kind()`. The `kind()` function returns an
integer
which is the kind type parameter of the argument. In this context a constant
expression is one in which all parts are intrinsic.

Note we have not included anything or `use`'d anything to make this available.
It is an intrinsic function and part of the language itself.

Using a parameter provides a degree of abstraction for the real data type.
Other examples might include:
```
  integer, parameter :: nmax = 32              ! A constant
  real,    parameter :: pi = 4.0*atan(1.e0)    ! A well-known constant
  complex, parameter :: zi = (0.0, 1.0)        ! square root of -1
```
The intrinsic function `atan()` returns the inverse tangent (as a value in
radians) of the argument.

### Exercise (2 minutes)

Consider further the accompanying `example3.f90`, where we have introduced
another intrinsic function `storage_size()` (roughly equiavalent to C
`sizeof()` although it returns a size in bits rather than bytes).
Run the program and check the actual values of the kind type parameters
and associated storage sizes. Speculate on the portability of a program
declaring, e.g.,:
```
  integer (4) :: i32
  integer (8) :: i64
```

### Exercise (2 minutes)

Consider the accompanying `exercise2.f90`. Check the compiler error emitted and
remove the offending line.


### Arithmetic operations on numeric types

For all intrinsic numeric types, standard arithmetic operations,
addition (`+`), subtraction (`-`), multplication (`*`) and
division (`/`) are defined, along with exponents (`**`) and
negation (`-`).

In order of increasing precedence these are `-`, `+`, `/`, `*`,
and `**` (otherwise left-to-right). In particular
```
   a = b*c**2    ! is evaluated as b*(c**2)
   a = b*c*d     ! evaluated left-to-right (b*c)*d
```
Use parentheses to avoid ambiguity if necessary.

A large number of intrinsic functions exist for basic mathematical
operations and are relevant for all numeric types. A simple example
is `sqrt()`. Some are specific to particular types, e.g., `conjg()`
for complex conjugate.

Broadly, assignments featuring different data types will cause
promotion to a "wider" type or cause truncation to a "narrower" type.
If one wants to be explicit, the equivalent of the cast mechanism in C
is via intrisic functions, e.g.,
```
   integer          :: i = 1
   complex (real64) :: z = (1.0, 1.0)
   real    (real64) :: a, b

   a = real(i, real64)          ! a should be 1.d0
   a = real(z, real64)          ! imaginary part is ignored

   b = real(i)                  ! return default real kind

   z = cmplx(a, b)              ! (sic) Form complex number from two reals
```
The second argument of the `real()` function is optional, and specifies the
kind type parameter of the desired result. If the optional argument is not
present, then a real value of the default kind is returned.

Note here the _token_ `real` has been used in two different contexts: as
a statement in the declaration of variables `a` and `b`, and as a function.
There is not quite the same concept of "reserved words" (cf C/C++);
lines are split into tokens based on spaces, and tokens are parsed in
context.

### Complex real and imaginary parts

The real and imaginary parts of a complex variable may be accessed
```
  complex :: z

  z%re = 0.0     ! real part
  z%im = 1.0     ! imaginary part
```
where the `%` symbol is referred to as the component selector. The real
and imaginary parts are also available via the `real()` and `aimag()`
intrinsic functions, respectively.

### Exercise (2 minutes)

By using variables of complex type, check that you can use the
intrinsic function `srqt()` to confirm that the square root of
-1 is `i`. What happens if you try to try to take the square root
of a negative value stored as a real variable?

### Exercise (5 minutes)

The accompanying template `exercise3.f90` provides instructions for an
exercise which involves the approximation to the constant pi computed
via a Gauss-Legendre algorithm. Some
background can be found at https://en.wikipedia.org/wiki/Pi.

A solution to this problem appears as the template for the exercise in
[section2.01](../section2.01/exercise1.f90).

### Exercise (5 minutes)

A second exercise in a similar vein looks at an approximation to the
conductance of a rectangular channel subject to a constant flow.
Instructions are in `exercise4.f90`.

A solution to this problem appears as the template for the second
exercise in [section2.01](../section2.01/exercise2.f90).
