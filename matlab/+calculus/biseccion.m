%Subrutina bisección (no funciona bieeen)

function [x0] = biseccion(f,a,b,e1,e2)
    cond = @(a,b) f(a)*f(b)  ;
    pm = @(a,b) (a+b) /2;
    t1 = @(c) abs(f(c)) < e1;
    t2 = @(b,a) abs(b -a ) < e2;

    if cond(a,b) > 0
        msg = 'f(a)*f(b) > 0';
        error(msg);
    elseif f(a) == 0
        x0 = a;
        return
    elseif f(b) == 0
        x0 = b;
        return
    end 
        c= pm(a,b);

        while t1(c) == 0 && t2(b,a) == 0
            if cond(a,b) < 0
                a = c;
                
            else
                b = c;
               
            end
            c = pm(a,b);

        end
    x0 = c;
        

end