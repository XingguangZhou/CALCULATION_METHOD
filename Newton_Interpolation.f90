! ţ�ٲ�ֵ��
! ������ο���Fortran95 ������ơ� ����� ��
    module INTERPOLATE_UTILITY
    implicit none
        type point
            real x, y
        end type
        real, parameter :: PI = 3.1415926
        real, parameter :: xmin = 0.0
        real, parameter :: xmax = PI * 3.0
        integer, parameter :: N = 10
        type(point), save :: datas(N)
        real, save :: table(N, N), width
    contains
        ! �������ݵ�
        subroutine GenerateData(func)
        implicit none
            real, external :: func
            real r
            integer i
            width = (xmax-xmin) / (N-1)
            r = 0
            do i=1, N
                datas(i)%x = r
                datas(i)%y = func(r)
                r = r + width
            end do
            return 
        end subroutine
        ! ����difference table
        subroutine BuildTable()
        implicit none
            integer row, col, i
            table = 0
            do i=1, N
                table(i, 1) = datas(i)%y
            end do
            do col=2, N
                do row=1, N-col+1
                    table(row, col) = table(row+1, col-1) - table(row, col-1)
                end do
            end do
            return 
        end subroutine
        ! ��ʼ����ţ�ٷ���ֵ
        real function newton(x, th, num)
        implicit none
            real x 
            integer th, num
            real s, sum, coeff
            integer f, i, j
            
            if(th+num-1>N) then
                write(*, *) "���ݵ㲻�㣡"
                return 
            end if
            
            newton = table(th, 1)
            s = (x-datas(th)%x) / width
            f = 1
            coeff=1.0
            do i=1, num-1
                f = f*i
                coeff = coeff*(s-i+1)
                newton = newton + coeff*table(th, i+1) / real(f)
            end do
            return 
        end function
    end module
    
    program main
    use INTERPOLATE_UTILITY
    implicit none
        real, intrinsic :: sin
        real xinc, x
        integer i
        call GenerateData(sin)
        call BuildTable()
        ! ��ֵsin(PI/2)��ֵ
        write(*, *) newton(PI/2, 1, N)
        ! ��ֵsin(PI/4)��ֵ
        write(*, *) newton(PI/4, 1, N)
    end program
! ���н���� 
!         0.9983025
!         0.7110158
!         �밴���������. . . 