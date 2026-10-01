function [G] = partialderivative(F,r,j,h,k)
% F: Funcion a derivadar parcialmente F(x1,x2,...xj,...,xn)
% r: Punto a derivar: r = (x1,x2,...xj,...xn
% j: indice de la variable a derivar xj
% h: paso 
% k: indica el método que se desea usar
if k==1
G = diferencias_centradas(F,r,j,h);
elseif k==2
G = derivada_S(F,r,j,h);
elseif k==3
G = derivada_H(F,r,j,h);
end
end

function [D] = diferencias_centradas(F,r,j,h)
% F: Funcion a derivadar parcialmente F(x1,x2,...xj,...,xn)
% r: Punto a derivar: r = (x1,x2,...xj,...xn)
% j: indice de la variable a derivar xj
% h: paso 
N = numel(r);
dr = zeros(N,1);
dr(j) = h;
D = (F(r+dr)-F(r-dr))/(2*h);
end

function[S] = derivada_S(F,r,j,h)
D1 = diferencias_centradas(F,r,j,h);
D2 = diferencias_centradas(F,r,j,2*h);
S = (4*D1-D2)/3;
end

function[H] = derivada_H(F,r,j,h)
 S1 = derivada_S(F,r,j,h);
 S2 = derivada_S(F,r,j,2*h);
 H = (16*S1-S2)/15;
end