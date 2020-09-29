    !���ߣ�ZXG
    !��֯��Xi`an Jiaotong University - NuTHeL
    !���ڣ�2020-9-29
    !�汾��version 1.0
    !����Ԫ��˹��Ԫ��������
    !Ҫ�󣺸þ���Ϊ�����ҿ���
    !����������A(M, N)����M��N�о���
    module COL_MAIN
    implicit none
        integer, parameter :: N = 3
    contains
        !��ӡ����
        subroutine PrintMatrix(matrix)
        implicit none
            real, intent(in) :: matrix(:, :)
            integer          :: i
            do i=1, N
                write(*, "(3F12.4)") matrix(i, :)
            end do
            return
        end subroutine
        !����Ԫ��˹��Ԫ��
        subroutine Col_Main_Gauss(matrix, b, x)
        implicit none
            real, intent(inout) :: matrix(:, :)
            real, intent(out)   :: x(:)
            real, intent(inout) :: b(:)
            real                :: temp(N)            !���ڽ�����Ԫ������ʱ����ʱ����
            real                :: big
            real                :: coeff              !��¼��˹��Ԫʱ��ϵ��
            integer             :: i, j
            integer             :: index              !���ڼ�¼��Ԫ���ڵ��к�
            logical             :: flag = .false.     !���Ƿ���Ҫ������Ԫ��
            real, intrinsic     :: abs
            do i=1, N-1
                !ѡȡ����Ԫ
                big = abs(matrix(i,i))
                do j=i+1, N
                    if(big < abs(matrix(j, i))) then
                        index = j
                        big = matrix(j, i)
                        flag = .true.
                    end if
                end do
                !������Ԫ���ڵ���
                if(flag == .true.) then
                    temp(:) = matrix(i, :)
                    matrix(i, :) = matrix(index, :)
                    matrix(index, :) = temp(:)
                    !�����Ⱥ��ұ�����������
                    temp(1) = b(i)
                    b(i) = b(index)
                    b(index) = temp(1)
                    !�ָ�flag��״̬
                    flag = .false.                    
                end if
                !���������и�˹��Ԫ
                do j=i+1, N
                    coeff = matrix(j, i) / matrix(i, i)
                    !�����б任
                    matrix(j, :) = matrix(j, :) - matrix(i, :) * coeff
                    !ͬʱ���еȺ��ұ����������б任
                    b(j) = b(j) - b(i) * coeff
                end do
            end do
            !��ӡһ���м����
            write(*, *) "�任���ϵ������"
            call PrintMatrix(matrix)
            write(*, *) "�任�󣬵Ⱥ��ұߵ���������"
            write(*, "(3F12.4)") b
            !���������и�˹��Ԫ�Ļش�����
            !��������һ��Ԫ�ص�ֵ
            x(N) = b(N) / matrix(N, N)
            do i=N-1, 1, -1
                do j=N, i+1, -1
                    b(i) = b(i) - matrix(i, j)*x(j)
                end do
                x(i) = b(i) / matrix(i, i)
            end do
            return
        end subroutine
    end module
    !������
    program main
    use COL_MAIN
    implicit none
        real :: matrix(N, N)
        real :: b(N) = (/ 0, 3, 2 /)
        real :: x(N)
        matrix(1, :) = (/ 1, 2, 1 /)
        matrix(2, :) = (/ 2, 2, 3 /)
        matrix(3, :) = (/ -1, -3, 0 /)
        call Col_Main_Gauss(matrix, b, x)
        write(*, *) "���̵Ľ�Ϊ��"
        write(*, "(3F12.4)") x
    end program
    