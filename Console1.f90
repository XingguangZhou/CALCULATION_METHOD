    MODULE NUMERICAL
    IMPLICIT NONE
        PRIVATE UPPER
        PRIVATE LOWER
        PUBLIC SHOWMAT
        PUBLIC INVERSE_MAT
    CONTAINS
        ! ��ӡ����
        SUBROUTINE SHOWMAT(MAT)
        IMPLICIT NONE
            REAL, INTENT(IN) :: MAT(:, :)
            INTEGER :: I
            DO I=1, SIZE(MAT, 2)
                WRITE(*, "(3F8.4)") MAT(:, I)
            END DO
            RETURN 
        END SUBROUTINE
        
        ! �����ǻ�ϵ������ͬʱ�ԵȺ��ұ���������ͬ���б任
        SUBROUTINE UPPER(MAT, E)
        IMPLICIT NONE
            REAL, INTENT(INOUT) :: MAT(:, :)
            REAL, INTENT(INOUT) :: E(:, :) ! ��λ����
            INTEGER :: I, J
            DO I=1, SIZE(MAT, 2)-1
                DO J=I+1, SIZE(MAT, 2)
                    ! ע�⣬100�����200����˳���ܵ�����
100                 E(:, J) = E(:, J) - E(:, I) * MAT(I, J) / MAT(I, I)               
200                 MAT(:, J) = MAT(:, J) - MAT(I, J) * MAT(:, I) / MAT(I, I)
                END DO
            END DO
            RETURN
        END SUBROUTINE
        
        ! �����ǻ�ϵ������ͬʱ�ԵȺ��ұ���������ͬ���б任
        SUBROUTINE LOWER(MAT, E)
        IMPLICIT NONE
            REAL, INTENT(INOUT) :: MAT(:, :)
            REAL, INTENT(INOUT) :: E(:, :)
            INTEGER :: I, J
            ! ���о�����б任
            DO I=SIZE(MAT, 2), 2, -1
                DO J=I-1, 1, -1
                    ! ע�⣬300�����400����˳���ܵ�����
300                 E(:, J) = E(:, J) - E(:, I) * MAT(I, J) / MAT(I, I)
400                 MAT(:, J) = MAT(:, J) - MAT(I, J) * MAT(:, I) / MAT(I, I)
                END DO
            END DO
            RETURN
        END SUBROUTINE
        
        ! �������
        SUBROUTINE INVERSE_MAT(MAT, E)
        IMPLICIT NONE
            REAL, INTENT(INOUT) :: MAT(:, :) ! ϵ������
            REAL, INTENT(INOUT) :: E(:, :)
            INTEGER :: I, J
            CALL SHOWMAT(MAT)
            WRITE(*, *) "------------------"
            CALL UPPER(MAT, E)
            CALL SHOWMAT(MAT)
            WRITE(*, *) "------------------"
            CALL LOWER(MAT, E)
            CALL SHOWMAT(MAT)
            WRITE(*, *) "------------------"
            ! �ó�MAT�������
            FORALL(I=1:SIZE(MAT, 2)) E(:, I) = E(:, I) / MAT(I, I)
            RETURN 
        END SUBROUTINE    
    END MODULE
    
    PROGRAM MAIN
    USE NUMERICAL
    IMPLICIT NONE
        REAL :: MAT(3, 3) = (/ 1, 1, 3, 3, 2, 2, 1, 3, 1 /)
        REAL :: BACKUP(3, 3) = (/ 1, 1, 3, 3, 2, 2, 1, 3, 1 /)
        INTEGER :: I, J
        REAL :: E(3, 3)
        
        ! ���ɵ�λ����
        FORALL(I=1:3, J=1:3, I==J) E(I, J) = 1.0
        FORALL(I=1:3, J=1:3, I/=J) E(I, J) = 0.0
        
        CALL INVERSE_MAT(MAT, E)
        CALL SHOWMAT(E)
        WRITE(*, *) MATMUL(BACKUP, E)   ! ʹ��ԭ��������õ��������г˻��������Ƿ��ǵ�λ����
    END PROGRAM
    