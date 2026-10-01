%subrutina de solución a sistema de ecuaciones diferenciales

function[y] = rk2pm (g,t,y0)
%Sol de la ecuaciones y
% g(y,t) es la función 
%y0(D,1) : condiciones iniciales
%t (1,N): tiempos variable independiente 
%

N = numel(t);
D = numel (y0);
y = zeros(D,N);
y(:,1) = y0;
for k = 1:N -1
    dt = t(k+1) - t(k);
    ka = g(y(:,k),t(k));
    y(:,k+1) = y(:,k) + g(y(:,k) + ka*dt*0.5 , t(k) + 0.5*dt)*dt;
end


end
