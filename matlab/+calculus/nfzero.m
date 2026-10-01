%subrutina para obtener las n soluciones de una función 
function [x0,s] = nfzero(f,x)
%f es una función anónima % modificable si pones x==x(k) en su lugar
%x es el reticulado deseado
%s es número de soluciones
s = 1; 
k = 1;
while k <= numel (x) 
    if f(x(k)) == 0
        x0(s) = x(k);
        s = s+1;
        k = k+1; 
    else
        l = k+1; 
        while l < numel(x) 
            if f(x(k))*f(x(l)) < 0   
            x0(s) = fzero(f,[x(k),x(l)]);
            s = s+1;
            
            k = l - 1;
            l = 1 + numel (x);
            else
                l = l+1;
            end
        end
        k = k+1;
    end 
end 
s = s-1;
end