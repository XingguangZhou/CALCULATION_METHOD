    ! ׷�Ϸ��ֽ����ԽǾ���
    module TridiagonalMatrix
    implicit none
        ! ���ṹ���ڸó������ô�����ֵ��һ����ǣ�
        ! ��ϡ��������������У�����ʹ�øýṹ������¼��Щ��Ϊ���Ԫ�ء�
        type :: point
            integer :: i
            integer :: j
            real    :: value
        end type
    contains
        ! Ϊ��ʹ�þ��������ز���������������matrix(3, 4)Ϊ4��3�о���
        subroutine PrintMatrix(matrix)
        implicit none
            real, intent(in) :: matrix(:, :)
            integer          :: i
            integer          :: row
            row = size(matrix, 2)
            ! ���д�ӡ����
            do i=1, row
                write(*, *) matrix(:, i)
            end do
            return
        end subroutine
        ! ��ʼ����׷�Ϸ�����LU�ֽ�
        subroutine Run_Chase(matrix, L, U, b)
        implicit none
            real, intent(in)    :: matrix(:, :)
            real, intent(out)   :: L(:, :)
            real, intent(out)   :: U(:, :)
            real, intent(inout) :: b(:)   ! ���̵Ⱥ��ұߵ��о���
            real, allocatable   :: y(:)
            integer             :: i, j
            integer             :: row
            integer             :: col
            row = size(matrix, 2)
            ! Ϊ�м䷽�̽��y�����ڴ�ռ�
            allocate(y(row))
            ! �ȼ������ĵ�һ����
            U(1, 1) = matrix(1, 1)
            L(1, 1) = 1.0
            y(1) = b(1)
            ! ��ʼ����L��U�����
            do i=2, row
                L(i-1, i) = matrix(i-1, i) / U(i-1, i-1)
                L(i, i) = 1
                U(i, i) = matrix(i, i) - L(i-1, i) * matrix(i, i-1)
                U(i, i-1) = matrix(i, i-1)
                y(i) = b(i) - L(i-1, i) * y(i-1)
            end do
            ! ��y�����ֵ���ظ�b
            b = y
            ! �ͷ�y����Ŀռ�
            deallocate(y)
            return
        end subroutine
        ! ���ø�˹��Ԫ���еĻش�������ɷ�������������
        subroutine Solution(U, b, x)
        implicit none
            real, intent(inout) :: U(:, :)
            real, intent(inout) :: b(:)
            real, intent(out)   :: x(:)  ! ���ڴ�����ս��
            integer             :: row, col, i, j
            row = size(U, 2)
            col = size(U, 1)
            x(row) = b(row) / U(row, row)
            do i=row-1, 1, -1
                do j=col, i+1, -1
                    b(i) = b(i) - U(j, i) * x(j)
                end do
                x(i) = b(i) / U(i, i)
            end do
            return
        end subroutine
    end module
    ! ��ʼ������
    program main
    use TridiagonalMatrix
    implicit none
        integer :: i, j
        real :: matrix(5, 5) = (/ 1, 2, 0, 0, 0, 2, 3, 1, 0, 0, 0, -3, 4, 2, 0, 0, 0, 4, 7, 1, 0, 0, 0, -5, 6 /)
        real :: L(5, 5) = 0
        real :: U(5, 5) = 0
        real :: b(5) = (/ 5, 9, 2, 19, -4 /)
        real :: x(5) = 0
        integer :: row = 5
        call Run_Chase(matrix, L, U, b)
        
        write(*, *) "���ԽǾ����LU�ֽ�������ʾ��"
        write(*, *) "==============================L����=============================="
        call PrintMatrix(L)
        write(*, *) "==============================U����=============================="
        call PrintMatrix(U)
        write(*, *) "============================�м�b����============================="
        write(*, *) b
        ! �ⷽ��
        call Solution(U, b, x)
        write(*, *) "���̵����ս����"
        write(*, *) x
    end program
    