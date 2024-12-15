program hello
implicit none

!	type Testcase
!		integer :: targ
!		integer,dimension(:), allocatable :: v
!	end type
!
!	type(Testcase) :: testcase

	call read_file("test.in")

contains

subroutine read_file(filename)
	character(len=*), intent(in) :: filename
	character(64) :: linha
	integer :: iounit, eof

    open(unit=iounit, file=filename, status='old', action='read', iostat=eof)
    if (eof /= 0) then
        print *, 'Error opening file:', filename
        stop
    end if

	do
		read(iounit, '(A)', iostat=eof) linha
		if (eof /= 0) exit
		call extract_numbers(linha)
	end do
	close(iounit)
end subroutine read_file

subroutine extract_numbers(line)
	character(len=*),intent(in) :: line
	character(len=64) :: temp
	integer :: colon_pos,targ
	integer :: nums(1000)
	
	
	colon_pos = index(line,":")
	read(line(1:colon_pos-1),*) targ
	temp = adjustl(line(colon_pos+1:))
	print *, 'targ',targ
	
	call parse_nums(temp, nums)

end subroutine extract_numbers

subroutine parse_nums(line,array)
	character(len=*),intent(in) :: line
	integer, intent(out) :: array(*)
	integer :: i=0,stat
	do i=1, size(array)
		read(line, *, iostat=stat) array(i)
		if(stat /= 0) exit
		line = adjustl(line(len_trim(array(i)) + 1:))
	end do

	print *, "nums",line
end subroutine parse_nums

end program hello
