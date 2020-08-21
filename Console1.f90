    module Lagrange_Interpolation
    implicit none
        type :: point
            real :: x
            real :: y
        end type
        real, parameter :: PI = 3.1415926
    contains
        ! ��ȡ�����Ĳ�ֵ��ı�׼ֵ
        subroutine GetSample(datas, func, lower, upper)
        implicit none
            type(point), intent(out) :: datas(:)
            real, external :: func
            real, intent(in) :: lower, upper
            integer :: N, i
            real :: width, r
            N = size(datas, 1)
            r = lower
            width = (upper-lower) / (N-1)
            do i=1, N
                datas(i)%x = r
                datas(i)%y = func(r)
                r = r + width
            end do
            return 
        end subroutine
        ! �����ֵ�������ķ���
        real function MulNumerator(datas, index, unknown)
        implicit none   
            type(point), intent(in) :: datas(:)
            integer, intent(in) :: index
            real, intent(in) :: unknown
            integer :: N, i
            MulNumerator = 1.0  ! ���������ӳ����������ʱ������ʹ�ã���Ϊ����һ���Զ�save���͵����壡
            N = size(datas, 1)
            do i=1, N
                if(i /= index) then
                    MulNumerator = MulNumerator * (unknown-datas(i)%x)
                end if
            end do
            return 
        end function
        ! �����ֵ�������ķ�ĸ
        real function MulDenominator(datas, index)
        implicit none
            type(point), intent(in) :: datas(:)
            integer, intent(in) :: index
            integer :: N, i
            MulDenominator = 1.0  ! ���������ӳ����������ʱ������ʹ�ã���Ϊ����һ���Զ�save���͵����壡
            N = size(datas, 1)
            do i=1, N
                if(i /= index) then
                    MulDenominator = MulDenominator * (datas(index)%x-datas(i)%x)
                end if
            end do
            return 
        end function
        ! �����������ղ�ֵ
        real function Lagrange(datas, unknown)
        implicit none
            type(point), intent(inout) :: datas(:)
            real, intent(in) :: unknown
            integer :: N, i
            real :: temp1, temp2
            Lagrange = 0.0
            N = size(datas, 1)
            do i=1, N
                temp1 = MulNumerator(datas, i, unknown)
                temp2 = MulDenominator(datas, i)
                Lagrange = Lagrange + temp1 * datas(i)%y / temp2
            end do
            return 
        end function
    end module
    
    program main
    use Lagrange_Interpolation
    implicit none
        type(point) :: datas(10)
        real, intrinsic :: sin
        call GetSample(datas, sin, 0.0, PI)
        write(*, "(A, F20.16)") "�������ղ�ֵ�õ���ֵ��", Lagrange(datas, 0.3367)
        write(*, "(A, F20.16)") "ʹ��sin����õ�sin(0.3367)��", sin(0.3367)
    end program