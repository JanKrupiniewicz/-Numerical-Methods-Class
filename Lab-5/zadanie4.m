function [country, source, degrees, x_coarse, x_fine, y_original, y_yearly, y_approximation, mse, msek] = zadanie4(energy)
    % Głównym celem tej funkcji jest wyznaczenie danych na potrzeby analizy dokładności aproksymacji wielomianowej.
    % 
    % energy - struktura danych wczytana z pliku energy.mat
    % country - [String] nazwa kraju
    % source  - [String] źródło energii
    % x_coarse - wartości x danych aproksymowanych
    % x_fine - wartości, w których wyznaczone zostaną wartości funkcji aproksymującej
    % y_original - dane wejściowe, czyli pomiary produkcji energii zawarte w wektorze energy.(country).(source).EnergyProduction
    % y_yearly - wektor danych rocznych
    % y_approximation - tablica komórkowa przechowująca wartości nmax funkcji aproksymujących dane roczne.
    %   - nmax = length(y_yearly)-1
    %   - y_approximation{1,i} stanowi aproksymację stopnia i
    %   - y_approximation{1,i} stanowi wartości funkcji aproksymującej w punktach x_fine
    % mse - wektor mający nmax wierszy: mse(i) zawiera wartość błędu średniokwadratowego obliczonego dla aproksymacji stopnia i.
    %   - mse liczony jest dla aproksymacji wyznaczonej dla wektora x_coarse
    % msek - wektor mający (nmax-1) wierszy: msek zawiera wartości błędów różnicowych zdefiniowanych w treści zadania 4
    %   - msek(i) porównuj aproksymacje wyznaczone dla i-tego oraz (i+1) stopnia wielomianu
    %   - msek liczony jest dla aproksymacji wyznaczonych dla wektora x_fine
    country = 'Poland'; % Przykładowy kraj
    source = 'Solar'; % Przykładowe źródło energii
    degrees = [];
    x_coarse = [];
    x_fine = [];
    y_original = [];
    y_yearly = [];
    y_approximation = [];
    mse = [];
    msek = [];

    % Sprawdzenie dostępności danych
    if isfield(energy, country) && isfield(energy.(country), source)
        % Przygotowanie danych do aproksymacji
        y_original = energy.(country).(source).EnergyProduction;

        % Obliczenie danych rocznych
        n_years = floor(length(y_original) / 12);
        y_cut = y_original(end-12*n_years+1:end);
        y4sum = reshape(y_cut, [12, n_years]);
        y_yearly = sum(y4sum, 1)';

        degrees = [1, 2, 3, 4];

        % Definicja x_coarse i x_fine
        N = length(y_yearly);
        P = (N-1)*10+1;
        x_coarse = linspace(-1, 1, N)';
        x_fine = linspace(-1, 1, P)';

        % Inicjalizacja wyników
        y_approximation = cell(1, N-1);
        mse = zeros(N-1, 1);
        msek = zeros(N-2, 1);

        % Pętla po wielomianach różnych stopni
        for i = 1:N-1
            p = my_polyfit(x_coarse, y_yearly, i); % Aproksymacja wielomianowa
            y_coarse_approx = polyval(p, x_coarse);
            y_fine_approx = polyval(p, x_fine);
            y_approximation{i} = y_fine_approx; % Przechowywanie wyniku aproksymacji
            
            % Obliczenie błędu średniokwadratowego (MSE)
            mse(i) = mean((y_yearly - y_coarse_approx).^2); 
        end

        for i = 1:N-2
            msek(i) = mean((y_approximation{i} - y_approximation{i+1}).^2);
        end
        
        figure;
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
        title('Aproksymacja Wielomianowa Produkcji Energii (Roczne)');
        legend;

        subplot(3, 1, 2);
        semilogy(1:N-1, mse, 'b-o');
        xlabel('Stopień Wielomianu');
        ylabel('Błąd Średniokwadratowy (MSE)');
        title('Błąd Średniokwadratowy dla Aproksymacji');
        grid on;

        subplot(3, 1, 3);
        semilogy(1:N-2, msek, 'r-o');
        xlabel('Stopień Wielomianu');
        ylabel('Błąd Różnicowy (MSEK)');
        title('Zbieżność Funkcji Aproksymujących');
        grid on;

        saveas(gcf, 'zadanie4.png');

else
    disp(['Dane dla (country=', country, ') oraz (source=', source, ') nie są dostępne.']);
end

end

function p = my_polyfit(x, y, deg)
    % Tworzenie macierzy Vandermonde'a o wymiarach [length(x) x (deg+1)]
    V = zeros(length(x), deg+1);

    for i = 1:length(x)
        for j = 1:(deg+1)
            V(i, j) = x(i)^(deg+1-j);
        end
    end

    % Rozwiązanie równania normalnego V'V * p = V'y
    p = (V' * V) \ (V' * y);
end
