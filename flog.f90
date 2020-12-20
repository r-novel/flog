module logger
  character (*), parameter :: GREEN = '[1;32m'
  character (*), parameter :: MAGENTA = '[1;35m'
  character (*), parameter :: ORANGE = '[1;38;05;214m'
  character (*), parameter :: CYAN = '[1;36m'
  character (*), parameter :: RED = '[1;31m'
  character (*), parameter :: BLUE = '[1;94m'
  character (*), parameter :: RESET = '[0m'

  character (*), parameter :: PREFIX_FATAL = '[f] '
  character (*), parameter :: PREFIX_ERROR = '[e] '
  character (*), parameter :: PREFIX_WARN = '[w] '
  character (*), parameter :: PREFIX_INFO = '[i] '
  character (*), parameter :: PREFIX_DEBUG = '[d] '
  character (*), parameter :: PREFIX_TRACE = '[t] '

  integer, public, parameter :: FATAL = 1
  integer, public, parameter :: ERROR = 2
  integer, public, parameter :: WARN = 3
  integer, public, parameter :: INFO = 4
  integer, public, parameter :: DEBUG = 5
  integer, public, parameter :: TRACE = 6

  ! fortran no va args;
  contains
  subroutine log(level, single_arg)
    implicit none
    integer, intent(in) :: level
    character(len=*), intent(in) :: single_arg
    character(len=*), parameter :: ESC = achar(27)

    ! time
    character(25) :: datetime
    character(8)  :: date
    character(10) :: time
    character(5)  :: zone

    call date_and_time(date, time, zone)
    write(datetime, '("[",a,"/",a,"/",a," ",a,":",a,":",a,".",a,"]")') date(1:4), date(5:6), date(7:8), &
      time(1:2), time(3:4), time(5:6), time(8:10)

    select case (level)
      case (FATAL)
        write (*, '(a)', advance='no') ESC // MAGENTA // datetime // PREFIX_FATAL // single_arg &
        // ESC // RESET // NEW_LINE('(a)')
      case (ERROR)
        write (*, '(a)', advance='no') ESC // RED // datetime // PREFIX_ERROR // single_arg &
        // ESC // RESET // NEW_LINE('(a)')
      case (WARN)
        write (*, '(a)', advance='no') ESC // ORANGE // datetime // PREFIX_WARN // single_arg &
        // ESC // RESET // NEW_LINE('(a)')
      case (INFO)
        write (*, '(a)', advance='no') ESC // GREEN // datetime // PREFIX_INFO // single_arg &
        // ESC // RESET // NEW_LINE('(a)')
      case (DEBUG)
        write (*, '(a)', advance='no') ESC // BLUE // datetime // PREFIX_DEBUG // single_arg &
        // ESC // RESET // NEW_LINE('(a)')
      case (TRACE)
        write (*, '(a)', advance='no') ESC // CYAN // datetime // PREFIX_TRACE // single_arg &
        // ESC // RESET // NEW_LINE('(a)')
      case default
    end select
  end subroutine log

end module logger
