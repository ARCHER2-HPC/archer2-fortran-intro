# Operations on external files

Writing data to, or reading data from, an external file is a essential
part of a useful application.


## Writing a file

File handles, or _unit numbers_ are obtained using `open()`, and are
used to direct the output of `write()` to the relevant file.
```
  integer :: myunit

  open(newunit = myunit, file = 'filename.dat', form = 'formatted', &
       action = 'write', status = 'new')

  write(unit = myunit, *) data1    ! write data first record
  write(unit = myunit, *) data2    ! second record ... and so on

  close(unit = myunit, status = 'keep')
```
To read back the same data, we might use:
```
   open(newunit = myunit, file = 'filename.dat', form = 'formatted', &
        action = "read", status = "old")

   read(unit = myunit, *) data1
   read(unit = myunit, *) data2

   close (unit = myunit, status = 'keep')
```

### Unit numbers

A valid unit number can be assigned by using the `newunit` option to
`open()`. There is no need to choose your own (and it can be error-prone
to do so). (F2008).

Note that a given file can only be _connected_ to one unit number at
any given time.

### `open()`

The arguments seen above include:
* `file`: literal string or character variable or expression with the name of
the file in the file system;
* `form`: `formatted` or `unformatted`;
* `action`: `read`, `write` or `readwrite`. An error may occur if inappropriate actions are performed;
* `status`: one of `old`, `new`, `replace`, `scratch`, or `unknown`.

A file with status `old` is expected to exist, while an attempt to create a
`new` file when one already exists with the same name will result in an error.
If `replace` is specified, any existing file will be overwritten by a new
file. If `scratch` is specified, a temporary file is created which will
be deleted when `close()` is executed (or at the end of the program).
The system will automatically choose a name for a scratch file if no
`file` argument is present. The default status is `unknown`, which
means the status is system dependent.

Formally, only the unit number is mandatory (and must appear first), but
there is no reason not to provide as much information as possible.

### `close()`
The unit number is again mandatory. The `status` is either `keep` or
`delete`. If the status is omitted, the default is `keep`, except for
scratch files.

## `inquire()`

The `inquire` statement offers a way to obtain information on the
current state of either unit numbers or files. There are a large
number of optional arguments. One common usage is to check whether
a file exists:
```
  logical :: exists
  inquire( file = 'filename.dat', exist = exists)
```

## Internal files

In some situations, it may be convient to use a formatted read to
generate a new string in memory (in the same way as `sprintf` in C).
Fortran uses a so-called _internal file_, which is usually a
character string. E.g.,
```
   character (len = 10) :: buffer
   integer              :: ival
   ...
   read(buffer, fmt = "i10") ival
```
Here `buffer` takes the place of the input unit. This can be used, e.g.,
to create format strings at run time.

## Recovery from errors

Operations on external files can be error-prone. While there is no
formal exception mechanism in Fortran, some ability to recover is
available.

Consider the following schematic example:
```
subroutine read_my_file_format(myunit, ..., ierr)

  integer, intent(in)   :: myunit
  integer, intent(out)  :: ierr          ! error code

  character (len = 256) :: msg

  read (myunit, ..., err = 999, iomsg = msg) ...

  ! Everything was ok
  ierr = 0
  return

999 continue
  ierr = -1
  print *, "Error reading file: ", trim(msg)

  return
end subroutine real_my_file_format
```
We assume the relevant file has been opened successfully, and is
connected to unit number `myunit`. If an error occurs at the
point of the read statement, the `err` argument directs control
to be transferred to the statement will label `999`. In this
case the system should provide a meaningful message describing the
error.

If the read is successful, the routine completes at the first return
statement with intent out `ierr = 0`.

### Error handling for `open()` and `close()`

Both `open` and `close` statements provide optional arguments for
error handling, illustrated schematically here with `open()`:
```
  integer :: ierr
  character (len = 128) :: msg

  open( newunit = myunit, ..., err = 900, iostat = ierr, iomsg = msg)
```
* `err`: is a label in the same scope to which control is transferred on error;
* `iostat`: an integer variable which is zero on success but positive if an error has occurred;
* `iomsg`: if an error occurs, a system-dependent message will be assigned to `msg`.

If neither `err` nor `iostat` arguments are present, then an error may
result in immediate termination of the program.

The variable `msg` should be a scalar character variable; the message will be
truncated or padded appropriately.

### Error handling for `read()` and `write()`

Error handling facilities for `read()` and `write()` are similar, and
are illustrated here:
```
  write (myunit, myformat, end = 999, err = 998, iostat = ierr, iomsg = msg) ..
```
* `end`: label in same scope to which control is transferred on end-of-file;
* `err`: label in same scope to which control is transferred on any other error; the label may be the same as `end`;
* `iostat`: the integer error code is negative if end-of-record or end-of-file, or positive if another error (e.g., bad format conversion) or zero on success;
* `iomsg`: should return a useful message on error.

The two negative `iostat` cases can be distinguished via calls to
the intrinsic functions
```
  is_iostat_end(ierr)
  is_iostat_eor(ierr)
```

## `stop` statement

If one really can't continue, then execution can be terminated immediately
via the `stop` statement. This has an optional message string argument.
```
  stop "Cannot continue"
```
In general one should try to recover by returning control to the caller,
so `stop` is a last resort.

## Moving around an open file

It is sometimes useful to be able to reposition oneself in an open file
so that a given record can be read (or written) more than once. This
can be done using `backspace()` with the relevant unit number. Formally
```
  backspace([unit = ] unit-number [, iostat = iostat] [, err = label])
```
This steps back one record.

It is also possible to reposition to the beginning of the file, again
with the relevant connected unit number using `rewind()`.
```
  rewind([unit = ] unit-number [, iostat = iostat] [, err = label])
```


## Exercise (20 minutes)

Portable bit map (PBM, PGM, PPM) is a very simple image format which can be
expressed as an ASCII file.

See the description at https://en.wikipedia.org/wiki/Netpbm.

In the template `program1.f90`, we establish a two-dimensional logical array
of a fixed size, and we want to write out a file that can be viewed in
"P1" format (file extension `.pbm` ) by an image viewer.

The data is initialised with a suitable pattern to check that the image
is correct (it is the right way up and is not a mirror). A little care
is required in the rows and columns (look closely at the example).

Provide a module with the subroutine `write_pbm()` with three arguments
as in the template program. Note the template program expects a module
`solution_module`.

Additional exercises: repeat for integer data (to "P2" format `.pgm`)
and floating point data (to "P3" format `.ppm`).

A solution to this problem appears in [section6.03](./section6.03).
