# Pointers and targets

Pointers are extremely useful for certain types of operations: they
provide a way to refer indirectly to other variables or names
(they act as an _alias_), or can be used for establishing dynamic
data structures.

## Pointer attribute

A pointer may be declared by added the `pointer` attribute to
the relevant data type, e.g., 
```
integer, pointer :: p => null()
```
In this case we declare a pointer to integer `p`, which is initialised to
the special value `null()`. The pointer is said to be _unassociated_.
This is a different state to _undefined_ (ie., without initialisation).

Note that pointer assignment uses `=>` and not `=`. A common cause of
errors is to forget the `>` if pointer assignment is wanted.

It is important to be able to check that a given pointer is not `null()`.
This is done with the `associated()` intrinsic; schematically,
```
   integer, pointer :: p => null()
   ...
   if (associated(p)) ... do something
```
Otherwise, pointers may be used in expressions and assignments in the usual
way.

If one wishes to have a pointer to an array, the rank of the pointer
should be the same as the target:
```
  real, dimension(:),   pointer :: p1
  real, dimension(:,:), pointer :: p2
```
and so on.


## Targets

A pointer may be assoicated with another variable of the appropriate
type (which is not itself a pointer) by using the target attribute:
```
  integer, target  :: datum
  integer, pointer :: p

  p => datum
```
The pointer is now said to be associated with the target. We can now
perform operations on `datum` vicariously through `p`. E.g., a
standard assignment would be
```
  integer, target  :: datum = 1
  integer, pointer :: p

  p => datum     ! pointer assignment
  p = 2          ! normal assignment
```
leaves us with `datum = 2`. There is no deferencing in the C fashion;
the data is moved as the result of the normal assignment.

The target attribute is there to provide information to the compiler
about which variables may be, and which variables may not be,
associated with a pointer. This somewhat in the same spirit as the
C `restrict` qualifier.

Note that there is an optional _target_ argument to the `associated()`
intrinsic, which allows the programmer to inquire whether a pointer
is associated with a specfic target, e.g.,
```
   associated(p, target = datum)   ! .true. following the code above
```

### Exercise (2 minutes)

Try to compile the accompanying `example1.f90`, which is an erroneous
version of the code above. See what compiler message you get (if any).
Fix the problem.

Check you can use the `associated()` function to print out the status
of `p` before and after the pointer assignment.


### Pointers as aliases

One common use of pointers is to provide a temporary alias to another
variable (where no copying takes place). As a convenience, one can
use the `associate` construct, e.g.:
```
  real :: improbably_or_tediously_long_variable_name
  ...
  associate(p => improbably_or_tediously_long_variable_name)
     ! ... lots of operations involving p ...
  end associate
```
Note that there is no requirement here to have the `target` attribute
in the original declaration (a there's no explicit declaration of `p`).
Any update to `p` in the associate block will be reflected in the
target on exit.

### Exercise (2 minutes)

Compile, and check the output of the accompanying `example2.f90`.


## Pointers to establish storage

One common use of pointers is for linked data structures. For example,
an entry in a linked list might be represented by the type
```
  type :: my_node
    integer                 :: datum
    type (my_node), pointer :: next
  end type my_node
```
This sort of dynamic data structure requires that we establish or
destroy storage as entries are added to the list, or removed from
the list.

```
  subroutine my_list_add_node(head, datum)

    ! Insert new datum at head of list

    type (my_node), pointer, intent(inout) :: head
    integer,                 intent(in)    :: datum

    type (my_node), pointer :: pnode

    allocate(pnode)       ! assume no error
    pnode%datum = datum
    pnode%next => head
    head => pnode

  end subroutine my_list_add_node
```

### Pointer or allocatable array?

The question may now arise: should you use pointers or allocatable arrays?
If you just want to establish storage for arrays, the answer is almost
certainly that you should use `allocatable`. An allocatable array will
almost certainly be held contiguously in memory, whereas pointers are
a more general data structure which may have to accommodate a stride.

If an allocatable array is not appropriate, then a pointer may be
required.

If you just require a temporary alias, the `associate` construct is
recommended.

## Reallocating array storage

If one needs to increase (or decrease) the size of an existing
allocatable array, the `move_alloc()` intrinsic is useful. E.g.,
if we have an integer rank one array
```
  integer, dimension(:), allocatable :: iorig
```
and establish storage of a given size, and some relevant initialisations,
we may then wish to increase the size of it.
```
  integer :: nold
  integer, dimension(:), allocatable :: itmp

  nold = size(iorig)
  allocate(itmp(2*nold))           ! double size; assume no error
  itmp(1:nold) = iorig(1:nold)     ! copy existing contents explicitly
  call move_alloc(itmp, iorig)

  ! ... itmp deallocated, iorig now twice as big
```
This minimises the number of copies involved in re-assigning the
original storage.

### Arrays of pointers

A small trick is required to arrange an array of pointers. Recall that
```
  real, dimension(:), pointer :: a
```
is a pointer to a rank one array. If one wanted an array of such
objects, it can be achieved by wrapping it in a type:
```
  type :: pointer_rr1
    real, dimension(:), pointer :: p => null()
  end type pointer_rr1

  type (pointer_rr1), dimension(10) :: a

  a(1)%p => null()
```
So `a` is a rank one array of the new type, the target of each of which
should be a rank one array section of type `real`.

## Exercise (2 minutes)

A thought exercise. How many copies would be required if `move_alloc()`
was not available when enlarging the size of an existing allocatable
array?



