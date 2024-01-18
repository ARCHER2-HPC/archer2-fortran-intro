# Structures: derived types

The ability to aggregate related data in a structure is important.
Fortran offers the _derived type_ in addition to intrinsic types.
In its simplest form, one may think of this as the analogue to a
C `struct`.

Derived types also form the basis of aggregation of data and related
operations or procedures (viz. object-oriented programming); however,
this introductory course will only touch on this feature.

## Type definitions

A derived type with two _components_ would be declared, e.g.,
```
  type :: my_type
    integer                         :: nmax
    real, dimension(:), allocatable :: data
  end type my_type
```
Components may be intrinsic data types (all declared in the usual way),
or derived types.

A variable of this type is declared
```
  type (my_type) :: var
```
and individual components are referenced with the component selector `%`, e.g.,
```
  var%nmax = 10
  ...
  print *, "Values are ", var%data(1:3)
```
The component selector is the same as we have seen earlier for the complex
intrinsic type.

An array of types is defined in the usual way, and the component
selector is applied to individual elements, e.g.,
```
  type (my_type), dimension(10) :: var
  ...
  var(1)%nmax = 100
```
Dummy arguments to procedures are declared in the same way as for intrinsic
types with the appropriate attribute list, including intent.

### Put type definitions in a module

If a type definition is placed in the specification part of a module,
it can be made available consistently elsewhere via use association.

Some derived type features _require_ that the definition be in a
module.

### Scope of components

Formally, we have
```
  type [ [, attribute-list] :: ] type-name
    [private]
    component-part
  [ contains
    procedure-part ]
  end type [ type-name ]
```
The default situation is for both the type and its components to
be public. This may be made explicit by
```
  type, public :: my_type
    ...
  end type my_type
```
If one wants a public type with private components (an opaque type), use
```
  type, public :: my_opaque_type
    private
    ...
  end type my_opaque_type
```
Externally, other program units will be able to reference this opaque
type, but will not be allowed to access the components (a compiler error).

If a type is only for use within the module in which it is defined,
then it can be declared `private` in the attribute list.


### Type constructors

For types with public components, it is possible to use a structure
constructor to provide initialisation, e.g.,:
```
  type, public :: my_type
     integer :: ia
     real    :: b
     complex :: z
  end type my_type

  ...
  type (my_type) :: a

  a = my_type(3, 2.0, (0.0, 1.0))
```
Values or expressions can be used, but must appear in the order specified
in the definition of the components. An allocatable or pointer component
must appear as `null()` in a constructor expression list.

### Default initialisation

A type may be defined with default initial values. One notable exception
is that allocatable components do not have an initialisation. E.g.:
```
  type :: my_type
    integer                            :: nmax = 10
    real                               :: a0 = 1.0
    integer, dimension(:), allocatable :: ndata
  end type
```
A default initialisation can be applied by using an empty constructor::
```
  type (my_type) :: a

  a = my_type()
```
For an allocatable component, the result is a component with a not allocated
status.

Warning: some compilers can't manage an empty constructor for allocatable
components. The appropriate expression in the constructor is `null()`.


### Exercise (5 minutes)

The accompanying example (`module1.f90` and `program1.f90`) provides an
implementation of  very simple pseudo-random number generator. This is
a so-called linear congruential generator.

See https://en.wikipedia.org/wiki/Linear_congruential_generator.

The module provides derived type to aggregate the multiplier `a`,
the seed or state `s`, the increment `c` and the module `m`.
These have some default values. Practical implementations often
choose `c = 0`.

Compile the program, and check the first few numbers returned in the
sequence. The key to obtaining acceptable statistics is to identify
some appropriate values of `a` and `m` (e.g., those given in the default).

Check you can introduce some new values of `a` and `m` using the
structure constructor (a spectacularly bad choice is suggested in
the code).

What happens if you make the components of the type `private`?
What would you then have to provide to allow initialisation?


## Default input/output for derived types

List-directed output for derived types can be used to provide a
default output in which each component appears in order, schematically:
```
  type (my_type) :: a
  ...
  write (*, fmt = *) a
  write (*, fmt = *) a%component1, a%component2, ...
```
or one can apply a specific format to correspond to the known type components.

### Non-default output

Fortran does have a facility to allow the programmer to override the default
behaviour of the formatting when a derived type appears in an io-list.

A special `dt` editor descriptor exists, of the form:
```
  dt[iodesc-string][(v-list)]
```
For example we may have
```
  dt" my-type: "(2,14)
```
The _iodesc-string_ and _v-list_ will re-appear as arguments to
a special function which must be provided by the programmer.
Information on this function is provided as part of the _procedure-part_
of the type definition:
```
type, public :: my_type
  integer :: n
  complex :: z
contains
  procedure :: my_type_write_formatted
  generic   :: write(formatted) => my_type_write_formatted
end type my_type
```
The following module subroutine should then be provided:
```
  subroutine my_type_write_formatted(self, unit, iotype, vlist, iostat, iomsg)

    class (my_type),     intent(in)    :: self
    integer,             intent(in)    :: unit
    character (len = *), intent(in)    :: iotype       ! "DT my-type: "
    integer,             intent(in)    :: vlist(:)     ! (2,14)
    integer,             intent(out)   :: iostat
    character (len = *), intent(inout) :: iomsg

    ! ... process arguments to give required output to unit number ...
    ! iotype is "LISTDIRECTED" for list directed io
    ! iotype is "DTdesc-string" for dt edit descriptor
    ! ...
    ! ... write (unit = unit, fmt = ...)  self%n, self%z

    ! iostat and iomsg should be set if there is an error

end subroutine my_type_write_formatted
```

### Exercise (15 minutes)

In section 3.03 we implemented the tri-diagonal solver as a module
procedure. Implement a derived type to hold the relevant data for the
tri-diagonal matrix, ie., at least the three diagonals.

Define a function which returns a fully initialised matrix type based
on arrays holding the three diagonals. Refactor the solver routine to
use the new matrix type.

Additional exercise: A very simple tridiagonal matrix may have all
diagonal elements the same, and all off-diagonal elements the same.
Write an additional function to initialise such a matrix from two
scalar values.

Additional exercise: if we are conscientious in the memory management
for such a structure, what should we also provide?

A template for the exercise (a solution to the exercise of section3.03) can
be found in `exercise_program.f90` and `exercise_module.f90`; or you
can use your own version.

### Exercise (optional)

Try implementing the generic `write(formatted)` function for the following
type:
```
  type, public :: my_date
    integer :: day = 1        ! day 1-31
    integer :: month = 1      ! month 1-12
    integer :: year = 1900    ! year
  end type my_date
```
The format we would like is `dd/mm/yyyy` e.g, `01/12/1999` for 1st December 1999
for list directed I/O. Then try the `dt` edit descriptor to allow some more
flexibility.
