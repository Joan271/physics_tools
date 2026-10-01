
function [p] =taylor(x, f, x0, m)




m1 = find(x>= x0); 
n = m1(1);
fd1 = derivada(x,f);
p(1,:) =  (x-x0)*fd1(n) + f(n);
fd = fd1;
for k = 1:m
    fd = derivada (x,fd);

    p(k + 1, :) = p(k, :) + (x-x0).^(k+1) /factorial(k+1)* fd(n);

end

end
