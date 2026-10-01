

function [G] = derivadaparcial(F,j,r,x,h)
% F = Función a derivar. F = F(x1,x2,...xn)
% j = indice de la variable a derivar. x_j 
% r = vector de posiciones del resto de variables
N = numel(r) + 1;
S = @(x) vect(r,j,x); 
g = @(x) F(S(x));
G = diferencias_centradas(g,x,h);
end

function [s] = vect(r,j,x)
% r = vector de posiciones del resto de variables
% j = indice de la variable a adjuntar
N = numel(r)+1;
s(1:N) = zeros(1,N);
s(j) = x;
    if j == 1
    s(2:end) = r;
    end
    if j == N
    s(1:N-1) = r;
    else
    s(1:j-1) = r(1:j-1);
    s(j+1,N) = r(j:N-1);
    end
end

function [derf] = diferencias_centradas(f,x,h)
    derf= (f(x+h)-f(x-h))/(2*h);

end


