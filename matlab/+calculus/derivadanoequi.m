
%subrutina derivada no equispaciado 

function [dfdx, z] = derivadanoequi (x, f)
N = numel (x);

for k = 1: N-1 
    z (k)= (x(k) + x(k + 1))/2;
    dfdx(k) = (f(k+1) - f(k))/(x(k+1) - x(k));
   
end 
%tambien se puede hacer con diff
%df = diff(f)
%dx = diff(x)
%DX = df./dx
%x_aux = x
%x_aux(N) = [] conjunto vacío = le quito una componente. 
%xm = x_aux + dx/2
end