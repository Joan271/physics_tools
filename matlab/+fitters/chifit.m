%% AJUSTE POR EL MÉTODO DE CHI CUADRADO

function [alpha1, alpha2,deltalpha1,deltalpha2] = chifit(x,y,sigma)
%(x,y): vectores con puntos experimentales
%sigma: vectores con incertidumbres de la variable con mayor incertidumbre
%Ajuste lineal: y = alpha1*x + alpha2

%Resolución de alpha1 y alpha2
sigma2 = sigma.^2;
p1 = 0; p2 = 0; p3 = 0; p4 = 0; p5=0; p6 =0;
for j = 1:numel(x)
    p1 = p1 + y(j)*x(j)/sigma2(j); 
    p2 = p2 + 1/sigma2(j);
    p3 = p3 + y(j)/sigma2(j); 
    p4 = p4 + x(j)/sigma2(j);
    p5 = p5 + x(j)^2/sigma2(j);
    p6 = p6 + y(j)^2/sigma2(j);
end
alpha1 = (p1*p2 - p3*p4)/(p5*p2-p4^2);
alpha2 = (p3*p5 - p1*p4)/(p5*p2-p4^2);

%Estimación del error
deltalpha1 = 0; deltalpha2 = 0;

    chimin = chi(x,y,sigma,alpha1,alpha2);
    g = @(a,b) chi(x,y,sigma,a,b)- chimin - 1; % ec ligadura alpha 1 = a, alhpa 2 = b
    A = p5; B=p2; C= -2*p1; D = -2*p3; E=2*p4; F= p6 - chimin -1; 
    clear p1 p2 p3 p4 p5 p6
 
    %Deltalpha1
    a = A - E^2/4/B; 
    b = -D*E/2/B + C; 
    c = - D^2/4/B + F; 
    deltalpha1 = abs(alpha1 - ec2grado(a,b,c));
    
    %Deltalpha2
    a = B - E^2/4/A;
    b = -E*C/2/A + D; 
    c = -C^2/4/A + F;
    deltalpha2 = abs(alpha2-ec2grado(a,b,c));

    % figure(Name="contorno")
    % plot(alpha1,alpha2,'k +',MarkerSize=8)
    % hold on
    % fcontour(g, "LevelList",0)
    % xlim([alpha1-1.1*deltalpha1, alpha1+1.1*deltalpha1]);
    % ylim([alpha2 - 1.1*deltalpha2, alpha2+1.1*deltalpha2]);
    % xlabel("\alpha_1");
    % ylabel("\alpha_2");
    % title("Contorno de \chi^2 y errores")
    % hold on 
    % fcontour(@(x,y) 2*B*y + D + E*x, "LevelList",0);
    % hold on
    % fcontour(@(x,y) 2*A*x + C + E*y, "LevelList",0);
    % grid on

end


function [xsol1, xsol2] = ec2grado(a,b,c)
dis = b^2-4*a*c;
if (dis>=0)
xsol1 = (-b + sqrt(dis))/2/a;
xsol2 = (-b - sqrt(dis))/2/a;
end
if (dis<0)
fprintf("Discriminante: %d",dis);
xsol1=0;
xsol2=0;
end
end

function [chi] = chi(x,y,sigma,alpha1,alpha2)
%(x,y): vectores con puntos experimentales
%sigma: vectores con incertidumbres de la variable con mayor incertidumbre
%chi es la función chi cuadrado
chi =0;
sigma2 = sigma.^2;
for j = 1:numel(x)
chi = chi + (y(j)-alpha1*x(j)-alpha2)^2/sigma2(j);
end
end
