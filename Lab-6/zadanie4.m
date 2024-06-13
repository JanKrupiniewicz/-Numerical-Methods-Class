function [integration_error, Nt, ft_5, xr, yr, yrmax] = zadanie4()
    % Numeryczne całkowanie metodą Monte Carlo.
    %
    %   integration_error - wektor wierszowy. Każdy element integration_error(1,i)
    %       zawiera błąd całkowania obliczony dla liczby losowań równej Nt(1,i).
    %       Zakładając, że obliczona wartość całki dla Nt(1,i) próbek wynosi
    %       integration_result, błąd jest definiowany jako:
    %       integration_error(1,i) = abs(integration_result - reference_value),
    %       gdzie reference_value to wartość referencyjna całki.
    %
    %   Nt - wektor wierszowy zawierający liczby losowań, dla których obliczano
    %       wektor błędów całkowania integration_error.
    %
    %   ft_5 - gęstość funkcji prawdopodobieństwa dla n=5
    %
    %   [xr, yr] - tablice komórkowe zawierające informacje o wylosowanych punktach.
    %       Tablice te mają rozmiar [1, length(Nt)]. W komórkach xr{1,i} oraz yr{1,i}
    %       zawarte są współrzędne x oraz y wszystkich punktów zastosowanych
    %       do obliczenia całki przy losowaniu Nt(1,i) punktów.
    %
    %   yrmax - maksymalna dopuszczalna wartość współrzędnej y losowanych punktów

    reference_value = 0.0473612919396179; % wartość referencyjna całki
    Nt = 5:50:10^4;
    xr = cell(1, length(Nt));
    yr = cell(1, length(Nt));
    integration_error = zeros(1, length(Nt));
    
    for i = 1:length(Nt)
        [integration_result, xr{i}, yr{i}, yrmax] = calculate_monteCarlo_method(@f, Nt(i));
        integration_error(i) = abs(integration_result-reference_value);
    end

    ft_5 = f(5);

    loglog(Nt, integration_error);
    xlabel('Liczby podprzedziałów całkowania N');
    ylabel('Błąd całkowania');
    title('Błąd całkowania metodą Monte Carlo');
    saveas(gcf, 'zadanie4.png');
end

function [result, xr, yr, yrmax] = calculate_monteCarlo_method(f, N)
    xr = zeros(1, length(N));
    yr = zeros(1, length(N));
    yrmax = 2 * f(5);
    
    result = 0;
    a = 0;
    b = 5;
    delta_x = (b - a)/N;

    N1 = 0;
    S = (b - a)*yrmax;

    for i = 1:N
        xr(i) = a + rand()*(b - a);
        yr(i) = yrmax * rand();
        if f(xr(i)) >= yr(i)
            N1 = N1 + 1;
        end
    end
    
    result = S * (N1/N);
end

function y = f(t)
    mi = 10;
    sigma = 3;
    y = 1/(sigma * sqrt(2*pi)) * exp((-(t-mi)^2)/(2*sigma^2));
end