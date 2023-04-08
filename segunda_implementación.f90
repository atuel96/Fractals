program main
    ! entrada: ninguna. las variables y parametros utilizados están dentro del código
    ! salida: newton.txt con la matriz de enteros que representan el fractal
    implicit none

    integer, parameter :: N = 1000                                       ! la imagen final tendrá  N+1 x N+1 elementos
    real, parameter :: xmax = 3, imax = 3                               ! rango en el plano complejo
    integer :: i, j, k                                                  ! variables para los do loops
    real :: reals(N+1) = [(real(i)/N*2*xmax, i = 0, N)] - xmax          ! la recta real
    real :: imag(N+1) = [(real(i)/N*2*xmax, i = N, 0, -1)] - imax       ! la recta imaginaria
    integer :: image(N+1,N+1) = 0                                       ! la matriz final
    real :: error = 0.01                                                ! error de tolerancia para las raíces
    integer, parameter :: rn = 3                                        ! número de raíces
    real :: aux(rn)                                                     ! array auxiliar para comparar raíces
    complex :: roots(rn)                                                ! array con las raices verdaderas del polinomio
    complex :: x                                                        ! una raiz compleja para iterar

    roots = [(-1, 0), (0.5,0.866), (0.5,-0.866)]                        ! raices del polinomio                                                      

    open(12,file="newton.txt")              

    do j = 1, N+1
        do i = 1, N+1 
            x = complex(reals(i), imag(j))  ! la raiz propuesta x
            call newton(x, 50)              
            aux = abs(roots - x)            
            do k = 1, rn
                if (aux(k) < error) then    
                    image(j,i) = k 
                    exit
                endif
            enddo
        enddo
        write(12, *) image(j, :)            
    enddo
    close(12)                               
end program main

subroutine newton(x,  n)
    ! x: raiz propuesta. Cambia con cada iteración
	! n: número máximo de iteraciones
    implicit none
    complex,intent(inout) :: x
    integer,intent(in) ::  n 
    complex :: f, df, step
    integer :: i

    do i = 1, n 
        step = f(x)/df(x)
        x = x - step
        if (abs(step) < 0.00001) then
            exit
        endif
    enddo
end subroutine newton

function f(x) result(r)
    implicit none
    complex, intent(in):: x
    complex :: r

    r = x**3 + 1
end function f

function df(x) result(r)
    implicit none
    complex, intent(in):: x
    complex :: r

    r = 3*x**2
end function df
