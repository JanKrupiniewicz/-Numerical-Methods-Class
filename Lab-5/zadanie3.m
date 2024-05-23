function [country, source, degrees, x_coarse, x_fine, y_original, y_yearly, y_approximation, mse] = zadanie3(energy)
% Głównym celem tej funkcji jest wyznaczenie aproksymacji rocznych danych o produkcji energii elektrycznej w wybranym kraju i z wybranego źródła energii.
% Wybór kraju i źródła energii należy określić poprzez nadanie w tej funkcji wartości zmiennym typu string: country, source.
% Dopuszczalne wartości tych zmiennych można sprawdzić poprzez sprawdzenie zawartości struktury energy zapisanej w pliku energy.mat.
% 
% energy - struktura danych wczytana z pliku energy.mat
% country - [String] nazwa kraju
% source  - [String] źródło energii
% degrees - wektor zawierający cztery stopnie wielomianu dla których wyznaczono aproksymację
% x_coarse - wartości x danych aproksymowanych; wektor o rozmiarze [N,1].
% x_fine - wartości, w których wyznaczone zostaną wartości funkcji aproksymującej; wektor o rozmiarze [P,1].
% y_original - dane wejściowe, czyli pomiary produkcji energii zawarte w wektorze energy.(country).(source).EnergyProduction
% y_yearly - wektor danych rocznych (wektor kolumnowy).
% y_approximation - tablica komórkowa przechowująca cztery wartości funkcji aproksymującej dane roczne.
%   - y_approximation{i} stanowi aproksymację stopnia degrees(i)
%   - y_approximation{i} stanowi wartości funkcji aproksymującej w punktach x_fine.
% mse - wektor o rozmiarze [4,1]: mse(i) zawiera wartość błędu średniokwadratowego obliczonego dla aproksymacji stopnia degrees(i).

country = 'India';
source = 'Solar';
degrees = 1:4;
x_coarse = [];
x_fine = [];
y_original = [];
y_yearly = [];
y_approximation = cell(1, length(degrees));
mse = zeros(1, 4);

% Sprawdzenie dostępności danych
if isfield(energy, country) && isfield(energy.(country), source)
    % Przygotowanie danych do aproksymacji
    dates = energy.(country).(source).Dates;
    y_original = energy.(country).(source).EnergyProduction;

    % Obliczenie danych rocznych
    n_years = floor(length(y_original) / 12);
    y_cut = y_original(end-12*n_years+1:end);
    y4sum = reshape(y_cut, [12 n_years]);
    y_yearly = sum(y4sum,1)';

    degrees = 1:4;

    N = length(y_yearly);
    P = 10*N;
    x_coarse = linspace(-1, 1, N)';
    x_fine = linspace(-1, 1, P)';

    % Pętla po wielomianach różnych stopni
    for i = 1:length(degrees)
        p = my_polyfit(x_coarse, y_yearly, degrees(i)); % Aproksymacja wielomianowa
        y_approx = polyval(p, x_fine); % Wyznaczenie wartości aproksymacji
        y_approximation{i} = y_approx; % Przechowywanie wyniku aproksymacji
        y_coarse_approx = polyval(p, x_coarse);
        mse(i) = mean((y_yearly - y_coarse_approx).^2); % Obliczenie błędu średniokwadratowego
    end

    % Tworzenie wykresów
    figure;

    % Górny wykres - dane roczne i aproksymacje
    subplot(2, 1, 1);
    plot(x_coarse, y_yearly, 'k', 'DisplayName', 'Dane roczne');
    hold on;
    colors = ['r', 'g', 'm', 'c']; % Kolory dla różnych aproksymacji
    for i = 1:length(degrees)
        plot(x_fine, y_approximation{i}, colors(i), 'DisplayName', ['Stopień ' num2str(degrees(i))]);
    end
    hold off;
    xlabel('Normalizowane Daty');
    ylabel('Produkcja Energii');
    title('Aproksymacja Wielomianowa Produkcji Energii (Roczne)');
    legend;

    % Dolny wykres - błąd średniokwadratowy
    subplot(2, 1, 2);
    bar(mse);
    set(gca, 'XTickLabel', degrees);
    xlabel('Stopień Wielomianu');
    ylabel('Błąd Średniokwadratowy');
    title('Błąd Średniokwadratowy dla Aproksymacji');

    % Zapisanie wykresu do pliku
    saveas(gcf, 'zadanie3.png');

else
    disp(['Dane dla (country=', country, ') oraz (source=', source, ') nie są dostępne.']);
end

end

function p = my_polyfit(x, y, deg)
    V = zeros(length(x), deg+1);

    for i = 1:length(x)
        for j = 1:(deg+1)
            V(i, j) = x(i)^(deg+1-j);
        end
    end


    p = (V' * V) \ (V' * y);
end
