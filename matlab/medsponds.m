%% Medias ponderadas

function [m,dm] = medpond(x,dx)
% Promedia X teniendo en cuenta las incertidumbres de cada punto
    m = sum(x./dx.^2)./sum( dx.^(-2) );
    dm = sqrt(sum( dx.^(-2) )).^(-1);
end

function [m,dm] = medpond2(x)
% Promedia X en función de lo cercanos al valor medio que estén los puntos 
% (Resta peso a los más alejados)
    xo = mean(x); dx=abs(x-xo);
    m = sum(x./dx.^2)./sum( dx.^(-2) );
    dm = sqrt(sum( dx.^(-2) )).^(-1);
end

function [m,dm] = medpond3(x,dx,dr)
% Utiliza un peso externo a la propia incertidumbre de la medida
    m = sum(x./dr.^2)./sum( dr.^(-2) );
    dm = sqrt(sum( dx.^(-2) )).^(-1);
end
