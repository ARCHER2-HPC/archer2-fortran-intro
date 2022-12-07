# More on characters and strings

String-handling can be a headache if there is no mechanism to keep
track of the length of the string.


## Useful `character` operations

### Relational operators

The meaning of relational operators `==` and so on in the context of
characters is largely what one would expect from the standard ASCII
sequence. E.g.,
```
   "A" <  "b"      ! true
   "A" == "a"      ! false
   "A" /= "]"      ! true
```
Note the ordinal position of a single character in the ASCII sequence
can be found via an intrinsic function, e.g.:
```
   integer             :: i
   character (len = 1) :: c
   i = iachar("A")           ! i = 65
   c = achar(i)              ! c = "A"; requires 1 <= i <= 127
```

If character variables are compared, then each letter is compared
left-to-right until a difference is found (or not). If the variables
have different lengths, then the shorter is padded with blanks.


### Some other intrinsic functions

The length of a character variable is provided by the `len()` intrinsic
function.

The length with trailing blanks removed is `len_trim()`. To actually
remove the trailing blanks, use `trim()`. This is often seen when
concatenating fixed-length character strings:
```
  print *, "File name: ", trim(file_stub)//"."//trim(extension)
```

It's also useful if you want to perform an operation on each individual
character, e.g.,
```
  do n = 1, len_trim(string)
    if (string(n:n) == 'a') counta = counta + 1
  end do
```
Note that the colon is mandatory in a sub-string reference, so a
single character must be referenced, e.g.,
```
   print *, "Character at position i: ", string(i:i)
```

Various other intrinsic functions exist for lexical comparisons,
justification, sub-string searches, and so on.

## Deferred length strings

The easiest way to provide a string which can be manipulated on a
flexible basis is the deferred length character:
```
  character (len = :), allocatable :: string

  string = "ABCD"         ! Allocate and assign string
  string = "ABCDEFG"      ! Reallocate and assign again

  string(:) = ''          ! Keep same allocation, but set all blanks
```
This may be initialised and updated in a general way, and the run time
will keep track of book-keeping. This also (usually) reduces occurrences of
trailing blanks.

If an allocation is required for which only the length is known (e.g.,
there is no literal string involved), the following form of allocation
is required:
```
  integer :: mylen
  character (len = :), allocatable :: string

  ! ... establish value of mylen ...

  allocate(character(len = mylen) :: string)
```

Allocatable strings will automatically be deallocated when they go out
of scope and are no longer required. One can also be explicit:
```
  deallocate(string)
```
if wanted.

## Arrays of strings

We have seen that we can define a fixed length parameter, e.g.,:
```
  character (len = *), parameter :: day = "Sunday"
```
Suppose we wanted an array of strings for "Sunday", "Monday", "Tuesday",
and so on. One might be tempted to try something of the form:
```
  character (len = *), dimension(7), parameter :: days = [ ... ]
```

### Exercise (2 minutes)

Check the result of the compilation of `example3.f90`.

The are a number of solutions to this issue. One could try to pad the
lengths of each array element to be the same length. A better way is
to use a constructor with a type specification:
```
[character (len = 9) :: "Sunday", "Monday", "Tuesday", "Wednesday", ...]
```
Here the type specification is used to avoid ambiguity in how the
list is to be interpreted.

Check you can make this adjustment to `example3.f90`.


## Strings as dummy arguments, or results

If a character variable has intent `in` in the context of a procedure,
it typically may be declared:
```
  subroutine some_character_operation(carg1, ...)

     character (len = *), intent(in) :: arg1
     ...
```
This is also appropriate for character variables of intent `inout`
where the length does not change.

For all other cases, use of deferred length allocable characters is
recommended. E.g.,
```
  function build_filename(stub, extension) result(filename)

    character (len = *), intent(in)  :: stub
    character (len = *), intent(in)  :: extension
    character (len = :), allocatable :: filenane
    ...
```
A matching declaration in the caller is required.

## Exercise (10 minutes)

Write a subroutine which takes an existing string, and adjusts it to
make sure it is all lower case. That is, any character between "A"
and "Z" is replaced by the corresponding character between "a" and "z".

Write an additional function to return a new string which is all
lower case, leaving the original unchanged.

You can use the accompanying templates `exercise_module1.f90` and
`exercise_program1.f90`.
