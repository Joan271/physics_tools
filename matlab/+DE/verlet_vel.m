function [R,V] = verlet_vel(ac,t,r1,v1)
% Sol. de las ecuaciones de movimiento mediante velocity Verlet
% caso general: 
% la aceleracion puede depender de la posicion, velocidad y tiempo
% 
% ac      : funcion anonima/script (aceleracion) ac(r,v,t)
% t(1,N)  : tiempos, vector fila
% r1(D,1) : posiciones iniciales r(t1), vector columna
% v1(D,1) : velocidades iniciales v(t1), vector columna 
% R(D,N)  : solucion posiciones
% V(D,N)  : solucion velocidades
% D       : numero de ecuaciones (grados de libertad)
%
D = numel(r1);
N = numel(t);
%
R = zeros(D,N);   % inicializacion/preasignacion
V = zeros(D,N);   % inicializacion/preasignacion
R(:,1) = r1;
V(:,1) = v1;
% a = ac(R(:,1),V(:,1),t(1));
%
for n = 1:N-1
    dt = t(n+1) - t(n);
    % (5)
    a = ac(R(:,n),V(:,n),t(n));
    % (1)
    R(:,n+1) = R(:,n) + V(:,n)*dt+ 1/2*a(:)*dt*dt;
    % (2)
    va(:) = V(:,n) + dt*a(:);
    % (3)
    aa = ac(R(:,n+1),va(:),t(n+1));
    % (4)
    V(:,n+1) = V(:,n) + 0.5*dt*(a(:)+aa(:));
end