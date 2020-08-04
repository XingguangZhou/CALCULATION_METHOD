    module NUMERICAL
    implicit none
        private zero        ! ��Ϊ˽�б���
        private GetPoint    ! �˺���Ϊ˽�к��������з�װ
        real, parameter :: zero = 0.00001
    contains
    
        real function GetPoint(a, b, func)
        implicit none
            real, intent(in) :: a
            real, intent(in) :: b
            real, external :: func
            
            real :: FA
            real :: FB
            real :: k
            
            FA = func(a)
            FB = func(b)
            k = (FB-FA) / (b-a)
            
            GetPoint = a - FA/k
            return 
        end function
    

        real function Solver(a, b, func)
        implicit none
            ! ��������
            real, intent(inout) :: a
            real, intent(inout) :: b
            real, external :: func  ! �����ⲿ���������е���
            ! ������������ʱ����
            real :: c
            real :: FA
            real :: FB
            real :: FC
            
            c = GetPoint(a, b, func)
            FA = func(a)
            FB = func(b)
            FC = func(c)
            
            do while(abs(FC - 0) >= zero)
                a = b
                FA = FB
                b = c
                FB = FC
                c = GetPoint(a, b, func)
                FC = func(c)
            end do
            
            Solver = c
            return
        end function
        
        real function func(X)
        implicit none
            real, intent(in) :: X
            func = sin(X)
            return
        end function
    end module
    
    program main
    use NUMERICAL
    implicit none
        real :: a, b
        real :: ans
        write(*, *) "���������²����ֵ:"
        read(*, *) a, b
        ans = Solver(a, b, func)
        write(*, *) ans
    end program
