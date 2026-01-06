! 5.1. Código para generar cuerpos al azar en una esfera de radio=1
! El siguiente código se puede usar para generar una “nube” de cuerpos en una esfera de radio 1, sin velocidades. Estos
! valores se pueden poner en un fichero para usar como entrada al programa (primero añadiendo el dt, dt im, etc., ver sección 2.2)
PROGRAM particulas
    use geometry
    use particle
    IMPLICIT NONE

    INTEGER :: I, N
    INTEGER :: values(1:8), k
    INTEGER, DIMENSION(:), ALLOCATABLE :: seed
    REAL(dp) :: mass, rx, ry, rz
    REAL(dp) :: dt, dt_out, t_end

    dt = 0.001
    dt_out = 0.01
    t_end = 1

    CALL date_and_time(values=values)
    CALL random_seed(size=k)
    ALLOCATE(seed(1:k))
    seed(:) = values(8)
    CALL random_seed(put=seed)

    PRINT*, "Number of bodies?"
    READ*, N

    mass = 1.0_dp / REAL(N, dp)

    ! Abrir archivo de salida
    OPEN(unit=10, file="input.txt", status="replace", action="write")

    ! Escribir en el input los 4 parámetros iniciales
    WRITE(10,'(F10.5)') dt
    WRITE(10,'(F10.5)') dt_out
    WRITE(10,'(F10.5)') t_end
    WRITE(10,'(I8)') N

    DO I = 1, N
        CALL random_number(rx)

        DO
            CALL random_number(ry)
            IF ((rx**2 + ry**2) .LE. 1.0_dp) EXIT
        END DO

        DO
            CALL random_number(rz)
            IF ((rx**2 + ry**2 + rz**2) .LE. 1.0_dp) EXIT
        END DO

        WRITE(10,'(F6.3, 3F11.8,3I2)') mass, rx, ry, rz, 0, 0, 0
    END DO

    CLOSE(10)

END PROGRAM particulas