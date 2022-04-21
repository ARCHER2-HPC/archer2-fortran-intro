
Introduction to Modern Fortran
------------------------------

This course is aimed at users and developers who know how to program,
but have little or no experience in Fortran, and those who may wish to
have a refresher in Fortran.

Fortran (a contraction of Formula Translation) was the first programming
langauge to have a standard (in 1954), but has changed significantly over
the years. More recent standards (the latest being Fortran 2018) come
under the umbrella term "Modern Fortran". Fortran retains very great
significance in many areas of scientific and numerical computing,
particularly for applications such as quantum chemistry, plasmas, and in
numerical weather prediction and climate models.

This course provides an introduction to the basics of writing Fortran.
It will cover basic syntax, variables, expressions and assignments,
flow of control, and introductions to i/o and user-defined types.
Common Fortran idioms are introduced and contrasted with those
available in C-like languages; the course will try to focus on
real usage rather than formal descriptions.

At the end of the course you should be able to understand many Fortran
programs and be confident to start to write well-structured and portable
Fortran. Fortran is a rather "large" language, so it is not possible to
cover all its features in a two day course. Further elements of Fortran
are discussed in the "Intermediate Modern Fortran" course.

Prerequisites: attendees *must* be familiar with the basic concepts of
programming: variables, logic, flow of control, loops, functions and
so on. No knowledge of Fortran is assumed. Previous programming
experience might typically be in the context C/C++ or python.
If you know no programming, we suggest this course on Fortran is not
the place to start.

The course requires a Fortran compiler, for which a local machine or
laptop may be appropriate [1]. If you do not have access to a Fortran
compiler, course training accounts on ARCHER2 will be available which
provide access to various compilers. Use of a text editor will be
required (some may prefer an IDE, but we do not intend to consider or
support IDEs).

[1] This may typically be gfortran, freely available as part of
    Gnu Compiler Collection (GCC).
    See e.g., https://gcc.gnu.org/wiki/GFortranBinaries
    
## Installation

## Timetable

The timetable may shift slightly in terms of content, but we will stick to the
advertised start and finish times, and the break times.

### Day one

| Time  | Content                                                 | Section                    |
|-------|---------------------------------------------------------|----------------------------|
| 09:30 | Logistics: login, compiler set-up, local details        | None                       |
| 10:00 | "Hello World",                                          |                            |
|       | `program`, `print` and `write`, `use`                   | [section1.01](section1.01) |
| 10:20 | Variables: numeric; expressions and assignments, kind   |                            |
|       | `real`, `integer`, `complex`, `parameter`               | [section1.02](section1.02) |
| 10:40 | Variables: logical, character, conditionals             |                            |
|       | `if  .. end if` and `select case`                       | [section1.03](section1.03) |
| 11:00 | Break                                                   |                            |
| 11:30 | Loops and flow of control                               |                            |
|       | `do .. end do`, `exit` and `cycle`                      | [section2.01](section2.01) |
| 11:50 | Array declarations: rank, bounds, size and shape        |                            |
|       | `dimension`, `allocatable`, `allocate()`, `reshape()`   | [section2.02](section2.02) |
| 12:10 | Array expressions: sections, conformance, masks         |                            |
|       | `minval()` etc.; `where .. end where`; `any()` `all()`  | [section2.03](section2.03) |
| 12:30 | Mini-exercise: solve a tri-diagonal system              |                            |
|       |                                                         | [section2.04](section2.04) |
| 13:00 | Lunch                                                   |                            |
| 14:00 | Modules and compilation of modules; scope               |                            |
|       | `module .. contains .. end module`; `public`, `private` | [section3.01](section3.01) |
| 14:20 | Functions and subroutines; dummy argument intent        |                            |
|       | `function` `result()` `subroutine` `intent` ...         | [section3.02](section3.02) |
| 14:40 | More on array dummy arguments; assumed shape, ...       |                            |
|       | `lbound()`, `ubound()`                                  | [section3.03](section3.03) |
| 15:00 | Break                                                   |                            |
| 15:30 | More on characters and strings; deferred length         |                            |
|       | `len()` `len_trim()`, `trim()`                          | [section4.01](section4.01) |
| 15:50 | Format strings and edit descriptors                     |                            |
|       | `read` and `write`                                      | [section4.02](section4.02) |
| 16:10 | I/O and files; recovering from errors, or not           |                            |
|       | `open` `close` `inquire` `stop`                         | [section4.03](section4.03) |
| 16:30 | Finish                                                  |                            |

### Day two

| Time  | Content                                                 | Section                    |
|-------|---------------------------------------------------------|----------------------------|
| 09:30 | Data structures                                         |                            |
| 09:30 | `type .. end type`                                      |                            |
| 10:00 | Pointer attribute and targets                           |                            |
|       | `pointer`, `null()`, `associated()`                     |                            |
| 11:00 | Break                                                   |                            |
| 11:30 | Functions: interface blocks, limited polymorphism ...   |                            |
|       | `interface`, `module procedure`                         |                            |
| 13:00 | Lunch                                                   |                            |
| 14:00 | Exercises                                               |                            |
| 15:00 | Break                                                   |                            |
| 15:30 | Exercises / solutions                                   |                            |
| 16:00 | Other things you may see; tools; resources              |                            |
| 16:30 | Finish                                                  |                            |
