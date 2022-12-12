program exercise2

  ! A program to identify prime numbers (<= nmax = 120) via th Sieve
  ! of Eratosthenses.

  ! See, e.g., https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
  !
  ! Define a logical array to indicate where relevant integers are
  ! prime.
  !
  ! Implement the sieve to set appropriate values in the logical array
  ! using the algorithm described at the reference above.
  !
  ! Try using loops first; where could you then introduce array
  ! constructs?
  ! Hint. You will need an additional integer array to hold the values
  ! themselves in order to use array constructs.
  !
  ! Count how many prime numbers you have. Check your results.
  !
  ! Is one version any clearer than the other?

  implicit none

  integer, parameter :: nmax = 120
  integer, dimension(2:nmax) :: ia
  logical, dimension(2:nmax) :: isprime

  integer :: n, p

  do n = 2, nmax
     ia(n) = n
     isprime(n) = .true.
  end do

  do p = 2, nmax
     do n = 2*p, nmax
        if (mod(n,p) == 0) isprime(n) = .false.
     end do
     ! One could use an array construct...
     !where (mod(ia(2*p:), p) == 0)
     !   isprime(2*p:) = .false.
     !end where
  end do

  ! Results

  do n = 2, nmax
     print *, "n is prime: ", ia(n), isprime(n)
  end do

  print *, "Number of primes: ", count(isprime)

end program exercise2
