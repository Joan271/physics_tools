function [x0] = bisec(fun,a,b,e1,e2)
arguments
    fun (1,1) function_handle
    a (1,1) double
    b (1,1) double
    e1 (1,1) double
    e2 (1,1) double
end

% si funciona (hay que dar extremos)
fa = fun(a);
fb = fun(b);
if fa*fb > 0
    fprintf('introduce otros valores');
    return

elseif fa == 0
    x0 = a;
    return
elseif fb == 0
    x0 = b;
end
c = (a+b)/2;
fc = fun(c); 
D = b - a;
while abs (fc) > e1 && abs(D) > e2
    if fc*fb < 0
        a = c;
    else 
        b = c;
    end
    c = (a+b) /2;
    D = b-a;
    fc = fun(c);
    fb = fun(b);
   
end
x0 = c;
end
