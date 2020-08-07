    ! �����������ʽ
    ! �����󣨷���ת��Ϊ�����ǻ���������ʽ
    ! ���Խ���Ԫ�صĻ���Ϊ����ʽ��ֵ
    module LinearAlgebra
    implicit none
        public ShowMat
        public Upper
        public GetDet
    contains
        ! ��ӡ����
        subroutine ShowMat(mat)
        implicit none
            real, intent(in) :: mat(:, :)
            integer :: i
            do i=1, size(mat, 2)
                write(*, "(3F8.2)") mat(:, i)
            end do
            return
        end subroutine
        
        ! ת��Ϊ�����Ǿ���
        subroutine Upper(mat)
        implicit none
            real, intent(inout) :: mat(:, :)
            integer :: i, j
            do i=1, size(mat, 2)-1
                do j=i+1, size(mat, 2)
                    mat(:, j) = mat(:, j) - mat(i, j) * mat(:, i) / mat(i, i)
                end do
            end do
            return
        end subroutine
        
        ! �������Ǿ�����жԽ��߳˻�
        subroutine GetDet(mat, det)
        implicit none
            real, intent(inout) :: mat(:, :)
            real, intent(out) :: det
            integer :: i
            
            call Upper(mat)
            det = 1.0
            do i=1, size(mat, 2)
                det = det * mat(i, i)
            end do
            return
        end subroutine
    end module
    
    program main
    use LinearAlgebra
    implicit none
        real :: mat(3, 3) = (/ 1, 2, 1, 3, 2, 3, 2, 3, 4 /)
        real :: det = 0.0
        call ShowMat(mat)
        call Upper(mat)
        write(*, *) "-------------------"
        call ShowMat(mat)
        
        call GetDet(mat, det)
        write(*, *) det
    end program
    