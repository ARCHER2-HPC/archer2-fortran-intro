# Miscellaneous

There a a number of features which have not been covered so far, but
are useful in certain contexts.

## Interacting with the environment

### Command line arguments

If you wish to write a program which makes use of command line arguments,
or simply wish to know the executable name at run time, the command line
can be retrieved.

The number of command line arguments is returned by the function
```
command_argument_count()
```
This returns an `integer`: zero if the information is not available,
or the number of arguments _not including_ the executable name itself.

The entire command line can be retrieved as a string via
```
  call get_command(command = cmd, length = len, status = stat)
```
This returns the command line as a string (truncated or padded with spaces
as appropriate), the integer length of the command line string, and an
integer status which will be non-zero if the information is not available.
All the arguments are optional.

Individual command line arguments based on their position can be retrieved
using the subroutine
```
  subroutine get_command_argument(position, value, length, status)
    integer,                       intent(in)  :: position
    character (len = *), optional, intent(out) :: value
    integer,             optional, intent(out) :: length
    integer,             optional, intent(out) :: status
```
Here, `position` is zero for the (executable) command itself and positive
for others. The remaining arguments are: `value` is the command; length is
the length of the command, and `istat` returns 0 on success, -ve if the
`arg` string is too short, or +ve if the information is not available.

### Environment variables

A similar routine exists for inquiry about environment variables
```
subroutine get_environment_varaible(name, value, length, status, trim_name)
  character (len = *),           intent(in)  :: name
  character (len = *), optional, intent(out) :: value
  integer,             optional, intent(out) :: length
  integer,             optional, intent(out) :: status
  logical,             optional, intent(in)  :: trim_name
```
This will return the value associated with the given name if it exists.
Various non-zero `status` error conditions can occur, including a value
of `1` if the variable does not exist, or `-1` if the value is present,
but is too long to fit in the string provided.


### System commands

It is sometimes useful to pass control of execution back to the operating
system so that some other command can be used.
```
subroutine execute_command_line(command, wait, iexit, icmd, cmdmsg)

  character (len = *),           intent(in)    :: command
  logical,             optional, intent(in)    :: wait
  integer,             optional, intent(inout) :: iexit
  integer,             optional, intent(out)   :: icmd
  character (len = *), optional, intent(inout) :: cmdmsg

```
The command should be a string. The `wait` argument tells the routine to
return only when the command has finishing executing.
The `iexit` gives the return value of the command.
The `icmd` argument returns a positive value if the command fails to execute
(e.g., the command was not found), or negative if execution is not supported,
or zero on successful execution. An informative message should be returned in
`cmdmsg` if `icmd` is positive.

It is recommended to use `wait = .true.` always. Portable programs should
use system commands with extreme caution, or not at all.


### Time and date from `date_and_time()`

Use, e.g.,
```
  character (len = 8)   :: date        ! "yyyymmdd"
  character (len = 10)  :: time        ! "hhmmss.sss"
  character (len = 5)   :: zone        ! "shhmm"
  integer, dimension(8) :: ivalues     ! see below

  call date_and_time(date = date, time = time, zone = zone, values = ivalues)
```
All the arguments are optional. On return the `date` holds the year, month,
and day in a string of the form "yyyymmdd"; time holds the time in hours,
minutes, seconds, and milliseconds; the time zone is encoded with a sign
(`+` or `-`) and the time difference from Greenwich Mean Time (UTC) in
hours and minutes.

The integer values are: year, month (1-12), day (1-31), time difference in
minutes between local and UTC, hour (0-23), minute (0-59), seconds (0-59),
and milliseconds (0-999).


## Timing pieces of code

If you want to record the time taken to execute a particular section
of code, the `cpu_time()` function can be used. This returns a
`real` positive value which is some system-dependnent time in seconds.
Subtracting two consecutive values will give and elapsed time:
```
   real :: t0, t1

   call cpu_time(t0)
   ! ... code to be timed here ...
   call cpu_time(t1)

   print *, "That piece of code took ", t1-t0, " seconds"
```
In the unlikely event that there is no clock available, a negative
value may be returned from `cpu_time()`.


## Exercise (10 minutes)

Write a program to display the command line arguments of the program.
The arguments should not be truncated.
How can you deal with the fact that the length of the strings is not
known in advance?

Additional exercise.
Write a program to display the date and time in a reasonable format.

Additional exercise.
Try a simple system command, such as `cat README.md`. What can go wrong?
