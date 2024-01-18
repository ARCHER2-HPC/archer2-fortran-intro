# Loops and flow of control

Iteration in Fortran is based around the `do` construct (somewhat analogous to
C `for` construct). There is no equivalent of the C++ iterator class.

## Uncontrolled `do` construct

A simple iteration is provided by the `do` statement. For example, ...
```fortran
  do
    ! ... go around for ever ...
  end do
```
A slightly more useful version requires some control (see `example1.f90`):
```fortran
   integer :: i = 0
   do
     i = i + 1
     if (mod(i, 2) == 0) cycle    ! go to the next iteration
     if (i >= 10) exit            ! exit loop completely
     ! ... some computation ...
   end do

   ! ... control continues here after exit ...
```
Loop constructs may be nested, and may also be named (see `example2.f90`):
```fortran
  some_outer_loop: &
  do
    some_inner_loop: &
    do
      if (i >= 10) exit some_outer_loop  ! exit belongs to outer loop
      ! ... continues ...
    end do some_inner_loop
  end do some_outer_loop
```
If the control statements `cycle` or `exit` do not have a label,
they belong to the innermost construct in which they appear.


## Loop control

More typically, one encounters controlled iterations with an `integer`
loop control variable. E.g.,
```fortran
  integer :: i
  do i = 1, 10, 2
    ! ... perform some computation ...
  end do
```
Formally, we have
```
[do-name:] do [loop-control]
             do-block
	   end do [do-name]
```
with _loop-control_ of the form:
```
  do-variable = int-expr-lower, int-expr-upper [, int-expr-stride]
```
and where the number of iterations will be
```
  max(0, (int-expr-upper - int-expr-lower + int-expr-stride)/int-expr-stride)
```
in the absence of any subsequent control. The number of iterations may
be zero. Any of the expressions may be negative. If the stride is not
present, it will be 1 (unity); if the stride is present, it may not be zero.

### Exercise (2 minutes)

What is the number of iterations in the following cases?
```fortran
   do i = 1, 10
     print *, "i is  ", i
   end do

   do i = 1, 10, -2
     print *, "i is ", i
   end do

   do i = 10, 1, -2
     print *, "i is ", i
   end do
```
You can confirm your answers by running `example3.f90`. Note there is
no way (cf. C `for`) to limit the scope of the loop
variable to the loop construct itself; the variable will then have a
final value after exit from the loop.

### Exercise (5 minutes)

We return the exercises discussed in section1.02. You can use your
own solutions, or the new template in this directory.

For `exercise1.f90` which computes an approximation to the constant pi
using the Gauss-Legendre algorithm, introduce an iteration to
compute a fixed number of successive improvements. How many
iterations are required to converge when using kind(1.d0)? Can you
adjust the program to halt the iteration if the approximation
is within a given tolerance of the true answer?

A simple solution to this problem is used as a template to
the exercise in [section2.02](../section2.02/exercise1.f90).

### Exercise (5 minutes)

For `exercise2.f90` a similar thing is required. Use a loop to compute
a fixed number of terms in the sum over index k (use real type `real64`
for the sum). Here you should find convergence is much slower (you
may need about 1000 terms); check by printing out the current value
every so many terms (say 20).

Expert question: What happens if you accumulate the sum in the reverse
order in this case?
