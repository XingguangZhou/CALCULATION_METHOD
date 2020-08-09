    ! Gauss-Jordan���������������ʽ
    ! �˷�����Ϊ���Դ����г��õ�ͨ���б任���������Ϊ������ͽ�����⡣
    ! ���ģ��ȶ�ϵ��������������ǻ����ٽ��������ǻ������ɵõ�ϵ�������������;���
    !      ͬʱ���Ⱥ��ұߵ�������Ҳ��Ҫ����ͬ�����б任��
    MODULE NUMERICAL
    IMPLICIT NONE
        PRIVATE UPPER
        PRIVATE LOWER
        PUBLIC SHOWMAT
        PUBLIC SOLVER
    CONTAINS
        ! ��ӡ����
        SUBROUTINE SHOWMAT(MAT)
        IMPLICIT NONE
            REAL, INTENT(IN) :: MAT(:, :)
            INTEGER :: I
            DO I=1, SIZE(MAT, 2)
                WRITE(*, "(3F6.2)") MAT(:, I)
            END DO
            RETURN 
        END SUBROUTINE
        
        ! �����ǻ�ϵ������ͬʱ�ԵȺ��ұ���������ͬ���б任
        SUBROUTINE UPPER(MAT, B)
        IMPLICIT NONE
            REAL, INTENT(INOUT) :: MAT(:, :)
            REAL, INTENT(INOUT) :: B(:)
            INTEGER :: I, J
            DO I=1, SIZE(MAT, 2)-1
                DO J=I+1, SIZE(MAT, 2)
                    ! ע�⣬100�����200����˳���ܵ�����
100                 B(J) = B(J) - B(I) * MAT(I, J) / MAT(I, I)                 ! �ԵȺ��ұ�������ͬ���б任
200                 MAT(:, J) = MAT(:, J) - MAT(I, J) * MAT(:, I) / MAT(I, I)  ! ��ϵ�������б任
                END DO
            END DO
            RETURN
        END SUBROUTINE
        
        ! �����ǻ�ϵ������ͬʱ�ԵȺ��ұ���������ͬ���б任
        SUBROUTINE LOWER(MAT, B)
        IMPLICIT NONE
            REAL, INTENT(INOUT) :: MAT(:, :)
            REAL, INTENT(INOUT) :: B(:)
            INTEGER :: I, J
            ! ���о�����б任
            DO I=SIZE(MAT, 2), 2, -1
                DO J=I-1, 1, -1
                    ! ע�⣬300�����400����˳���ܵ�����
300                 B(J) = B(J) - B(I) * MAT(I, J) / MAT(I, I)
400                 MAT(:, J) = MAT(:, J) - MAT(I, J) &
                                    * MAT(:, I) / MAT(I, I)
                END DO
            END DO
            RETURN
        END SUBROUTINE
        
        ! ��ⷽ��
        SUBROUTINE SOLVER(MAT, X, B)
        IMPLICIT NONE
            REAL, INTENT(INOUT) :: MAT(:, :) ! ϵ������
            REAL, INTENT(OUT) :: X(:)        ! ������������
            REAL, INTENT(INOUT) :: B(:)      ! �Ⱥ��ұߵ�������
            INTEGER :: I
            ! ����һ��ϵ������������ǻ����ٽ���һ�������ǻ���
            ! ͬʱ�Ⱥ��ұ�������ͬ�������б任��
            ! ���ջ�õ��������󣬷ǳ����������⣡
            CALL SHOWMAT(MAT)
            !WRITE(*, *) B
            WRITE(*, *) "------------------"
            CALL UPPER(MAT, B)
            CALL SHOWMAT(MAT)
            !WRITE(*, *) B
            WRITE(*, *) "------------------"
            CALL LOWER(MAT, B)
            CALL SHOWMAT(MAT)
            !WRITE(*, *) B
            ! ���
            FORALL(I=1:SIZE(MAT, 2)) X(I) = B(I) / MAT(I, I)
            RETURN 
        END SUBROUTINE    
    END MODULE
    
    PROGRAM MAIN
    USE NUMERICAL
    IMPLICIT NONE
        REAL :: MAT(3, 3) = (/ 1, 4, 7, 2, 5, 8, 3, 6, 8 /)
        REAL :: X(3)
        REAL :: B(3) = (/ 12, 15, 17 /)
        CALL SOLVER(MAT, X, B)
        WRITE(*, "(A8, 3F10.4)") "���Ϊ��", X
    END PROGRAM
    
!    �������Ӽ�Ϊ�����飺
!    1X + 4Y + 7Z = 12
!    2X + 5Y + 8Z = 15
!    3X + 6Y + 8Z = 17
!    ��������X = 1.0000  Y = 1.0000  Z = 1.0000