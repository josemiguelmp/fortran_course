PROGRAM generador_colapso
    IMPLICIT NONE

    INTEGER, PARAMETER :: dp = SELECTED_REAL_KIND(p=15, r=307)

    INTEGER :: i, n, k
    INTEGER, DIMENSION(:), ALLOCATABLE :: seed
    INTEGER :: values(1:8)
    REAL(dp) :: mass, rx, ry, rz, radio_sq, r_min, r_max
    REAL(dp) :: dt, dt_out, t_end

    ! --- Parámetros de la simulación ---
    dt = 0.002_dp       ! Paso de tiempo (más pequeño para el colapso)
    dt_out = 1.0_dp     ! Frecuencia de salida
    t_end = 5.0_dp      ! Tiempo total
    n = 50000           ! Número de partículas
    mass = 1.0_dp       ! Masa total del sistema (cada partícula será 1/N)
    
    r_min = 0.5_dp      ! Radio interno (hueco)
    r_max = 1.0_dp      ! Radio externo
    ! -----------------------------------

    CALL date_and_time(values=values)
    CALL random_seed(size=k)
    ALLOCATE(seed(k))
    seed(:) = values(8)
    CALL random_seed(put=seed)

    OPEN(unit=10, file="input_spherical.dat", status="replace", action="write")

    WRITE(10,'(F10.5)') dt
    WRITE(10,'(F10.5)') dt_out
    WRITE(10,'(F10.5)') t_end
    WRITE(10,'(I8)') n

    DO i = 1, n
        DO
            ! Generar coordenadas entre -r_max y r_max
            CALL random_number(rx); rx = (rx * 2.0_dp - 1.0_dp) * r_max
            CALL random_number(ry); ry = (ry * 2.0_dp - 1.0_dp) * r_max
            CALL random_number(rz); rz = (rz * 2.0_dp - 1.0_dp) * r_max
            
            radio_sq = rx**2 + ry**2 + rz**2
            
            ! Solo aceptamos la partícula si está dentro de la corteza (r_min < r < r_max)
            IF (radio_sq <= r_max**2 .AND. radio_sq >= r_min**2) EXIT
        END DO

        ! Formato: Masa, Pos(x,y,z), Vel(x,y,z)
        WRITE(10,'(F12.8, 3F12.8, 3F12.8)') mass/n, rx, ry, rz, 0.0_dp, 0.0_dp, 0.0_dp
    END DO

    CLOSE(10)
    PRINT*, "Archivo input.txt generado con éxito para colapso esférico."

END PROGRAM generador_colapso