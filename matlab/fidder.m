function [M]=fidder(name)
archive=[name,'.txt'];
fid = fopen(archive, 'r');
if fid == -1
    error('No se puede abrir el fichero');
end

% Leer el contenido del fichero
contenido = fscanf(fid, '%c');
fclose(fid);

% Reemplazar comas por puntos
contenido = strrep(contenido, ',', '.');

% Reemplazar punto-y-coma por espacios
contenido = strrep(contenido, ';', ' ');

% Convertir el contenido en una matriz
M = str2num(contenido);

% Mostrar la matriz
%disp(M);


