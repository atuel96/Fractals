program main
    ! entrada: valor de x_0 y valor n_max
    ! salido: output.txt con las iteraciones del método de Newton
    implicit none
    real :: x 
    integer :: n 

    write(*,"(a)", advance="no") "x0 -> "
    read(*,*) x 
    write(*,"(a)", advance="no") "n_max -> "
    read(*,*) n 

    call newton(x, n)
end program main

subroutine newton(x, n)
    ! el valor de x es la propuesta inicial, y n es el numero maximo de iteraciones
	! el valor de x cambia con cada iteracion y se imprime en la consola
	! a la vez se genera el archivo de salida "output.txt"
    implicit none
    real ,intent(inout) :: x
    integer,intent(in) ::  n 
    real :: f, df, step
    integer :: i

    open(15, file="output.txt")
    write(15, *) "iteración  |  x_n   "
    write(15, *) 0, x
    do i = 1, n 
        
        step = f(x)/df(x)
        x = x - step
        write(15, *) i, x
        print*, i, x
        if (abs(step) < 0.00001) then
            exit
        endif
    enddo

    close(15)
    
end subroutine newton

function f(x) result(r)
    implicit none
    real, intent(in):: x
    real :: r

    r = x**3 -2*x +2
end function f

function df(x) result(r)
    implicit none
    real, intent(in):: x
    real :: r

    r = 3*x**2 -2
end function df
