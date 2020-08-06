    MODULE LINEAR_ALGEBRA
    IMPLICIT NONE
        PUBLIC N
        PUBLIC SHOWMAT
        PUBLIC UPPER
        PUBLIC LOWER
        INTEGER, PARAMETER :: N = 3
    CONTAINS
        ! ��ʾ��������
        SUBROUTINE SHOWMAT(MATRIX)
        IMPLICIT NONE
            REAL, INTENT(IN) :: MATRIX(:, :)
            INTEGER :: I
            DO I=1, SIZE(MATRIX, 2)     ! �����������
                WRITE(*, "(4F8.2)") MATRIX(:, I)
            END DO
            RETURN 
        END SUBROUTINE
        
        ! �������Ǿ�����ӳ���
        SUBROUTINE UPPER(MATRIX)
        IMPLICIT NONE
            REAL, INTENT(INOUT) :: MATRIX(:, :)
            INTEGER :: I, J
            ! ���о�����б任
            DO I=1, SIZE(MATRIX, 2)-1
                DO J=I+1, SIZE(MATRIX, 2)
                    MATRIX(:, J) = MATRIX(:, J) - MATRIX(I, J) * MATRIX(:, I) / MATRIX(I, I)
                END DO
            END DO
            RETURN
        END SUBROUTINE
        
        ! �������Ǿ�����ӳ���
        SUBROUTINE LOWER(MATRIX)
        IMPLICIT NONE
            REAL, INTENT(INOUT) :: MATRIX(:, :)
            INTEGER :: I
            INTEGER :: J
            ! ���о�����б任
            DO I=SIZE(MATRIX, 2), 2, -1
                DO J=I-1, 1, -1
                    MATRIX(:, J) = MATRIX(:, J) - MATRIX(I, J) &
                                    * (MATRIX(:, I) / MATRIX(I, I))
                END DO
            END DO
        END SUBROUTINE
    END MODULE
    
    PROGRAM MAIN
    USE LINEAR_ALGEBRA
    IMPLICIT NONE
        REAL :: A(N, N) = (/ 1, 2, 1, 3, 2, 3, 2, 3, 4 /)
        REAL :: B(N, N)
        B = A
        CALL SHOWMAT(A)
        CALL UPPER(A)
        WRITE(*, *) "------------------"
        CALL SHOWMAT(A)
        WRITE(*, *) "------------------"
        CALL LOWER(B)
        CALL SHOWMAT(B)
    END PROGRAM
            
