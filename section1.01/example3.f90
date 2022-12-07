program hello_write

  ! A use statement imports public symbols from the "iso_fortran_env"
  ! module. This is an "intrinsic" module which must be provided
  ! by the implementation.

  ! One can limit the symbols actually imported via the "only" clause.
  ! Here we want "output_unit"; there are also (almost other things)
  ! "input_unit" and "error_unit".

  ! See e.g., https://fortranwiki.org/fortran/show/iso_fortran_env

  use iso_fortran_env, only : output_unit

  write (output_unit, *) "Hello world"

  ! The write statement here has two arguments in parenthesis
  ! stdout        the "unit number" here the standard output
  ! an asterisk   again indicating a free format

  ! You may sometimes see ...

  write (unit = output_unit, fmt = *) "Hello again"

end program hello_write
