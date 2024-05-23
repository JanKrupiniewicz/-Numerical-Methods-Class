function [country, source, degrees, x_coarse, x_fine, y_original, y_yearly, y_approximation, mse, msek] = zadanie5(energy)
    % Wybór kraju i źródła energii
    country = 'Poland'; % Przykładowy kraj
    source = 'Solar'; % Przykładowe źródło energii

    % Sprawdzenie dostępności danych
    if isfield(energy, country) && isfield(energy.(country), source)
        % Przygotowanie danych do aproksymacji
        y_original = energy.(country).(source).EnergyProduction;
        y_original_mean = movmean(y_original, [11, 0]);

        % Obliczenie danych rocznych
        n_years = floor(length(y_original) / 12);
        y_cut = y_original(end-12*n_years+1:end);
        y4sum = reshape(y_cut, [12, n_years]);
        y_yearly = sum(y4sum, 1)';

        % Przygotowanie danych do aproksymacji
        N = length(y_yearly);
        P = (N-1)*8+1; % liczba wartości funkcji aproksymującej
        x_coarse = linspace(0, 1, N)';
        x_fine = linspace(0, 1, P)';

        % Inicjalizacja wyników
        y_approximation = cell(1, N-1);
        mse = zeros(N-1, 1);
        msek = zeros(N-2, 1);
        

        % Obliczenie współczynników DCT dla danych rocznych
        for i = 1:N-1
            X = dct2_custom(y_yearly, i);
            y_coarse_approx = idct2_custom(X, i, N, N);
            y_fine_approx = idct2_custom(X, i, N, P);
            y_approximation{i} = y_fine_approx; % Przechowywanie wyniku aproksymacji
            
            % Obliczenie błędu średniokwadratowego (MSE)
            mse(i) = mean((y_yearly - y_coarse_approx).^2);
        end

        % Obliczenie błędów różnicowych między aproksymacjami kolejnych stopni
        for i = 1:N-2
            msek(i) = mean((y_approximation{i} - y_approximation{i+1}).^2);
        end

        % Wybór stopni aproksymacji do wyświetlenia na wykresie
        degrees = [1, 3, 5, 7];

        % Tworzenie wykresów
        figure;

        % Górny wykres - dane roczne i aproksymacje
        subplot(3, 1, 1);
        plot(x_coarse, y_yearly, 'k', 'DisplayName', 'Dane roczne');
        hold on;
        colors = ['r', 'g', 'b', 'm']; % Kolory dla różnych aproksymacji
        for i = 1:length(degrees)
            plot(x_fine, y_approximation{degrees(i)}, colors(i), 'DisplayName', ['Stopień ' num2str(degrees(i))]);
        end
        hold off;
        xlabel('Normalizowane Daty');
        ylabel('Produkcja Energii');
        title('Aproksymacja Cosinusowa Produkcji Energii (Roczne)');
        legend;

        % Środkowy wykres - wartości błędów średniokwadratowych (MSE)
        subplot(3, 1, 2);
        semilogy(1:N-1, mse, 'b-o');
        xlabel('Stopień Aproksymacji');
        ylabel('Błąd Średniokwadratowy (MSE)');
        title('Błąd Średniokwadratowy dla Aproksymacji Cosinusowej');
        grid on;

        % Dolny wykres - błędy różnicowe (MSEK)
        subplot(3, 1, 3);
        semilogy(1:N-2, msek, 'r-o');
        xlabel('Stopień Aproksymacji');
        ylabel('Błąd Różnicowy (MSEK)');
        title('Zbieżność Funkcji Aproksymujących');
        grid on;

        % Zapisanie wykresu do pliku
        saveas(gcf, 'zadanie5.png');

    else
        disp(['Dane dla (country=', country, ') oraz (source=', source, ') nie są dostępne.']);
    end

end

function X = dct2_custom(x, kmax)
    % Wyznacza kmax pierwszych współczynników DCT-2 dla wektora wejściowego x.
    N = length(x);
    X = zeros(kmax, 1);
    c2 = sqrt(2/N);
    c3 = pi/2/N;
    nn = (1:N)';

    X(1) = sqrt(1/N) * sum(x(nn));
    for k = 2:kmax
        X(k) = c2 * sum(x(nn) .* cos(c3 * (2*(nn-1)+1) * (k-1)));
    end
end

function x = idct2_custom(X, kmax, N, P)
    % Wyznacza wartości aproksymacji cosinusowej x.
    % X - współczynniki DCT
    % kmax - liczba współczynników DCT zastosowanych do wyznaczenia wektora x
    % N - liczba danych dla których została wyznaczona macierz X
    % P - długość zwracanego wektora x (liczba wartości funkcji aproksymującej w przedziale [0,1])
    x = zeros(P, 1);
    kk = (2:kmax)';
    c1 = sqrt(1/N);
    c2 = sqrt(2/N);
    c3 = pi*(N - 1)/(2*N*(P - 1));
    c4 = -(pi*(N - P))/(2*N*(P - 1));

    for n = 1:P
        x(n) = c1*X(1) + c2*sum(X(kk) .* cos((c3*(2*(n-1)+1)+c4) * (kk-1)));
    end
end
