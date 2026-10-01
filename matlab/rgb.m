function color = rgb(long_onda_nm)
    % Inicializamos los valores RGB
    R = 0;
    G = 0;
    B = 0;
    
    N = length(long_onda_nm);
    color = zeros(N,3);

    for i = 1:N
        long_onda = long_onda_nm(i);

        if sum(abs(long_onda)-long_onda) ~= 0
           long_onda = abs(long_onda);
        end

        if long_onda < 750*10^(-9)
           long_onda = long_onda.*10^9;
        end

    % Verificamos la longitud de onda y calculamos RGB
    if long_onda >= 380 && long_onda < 440
        R = -(long_onda - 440) / (440 - 380);
        G = 0.0;
        B = 1.0;
    elseif long_onda >= 440 && long_onda < 490
        R = 0.0;
        G = (long_onda - 440) / (490 - 440);
        B = 1.0;
    elseif long_onda >= 490 && long_onda < 510
        R = 0.0;
        G = 1.0;
        B = -(long_onda - 510) / (510 - 490);
    elseif long_onda >= 510 && long_onda < 580
        R = (long_onda - 510) / (580 - 510);
        G = 1.0;
        B = 0.0;
    elseif long_onda >= 580 && long_onda < 645
        R = 1.0;
        G = -(long_onda - 645) / (645 - 580);
        B = 0.0;
    elseif long_onda >= 645 && long_onda <= 750
        R = 1.0;
        G = 0.0;
        B = 0.0;
    else
        R = 0.0;
        G = 0.0;
        B = 0.0; % Fuera del rango visible
    end
    
    % Ajustamos los valores a una escala de 0 a 255
    color(i,:) = [round(R * 255), round(G * 255), round(B * 255)]./255;
end

