function [lake_volume, x, y, z, zmin] = zadanie5()
    % Funkcja zadanie5 wyznacza objętość jeziora metodą Monte Carlo.
    %
    %   lake_volume - objętość jeziora wyznaczona metodą Monte Carlo
    %
    %   x - wektor wierszowy, który zawiera współrzędne x wszystkich punktów
    %       wylosowanych w tej funkcji w celu wyznaczenia obliczanej całki.
    %
    %   y - wektor wierszowy, który zawiera współrzędne y wszystkich punktów
    %       wylosowanych w tej funkcji w celu wyznaczenia obliczanej całki.
    %
    %   z - wektor wierszowy, który zawiera współrzędne z wszystkich punktów
    %       wylosowanych w tej funkcji w celu wyznaczenia obliczanej całki.
    %
    %   zmin - minimalna dopuszczalna wartość współrzędnej z losowanych punktów
    N = 1e6;
    zmin = 55*rand() - 100;
    x = 100*rand(1,N);
    y = 100*rand(1,N);
    z = rand(1, N)*zmin;

    N1 = 0;
    for i = 1:N
        px = x(i);
        py = y(i);
        pz = z(i);
        
        depth = get_lake_depth(px, py);
        
        if pz > depth
            N1 = N1 + 1;
        end
    end

    V = 100*100*abs(zmin);
    lake_volume = V * (N1/N);
    disp(lake_volume);
end