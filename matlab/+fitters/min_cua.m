%%%% SUBRUTINA DE MINIMOS CUADRADOS %%% 
% % ===================================================================
% Solucion por minimos cuadrados del problema lineal A*c = y
% A (n,m): Input: Matriz A de rango m
% y (n,1): Input: Vector columna y
% c (m,1): Output: Solucion por minimos cuadrados
% dc (m,1): Output: Incertidumbre de las solucion
% dyav (1): Output: Desviacion promedio de los datos y
% ===================================================================


function[c, dc, dyav] = min_cua(A,y)
N = numel(y);
M = numel(A)/N;
s = sprintf('vas a emplear %d número de funciones',M);
disp(s);

c = A\y;
dy = A*c - y ;
E = dot (dy,dy);
if (N==M)
    dyav = 0;
else
dyav = sqrt((E)/(N-M));
end
G = inv(A'*A);
dc(sqrt(numel(G))) = 0;
for k = 1: sqrt(numel(G))
    dc (k) = sqrt(G(k,k))*dyav;
end
end

