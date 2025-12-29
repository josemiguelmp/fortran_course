! 5.1. Código para generar cuerpos al azar en una esfera de radio=1
! El siguiente código se puede usar para generar una “nube” de cuerpos en una esfera de radio 1, sin velocidades. Estos
! valores se pueden poner en un fichero para usar como entrada al programa (primero añadiendo el dt, dt im, etc., ver sección 2.2)
PROGRAM particulas
    use geometry
    use particle
    IMPLICIT NONE
    
    INTEGER :: I,N
    INTEGER :: values(1:8), k
    INTEGER, DIMENSION(:), ALLOCATABLE :: seed
    REAL(dp) :: mass, rx, ry, rz
    
    CALL date_and_time(values=values)
    CALL random_seed(size=k)
    ALLOCATE(seed(1:k))
    seed(:) = values(8)
    CALL random_seed(put=seed)

    PRINT*, "Number of bodies?"
    READ*, N
    
    mass = 1.0_dp / REAL(N, dp)
    
    DO I= 1,N
        CALL random_number(rx)
        
        DO
            CALL random_number(ry)
            IF ((rx**2 + ry**2) .LE. 1.0_dp) EXIT
        END DO
    
        DO
            CALL random_number(rz)
            IF ((rx**2 + ry**2 + rz**2) .LE. 1.0_dp) EXIT
        END DO
    
        WRITE(*,'(F6.3, 3F11.8,3I2)') mass, rx, ry, rz, 0, 0, 0
        ! PRINT*, "dist", SQRT(rx**2 + ry**2 + rz**2)
    END DO
END PROGRAM particulas