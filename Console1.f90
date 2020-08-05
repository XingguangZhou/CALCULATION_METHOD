    MODULE MATMUL_TEST
    IMPLICIT NONE
        PRIVATE N
        PUBLIC A
        PUBLIC B
        PUBLIC C
        PUBLIC SHOWMAT
        PUBLIC MATMUL_
        
        ! �˴��Ҷ�����󣬲��õڶ�ά�����У���һά������
        ! ��C�����е������෴��Ӧ��ע�⣡
        INTEGER, PARAMETER :: N = 3  ! ����ά��������3X3����
        INTEGER :: A(N, N)
        INTEGER :: B(N, N) = (/ 1, 2, 3, 4, 5, 6, 7, 8, 9 /)
        INTEGER :: C(N, N) = (/ 9, 8, 7, 6, 5, 4, 3, 2, 1 /)
        
    CONTAINS
        ! ���������ӳ���
        SUBROUTINE SHOWMAT(MAT)
        IMPLICIT NONE
            INTEGER, INTENT(IN) :: MAT(:, :)
            INTEGER :: I
            DO I=1, SIZE(MAT, 2)   ! ����������ʼ��ӡ
                WRITE(*, "(3I4)") MAT(:, I)
            END DO
            RETURN
        END SUBROUTINE
        
        ! ����˷��ӳ���
        ! ���A=B��C
        SUBROUTINE MATMUL_(A, B, C)
        IMPLICIT NONE
            INTEGER, INTENT(OUT) :: A(:, :) ! �������
            INTEGER, INTENT(IN) :: B(:, :)
            INTEGER, INTENT(IN) :: C(:, :)
            INTEGER :: I, J, K
            
            ! ������ά��������ά������Ӧ���޷����в�����
            IF(SIZE(B, 1) /= SIZE(C, 2)) THEN
                WRITE(*, *) "DIMENSIONS ARE NOT CORRESPONDING..."
                RETURN
            END IF
            
            ! ���о������
            DO I=1, SIZE(B, 2)      ! ����B�������
                DO J=1, SIZE(C, 1)  ! ����C�������
                    A(J, I) = 0
                    DO K=1, SIZE(B, 1)
                        A(J, I) = A(J, I) + B(K, I) * C(J, K)
                    END DO
                END DO
            END DO
            RETURN
        END SUBROUTINE               
    END MODULE
    
    PROGRAM MAIN
    USE MATMUL_TEST
    IMPLICIT NONE
        REAL :: T1, T2
        INTEGER :: I
        CALL SHOWMAT(B)
        WRITE(*, *) "-------------"
        CALL SHOWMAT(C)
        WRITE(*, *) "-------------"
        CALL MATMUL_(A, B, C)  ! �������
        CALL SHOWMAT(A)
    END PROGRAM
