program main
    implicit none

    integer, parameter :: N = 1000                                        
    real, parameter :: xmax = 2.5, imax = 2.5               ! rango en el plano complejo
    integer :: i, j, k                                                  
    real :: reals(N+1) = [(real(i)/N*2*xmax, i = 0, N)] - xmax          ! recta real
    real :: imag(N+1) = [(real(i)/N*2*xmax, i = N, 0, -1)] - imax       ! recta imaginaria
    integer :: image(N+1,N+1) = 0                                       ! matriz final
    complex :: x                                                        ! una raiz compleja para iterar

    
    open(12,file="mandelbrot.txt")              

    do j = 1, N+1
        do i = 1, N+1 
            x = complex(reals(i), imag(j))  
            call iteration(x, k) 
            image(j, i) = k           
        enddo
        write(12, *) image(j, :)            
    enddo
    close(12)           

end program main

subroutine iteration(c, n)

    implicit none
    complex,intent(inout) :: c
    integer,intent(inout) ::  n 
    complex :: z
    integer :: i

    z = (0, 0) 
    do i = 1, 80
        z = z**2 + c
        if (abs(z) > 300) then
            n = i
            exit
        endif
    enddo
    if (abs(z) < 5) then
        n = 0
    endif
end subroutine iteration

