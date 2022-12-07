# Things you may see

## Not covered in this course

The Fortran standard covers a large and increasing number of features.
Some of these we have only tocuhed on, and others not mentioned at all.

* Object-oriented features: type extension, abstract classes/interfaces, ...
* Interoperability with C
* Support for IEEE floating point arithmetic
* Coarrays


## Things you may see

### Old stuff

Don't panic! Consult a reference to see what is happening.

May include:
* old-style declarations `real*4` `real*8` etc.
* Namelists `&nlist var1 = 1 var2 = 3 /`

Some features are formally _obsolescent_, in which case the compiler
should give a warning. There should be a more modern ("better") way
doing the same thing. Obsolescent features  will be _deleted_ at
some point in the future.

### Preprocessor

The processing of Fortran is not standardised in the same way as the
C-preprocessor is part of the C standard.

However, it is very common to see preprocessor directives for
conditional compilation, and other preprocessor features. E.g.,
```
#ifdef HAVE_SOME_FEATURE
  ...
#endif
```

As the Fortran preprocessor is not standardised, some care may be
required to ensure portability. For example, stringification of
macro arguments can be problematic.

An additional compiler flag may be required to switch on the preprossor
explicitly. Alternatively, it is common that compilers will automatically
run the preprocessor if the file extension has a capital letter e.g.,
`.F90`, `.F03`, and so on.


## Parallelism

### `where`, `forall`

Fortran has introduced a number of constructs which are intended to
allow the expression of parallelism.

While the standard allows these, and all compilers should inplement
them correctly, few compilers actually introduce any parallelism.

Loops are a perfectly good solution.


### Message passing interface

The message passing interface provides a standard interface for
distributed memory computing.

MPI makes use of a number of data types, macro definitions, and
library subroutines. A modern program might introduce the information
required via
```
  use mpi_f08
```
which uses derived types for data types (which are often opaque).

Earlier versions might use
```
  use mpi
```
where the opaque types are integer handles.

Older codes may even use
```
#include 'mpif.h'
```
to make the necessary handles and macros available.


### MPI library calls

MPI is at base a C interface which accommodates Fortran. The C routines
often have prototypes of the form:
```
  int MPI_Send(const void * buf, int ount, MPI_Datatype dt, int dest, int tag,
               MPI_Comm comm);
```
The data to be sent is identified here using `void * buf`. A return code
provides an error status.

The lack of `void *` in Fortran means that the Fortran API, formally, has
been on a rather shaky foundation for a long time. This is being addressed
in the most recent standards.

In particular, the use of array sections as the `buf` argument might prove
problematic and should probably be avoided. It is also preferable for the
application to marshall data into a contguous buffer for performance
reasons.

In modern versions, the error return code in Fortran are optional integer
arguments.


### OpenMP

OpenMP is a standard way to introduce thread-level parallelism
(typically at the level of loops). A program should
```
  use omp_lib
```
to provide OpenMP functions and kind type parameters.

OpenMP is largely based around compiler directives, which are switched on
via a compiler option, usually `-fopenmp`.

In Fortran, the directives are introduced by the _sentinels_:
```
  !$omp ...
  ...
  !$omp end ...
```
which is ignored as a comment if no OpenMP is required
(cf. `#pragma omp ... { }` in C).

The OpenMP standard documents provide a useful `stub` implementation
which can be used in place of the real implementation when compiling
without OpenMP. This prevents a profileration of conditional
compilation directives.


### GPU programming


The GPU programming model of choice for Fortran has probably been
OpenACC to the present time.

NVIDIA support an Fortran extension CUDA Fortran, which is not
portable.

The OpenMP standard also has support for GPU offload, but the status
of compiler implementations is in flux.


## Testing

Testing is an important consideration in modern software
enginerring. A number of unit test frameworks exist:

* pFUnit https://github.com/Goddard-Fortran-Ecosystem/pFUnit

Some others are mentioned at the Fortran wiki
https://fortranwiki.org/fortran/show/Unit+testing+frameworks


## Resources

The standard reference is "Modern Fortran explained" by Metcalf, Reid,
and Cohen (Oxford University Press).

The latest version is "Modern Fortran explained: Incorporating Fortran 2018"
(2018).

The Fortran wiki also has quite a lot of material
https://fortranwiki.org/fortran/show/HomePage
