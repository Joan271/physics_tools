%%%%%%Resolución de sistemas de EDOs%%%%%%%%%%
%Método de Runge-Kutta de orden 4 con matriz de estructructuras%

function[y] = RK4_str (g,t,y0,s)
%Sol de la ecuaciones y
% g(y,t,s) es la función con la matriz de estructuturas 
%y0(D,1) : condiciones iniciales
%t (1,N): tiempos variable independiente 
%

N = numel(t);
D = numel (y0);
y = zeros(D,N);
y(:,1) = y0;
for k = 1:N -1
    dt = t(k+1) - t(k);

    k1 = g(y(:,k),t(k),s);
    k2 = g(y(:,k) + 0.5*k1*dt, t(k)+ 0.5*dt,s);
    k3 = g(y(:,k) + 0.5*k2*dt, t(k) + 0.5*dt,s);
    k4 = g(y(:,k)+k3*dt,t(k)+dt,s);
    y(:,k+1) = y(:,k) + 1/6*dt*(k1+2*k2+2*k3+k4); 
end


end
