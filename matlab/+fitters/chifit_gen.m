%% AJUSTE POR EL MÉTODO DE CHI CUADRADO 
% Esta función es adecuada para errores tanto en x como en y, se comprueba que los resultados son los mismo 
% que la función chifit para errores solo en y con la corrección del factor 0.5 en la función chi2. 
% sin esta corrección, los ajustes de esta función son un sqrt(2) menores que la original. 
function [a, b, sigma_a, sigma_b] = chifit_gen(x, y, sigma_x, sigma_y)
    % Ajuste lineal con errores en x e y usando minimización de chi^2 ortogonal
    % Devuelve: pendiente a, intersección b, errores sigma_a y sigma_b

    % Función chi^2 (distancia ortogonal ponderada)
    chi2 = @(p) 0.5*sum(((p(1)*x - y + p(2)) ./ sqrt(p(1)^2 + 1)).^2 ./ ...
                   ((p(1)^2 .* sigma_x.^2 + sigma_y.^2) ./ (p(1)^2 + 1)));

    % Estimación inicial usando regresión ordinaria
    p0 = polyfit(x, y, 1);  % [a b] inicial
    options = optimset('Display','off','TolX',1e-10,'TolFun',1e-10);
    
    % Minimización con fminsearch
    p_opt = fminsearch(chi2, p0, options);
    a = p_opt(1);
    b = p_opt(2);

    % Estimar matriz de covarianza usando el Hessiano numérico
    eps_val = 1e-5;
    H = zeros(2);
    for i = 1:2
        for j = 1:2
            p_eps_ij1 = p_opt; p_eps_ij1(i) = p_eps_ij1(i) + eps_val; p_eps_ij1(j) = p_eps_ij1(j) + eps_val;
            p_eps_ij2 = p_opt; p_eps_ij2(i) = p_eps_ij2(i) + eps_val; p_eps_ij2(j) = p_eps_ij2(j) - eps_val;
            p_eps_ij3 = p_opt; p_eps_ij3(i) = p_eps_ij3(i) - eps_val; p_eps_ij3(j) = p_eps_ij3(j) + eps_val;
            p_eps_ij4 = p_opt; p_eps_ij4(i) = p_eps_ij4(i) - eps_val; p_eps_ij4(j) = p_eps_ij4(j) - eps_val;
            H(i,j) = (chi2(p_eps_ij1) - chi2(p_eps_ij2) - chi2(p_eps_ij3) + chi2(p_eps_ij4)) / (4 * eps_val^2);
        end
    end

    cov_matrix = inv(H);  % Matriz de covarianza de parámetros
    sigma_a = sqrt(cov_matrix(1,1));
    sigma_b = sqrt(cov_matrix(2,2));
end



