! ʹ�����η��������
    module INTEGRAL
    implicit none 
        real, parameter :: PI = 3.1415926
    contains
        ! ������ɢ�ĵ�����
        subroutine GenerateData(sample, lower, upper, func)
        implicit none
            real, intent(inout) :: sample(:)
            real, intent(in) :: lower, upper ! �������½�
            real, external :: func           ! ��������
            real :: r, width
            integer :: i, n
            n = size(sample, 1)
            width = (upper-lower) / (n-1)
            r = lower
            do i=1, n
                sample(i) = func(r)
                r = r + width
            end do
            return
        end subroutine
        ! ʹ�����η��������
        real function Trape_Integral(sample, lower, upper)
        implicit none
            real, intent(inout) :: sample(:)
            real, intent(in) :: lower, upper
            real :: width
            real :: sum = 0
            integer :: i, n
            n = size(sample, 1)
            width = (upper - lower) / (n - 1)
            do i=1, n-1
                sum = sum + (sample(i) + sample(i+1))*width/2 ! �����������
            end do
            Trape_Integral = sum
            return 
        end function
    end module
    
    program main
    use INTEGRAL
    implicit none
        real :: sample(10000001) ! �ƻ���ȡ10000001����
        real :: upper = PI
        real :: lower = 0
        real :: ans
        real, intrinsic :: sin
        call GenerateData(sample, lower, upper, sin) !����0��PI��sin�Ļ���
        ans = Trape_Integral(sample, lower, upper)
        write(*, "(A6, F20.12)") 'ans=', ans
    end program
    
    ! ��������  ans=      2.000000000000