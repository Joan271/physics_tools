%%%%%Resolución de sistemas de EDOs%%%%%%%%%%%%%%
%método de Runge-Kutta Orden 4

function[y] = RK4 (g,t,y0)
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

    k1 = g(y(:,k),t(k));
    k2 = g(y(:,k) + 0.5*k1*dt, t(k)+ 0.5*dt);
    k3 = g(y(:,k) + 0.5*k2*dt, t(k) + 0.5*dt);
    k4 = g(y(:,k)+k3*dt,t(k)+dt);
    y(:,k+1) = y(:,k) + 1/6*dt*(k1+2*k2+2*k3+k4); 
end

end

