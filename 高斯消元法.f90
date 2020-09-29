    !���ߣ�ZXG
    !��֯��Xi`an Jiaotong University - NuTHeL
    !���ڣ�2020-9-29
    !�汾��version 1.0
    !��˹��Ԫ��������
    !Ҫ�󣺸þ���Ϊ�����ҿ���
    !����������A(M, N)����M��N�о���
    module GaussMethod
    implicit none
        integer, parameter :: N = 3
    contains
        !��ӡ����
        subroutine PrintMatrix(matrix)
        implicit none
            real, intent(in) :: matrix(N, N)
            integer          :: i
            !integer :: row
            !row = size(matrix, 1)
            do i=1, N
                write(*, "(3F10.4)") matrix(i,:)
            end do
            return 
        end subroutine
        ! ���и�˹��Ԫ�������㣬���ⷽ����
        subroutine Gauss(matrix, x, b)
        implicit none
            real, intent(inout) :: matrix(:, :)
            real, intent(out)   :: x(:)
            real, intent(inout) :: b(:)
            real                :: coeff !���ڼ���ÿһ�ν����б任ʱ��ϵ��
            integer             :: i, j
            !integer :: row
            !row = size(matrix, 1)
            !��ʼ���и�˹��Ԫ��
            !����Fortran���������ֱ�ӽ������в��������Կ�����дһ��ѭ��
            do i=1, N-1
                do j=i+1, N
                    !����ÿ���б任��ϵ��
                    coeff = matrix(j, i) / matrix(i, i)
                    !��ʼ�����б任
                    matrix(j, :) = matrix(j, :) - matrix(i, :) * coeff
                    b(j) = b(j) - b(i) * coeff
                end do
            end do
            !��ӡһ�±任��ľ���
            write(*, *) "�任���ϵ������"
            call PrintMatrix(matrix)
            write(*, *) "�任�󣬵Ⱥ��ұߵ���������"
            write(*, "(3F10.4)") b
            !TODO:��ʼ���лش��������ⷽ����
            !��������һ��Ԫ�ص�x
            x(N) = b(N) / matrix(N, N)
            do i=N-1, 1, -1
                do j=N, i+1, -1
                    b(i) = b(i) - matrix(i, j) * x(j)
                end do
                x(i) = b(i) / matrix(i, i)
            end do
            return
        end subroutine
    end module
    !������
    program main
    use GaussMethod
    implicit none
        real :: matrix(N, N)
        real :: x(N)
        real :: b(N) = (/ 0, 3, 2 /)
        !��ʼ������ֵ
        matrix(1, :) = (/  1,  2,  1 /)
        matrix(2, :) = (/  2,  2,  3 /)
        matrix(3, :) = (/ -1, -3,  0 /)
        call Gauss(matrix, x, b)
        write(*, *) "����x������"
        write(*, "(3F10.4)") x
    end program
    
            