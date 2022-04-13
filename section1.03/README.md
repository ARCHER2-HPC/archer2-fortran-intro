# Logical and character variables

Fortran provides two non-numeric intrinsic data types: `logical` and
`character`.

## Logical variables

Fortran has a `logical` type (cf. Boolean type in C); there are two relevant
literal values, illustrated here:
```
  logical :: switch0 = .false.
  logical :: switch1 = .true.
```
It is possible to specify a kind type parameter for logical kinds, but you
don't see it very often. The default `logical` kind has kind type parameter
`kind(.false.)`.


### Logical operators and expressions

Standard logical operators `.or.`, `.and.` and `.not.` are available. The
precedence is illustrated by, e.g.,
```
  q = i .or. j .and. .not. k    ! evaluated as i .or. (j .and. (.not. k))
```
Again, use parentheses to avoid ambiguity, or to add clarity.


### Relational operators

To form logical expressions from numeric or other expressions, we require
relational operators. The are two forms in Fortran:

| Relation                 | Operator | Older form | For              |
|--------------------------|----------|------------|------------------|
| Less than                | `< `     | `.lt.`     | `integer` `real` |
| Less than or equal to    | `<=`     | `.le.`     | `integer` `real` |
| Greater than             | `> `     | `.gt.`     | `integer` `real` |
| Greater than or equal to | `>=`     | `.ge.`     | `integer` `real` |
| Equal to                 | `==`     | `.eq.`     | `integer` `real` `complex`|
| Not equal to             | `/=`     | `.neq.`    | `integer` `real` `complex`|

If you are coming from C/C++ don't be tempted by `!=` for inequality.

### Logical equivalence

Equivalence between two logical expressions or variables is established
via the logical operators `.eqv.` and `.neqv.`; do not be tempted to
use `==` for logical equality, although some compilers may let you get
away with it.

## Logic and flow of control

### `if` construct

Conditional statements are provided by the `if` construct, formally:
```
[if-name:]  if (logical-expression) then
              block
            [ else if (logical-expression)
              block ] ...
            [ else
              block ]
            end if [if-name]
```
There may be zero or more `else if` blocks, but at most one `else` block.
At most one block is executed. For example (see `example1.f90`):
```
  if (i < j) then
    print *, "The smaller is: i ", i
  else if (i > j) then
    print *, "The larger is:  i ", i
  else
    print *, "i,j are the same: ", i
  end if
```
A single clause `if` statement is also available, for example:
```
  if (a >= 0.0) b = sqrt(a)
```

### Construct names

A number of control constructs in Fortran include the option to specify
names. This can be useful when highly nested structures are present
and one needs to refer unambiguously to one or other.
A construct name follows the same rules as for variable names.

A `if` construct with a name must have the matching name with the
`end if`.

For example
```
highly_nested_if_construct: if (a < b) then
                              ! ... structured block ...
                            end if highly_nested_if_construct
```
As a matter of style, a leading name can be obtrusive, so one can put
it on a separate line using the continuation character `&`, e.g.,
```
outer_if: &
  if (a < b) then
     ! ... structured block ...
  endif outer_if
```
The standand maximum line length in Fortran is 132 characters. Longer lines can
be broken with the continuation character `&` to a maximum of 255 continuation
lines (F2003).

Finally, note the use of `endif` without a space is not a typo; both forms
with and without a space are acceptable (this is true of a number of Fortran
statements). It's probably preferable to stick to "end if" (at least be
consistent).

### `case` construct

This is an analogue of the C switch facility, and can be useful
for actions conditional on a range or set of distinct values. Formally,
```
[case-name:]  select case (case-expression)
                [ case (case-value-range-list)
		    block ] ...
		[ case default
		    block ]
              end select case [case-name]
		
```
The _case-expression_ must be a scalar integer, logical, or character
expression. The _case-value-range-list_ is a comma-separated list of
either individual values, or ranges.

For example:
```
   integer :: mycard = 1         ! Playing cards 1--13

   select case (mycard)
     case (1)
       ! Action for ace ...
     case (2:10)
       ! Action for other card ...
     case (11, 12, 13)
       ! Court card ...
     case default
       ! error...?
   end select case
```
A range may be open-ended (e.g., `2:` or `:10`). Note there is no break-like
statement as in the C switch; only the relevant case block is executed.


## Character variables

Character variables hold zero or more characters. Some examples are:
```
program example2

  implciit none
  character (len = *), parameter :: string1 = "don't"   ! 5 characters
  character (len = 5)            :: string2 = "Don""t"  ! 5 characters
  character (len = 6)            :: string3 = 'don''t'  ! 5 characters + blank

end program example2
```
The implementation must provide at least one type of character storage,
with the default kind being `kind('A')`. In practice, kind type
parameters are not often specifiied. However, there should be a `len`
specifer.

There is, again, a certain elasticity in the form of the declaration, so
you may see slightly different things.

Strings may be concatenated with the string concatenation operator `//`;
a single character, or a subset of characters, can be extracted via
use of an array-index like notation e.g., `string(1:2)`.

We will return to character variables in more detail when we consider
strings in a later section.

## Exercise (1 minute)

Compile and check the output of `example2.f90` to see the result of
the examples above. What happens if the `len` specification is too
short?


## Exercise (5 minutes)

Write a program which uses real data types to compute the two solutions
to the quadratic equation:
```
   a*x**2 + b*x + c = 0
```
for given values of `a`, `b`, and `c`.
See https://en.wikipedia.org/wiki/Quadratic_formula

A template `exercise1.f90` provides some instructions.
