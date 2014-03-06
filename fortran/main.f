c     Naive implementation of a soundex-like algortihm.
      
      program ZoundX

        type options_t
            logical :: full_length
            logical :: check_equality
            character(64), allocatable :: names(:)
        end type options_t

        integer :: argc, i, j, nc, name_count
        character(64) :: buffer
        character, allocatable :: output(:)
        character(5) :: format
        type (options_t) :: options
        logical :: was_help, is_allocated
        character(64), allocatable :: codes(:)

        argc = command_argument_count()
        nc = 0
        options%full_length = .false.
        options%check_equality = .false.
        was_help = .false.

        print *, 'argc -> ', argc

        j = 1
        do i = 1, argc, 1

            call get_command_argument( i, buffer )

            print *, 'buffer -> ', buffer

            select case( buffer )
                case( '-e', '--equals' )
                    options%check_equality = .true.
                    nc = nc + 1
                case( '-F', '--full-length' )
                    options%full_length = .true.
                    nc = nc + 1
                case( '-h', '--help' )
                    call print_help()
                    was_help = .true.
                    exit
                case default
                    if( .not. is_allocated ) then
                        print '(a)', 'allocating'
                        name_count = argc - nc
                        is_allocated = .true.
                        allocate( options%names( name_count ) )
                    endif
                    print '(a)', 'adding'
                    options%names( j ) = buffer
                    j = j + 1
            end select

        end do

        if( .not. was_help ) then

            allocate( codes( name_count ) )

            do i = 1, name_count
                if( options%full_length ) then
                    j = len( options%names( i ) )
                else
                    j = 4
                endif
                print *, 'encoding with length', j
                call encode( options%names( i ), j, codes( i ) )
            end do

            do i = 1, name_count
                call significant_length( codes( i ), nc )
                print *, codes( i )

            end do

        endif

      end program ZoundX

      ! encodes given string to zoundx code of length n
      subroutine encode( str, n, code )

        character(len = *), intent(in)  :: str
        integer,       intent(in)  :: n
        character*(n), intent(out) :: code

        character(len = len(str))  :: buffer
        character                  :: c
        integer :: i, j, l

        l = len(str)

        ! eliminate all duplicates
        buffer(1:1) = str(1:1)
        j = 1
        do i = 2, l, 1
            c = str(i:i)
            if( buffer(j:j) .ne. c ) then
                j = j + 1
                buffer(j:j) = c
            endif
        end do

        do i = 2, l, 1
            c = buffer(i:i)
            select case( c )
                case( 'a', 'e', 'i', 'o', 'u', 'w', 'h' )
                    buffer(i:i) = '0'
                case( 'b', 'f', 'p', 'v' )
                    buffer(i:i) = '1'
                case( "c", "g", "j", "k", "q", "s", "x", "z" )
                    buffer(i:i) = '2'
                case( "d", "t" )
                    buffer(i:i) = '3'
                case( "l" )
                    buffer(i:i) = '4'
                case( "m", "n" )
                    buffer(i:i) = '5'
                case( "r" )
                    buffer(i:i) = '6'
            end select
        end do

        j = 1
        i = 1
        do while( i < l )
            c = buffer(i:i)
            if( c .eq. '0' .and. (i+1) .lt. l ) then
                if( buffer(i-1:i-1) .eq. buffer(i+1:i+1) ) then
                    i = i + 1
                endif
            else
                code(j:j) = c
                j = j + 1
            endif
            i = i + 1
        end do

        buffer(1:) = code(1:)

        j = 1
        do i = 1, l, 1
            c = buffer(i:i)
            if( .not. c .eq. '0' ) then
                code(j:j) = c
                j = j + 1
            endif
        end do

        code(1:) = code(1:n)

      end subroutine

      subroutine significant_length( str, n )

        character(len = *), intent(in) :: str
        integer, intent(out) :: n

        integer :: i, l

        n = 0
        l = len(str)

        do i = 1, l, 1
            if( str(i:i) .eq. ' ' ) then
                exit
            endif
            n = n + 1
        end do

      end subroutine

      subroutine print_help()

        print '(a)', 'dont be such a noob!'

      end subroutine
