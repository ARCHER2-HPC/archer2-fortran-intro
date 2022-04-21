# Modules

Modules in Fortran provide _the_ way to structure collections of related
definitions and operations, and make them available elsewhere.

## Module structure

We have already used one _intrinsic module_ (`iso_fortran_env`); we
can also write our own, e.g.,
```
module module1

  implicit none
  integer, parameter :: mykind = kind(1.d0)

contains

  function pi_mykind() result(pi)   ! Return the value of a well-known constant

    real (kind = mykind) :: pi
    pi = 4.0*atan(1.0_mykind)

  end function pi_mykind

end module module1
```
We may now `use` the new module in other _program units_ (main program or
other modules). For example:
```
program example1

  use module1
  implicit none

  real (kind = mykind) :: value
  value = pi_mykind()

end program example1
```
Here both the parameter `mykind` and the function `pi_mykind()` are said
to be available by _use association_. Note that any `use` statements
must come before the `implicit` statement.

Formally, the structure of a module is:
```
  module module-name
    [specification-statements]
  [ contains
    module-subprograms ]
  end [ module [ module-name ]]
```
The `contains` statement separates the specification statements from
module sub-programs.
Sub-programs, or _procedures_,  consist of functions and/or subroutines,
of which more later.

### Digression: compilation of modules, and programs

One would typically expect modules and a main program to be in
separate files, e.g.,:
```
$ ls
module1.f90     program1.f90
```
It is often convenient to use the same name for the both module and
the corresponding file (with extension `.f90`). You can do
differently, but it can become confusing. Likewise for the main program.

We can compile the module, e.g.,
```
$ ftn -c module1.f90
```
where the `-c` option to the Fortran compiler `ftn` requests compilation
only (no link). This should give us two new files:
```
$ ls
module1.f90     module1.mod     module1.o       program1.f90
```
The first is a compiler-specific _module file_ (usually with a `.mod`
extension). This plays the role roughly analogous to a header (`.h`)
file in C, in that it contains the relevant public information
about what the module provides. The other file is the object file
(`.o` extension) which can be linked with the run time to form an
executable.

We can now compile both the main program and the module to give an
executable.
```
$ ftn module1.o program1.f90
```
Again, by analogy with C header files, we do not include the `.mod`
file in the compilation command; there is a search path which the
compiler uses to look for module files (which includes the current
working directory).

### Exercise (2 minutes)

If you haven't already done so, compile the accompanying `module1.f90`
and `program1.f90`. Check the errors which occur if you: (1) try to
compile the program without the module file via, e.g.,
```
$ ftn program1.f90
````
and (2), if you try to compile and link the module file alone:
```
$ ftn module1.f90
```


## Scope

Entities declared in a module are, by default, available by use association,
that is, they are visible in program units which `use` the module. One can
make this scope explicit via the `public` and `private` statements.
```
module module1

  implciit none
  public

  integer, parameter :: mykind = kind(1.d0)

contains

  function pi_mykind() result(pi)

    real (kind = mykind) :: pi
    ...
  end function pi_mykind()

end module module1
```
Note that the parameter `mykind` is available throughout the module via
_host association_ (always).

An alternative would be to switch the default to `private`, and explicitly
add `public` attributes:
```
module module1

  implicit none
  private

  integer, parameter, public :: mykind = kind(1.d0)    ! visible via `use`
  integer, parameter         :: mypriv = 2             ! not visible via `use`

  public :: pi_mykind

contains
  function pi_mykind() result(pi)                      ! public
    ! ... may call my_private() ...
  end function pi_mykind

  subroutine my_private()                              ! private
    ...
  end subroutine
end module module1
```
Note that scope of the `implicit` statement also covers the whole module,
including sub-programs.


### Exercise (1 minute)

Edit the accompanying `module1.f90` to add a `private` statement and
check the error if you try to compile `program1.f90`.


## Module data and other horrors

It is possible to establish non-parameter data in the specification
section of a module. E.g.,
```
module module2

  implicit none
  integer, dimension(:), allocatable :: iarray
...
```
This course will argue that you should _not_ do so. There are a number
of reasons.

1. Any such data takes on the character of a global mutable object.
Global objects are generally frowned upon in modern software development.
2. Operations in module procedures on such data run the risk of being
neither thread safe nor re-entrant.

Even worse, variables declared with an initialisation in a module
sub-program, e.g.,
```
  integer :: i = 1
```
implicitly take on the Fortran `save` attribute. This means the
variable is placed in heap memory and retains its value between calls.
(Analogous to a `static` declaration in C.) This is certainly neither
thread-safe nor re-entrant. Uninitialised variables appear on the stack
(and dissappear) as expected.

For this reason it is the rule, rather than the exception, that variables
are not initialised at the point of declaration in Fortran.

We will look at alternative ways of establishing and moving data
as we go along.

### Exercise (5 minutes)

Return to your code for the approximation to pi via the Gauss-Legendre
iteration (or use the template
[section2.02/exercise1.f90](../section2.02/exercise1.f90)).
Using the exmaples above as a template, write a module to contain a
function which returns the value so computed.
Check you can use the new function from a main program.

What really needs to be publicly available from the module in this case?

Additional exercise: Can we have the following situation:
```
module a

  use b
  implciit none
  ! content a ...
end module a
```
and
```
module b

  use a
  implicit none
  ! content b ...
end module b
```
If not, why not?

Expert exercise: If you wish to express dependencies in a `Makefile` for
a Fortran program using a module, does compilation the program source depend
on the `.mod` module file, the `.o` object file, or both? Do you care?
