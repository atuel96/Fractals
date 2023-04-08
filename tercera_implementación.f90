program main
    ! entrada: ninguna. las variables y parametros utilizados estan dentro del codigo
    ! salida: newton.txt y  alpha.txt
    implicit none
    integer, parameter :: N = 2000                                      
    real, parameter :: xmax = 3, imax = 3                               ! rango en el plano complejo
    integer :: i, j, k                                                  ! variables para los do loops
    real :: reals(N+1) = [(real(i)/N*2*xmax, i = 0, N)] - xmax          ! la recta real
    real :: imag(N+1) = [(real(i)/N*2*xmax, i = N, 0, -1)] - imax       ! la recta imaginaria
    integer :: image(N+1,N+1) = 0                                       ! matriz final
    real :: alpha(N+1, N+1)  = 0                                        ! matriz alpha                                     
    real :: error = 0.1                                                ! error de tolerancia para las raíces
    integer, parameter :: rn = 3                                        ! número de raíces
    real :: aux(rn)                                                     ! array auxiliar para comparar raíces
    complex :: roots(rn)                                                ! Taices verdaderas del polinomio
    complex :: x                                                        ! una raiz compleja 
    real :: a                                                           ! valor individual para alpha

    roots = [(-1.76929, 0), (0.88465, 0.58974), (0.88465, -0.58974)]    ! raices

    open(12,file="newton.txt")
    open(13,file="alpha.txt")

    do j = 1, N+1
        do i = 1, N+1 
            x = complex(reals(i), imag(j))  ! la raiz propuesta x

            call newton(x, 50, a)              
            aux = abs(roots - x)            
            do k = 1, rn
                if (aux(k) < error) then    
                    image(j,i) = k 
                    exit
                endif
            enddo
            alpha(j, i) = a
        enddo
        write(12, *) image(j, :)            
        write(13, *) alpha(j,:)
    enddo
    close(12)                               
    close(13)
    
end program main

subroutine newton(x, n, a)
    implicit none
    complex,intent(inout) :: x  ! x: raiz compleja para iterar
    integer,intent(in) ::  n    ! n: num. máximo de iteraciones
    real, intent(inout) :: a    ! a: medida de convergencia
    complex :: f, df, step
    integer :: i

    do i = 1, n 
        step = f(x)/df(x)
        x = x - step
        if (abs(step) < 0.00001) then
            exit
        endif
    enddo

    if (i < n/10) then
        a = 0.6
    else if (i < n/8) then
        a = 0.7
    else if (i < n/6) then
        a = 0.75
    else if (i < n/5) then
        a = 0.8
    else if (i < n/2) then
        a = 0.9
    else 
        a = 1
    endif
    
end subroutine newton

function f(x) result(r)
    implicit none
    complex, intent(in):: x
    complex :: r

    r = x**3 -2*x +2
end function f

function df(x) result(r)
    implicit none
    complex, intent(in):: x
    complex :: r

    r = 3*x**2 -2
end function df
