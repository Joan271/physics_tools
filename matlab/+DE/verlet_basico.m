%Ejercicio  4.1 c

function [R] = verlet_basico(ac, t, r1, v1)
    %ac:= función anónima de tres variables construida aparte

    dt = t(2) - t(1);
    dt2 = dt.*dt;
    D = numel(r1);
    N = numel (t);
    R = zeros (D,N);
    R(:,1) = r1;
    % Primer paso
    a = ac(R(:,1),t(1));
    R(:,2) = R(:,1) + dt*v1(:,1) + dt2*a(:)/2;
    for k = 2:N-1
        a = ac(R(:,k),t(k));
        R(:,k+1) = 2*R(:,k) - R(:,k-1) + a(:)*dt2;
    end
end
