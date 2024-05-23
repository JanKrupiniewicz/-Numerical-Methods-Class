function [country, source, degrees, y_original, y_movmean, y_approximation, mse] = zadanie2(energy)
% Głównym celem tej funkcji jest wyznaczenie aproksymacji wygładzonych danych o produkcji energii elektrycznej w wybranym kraju i z wybranego źródła energii.
% Wygładzenie danych wykonane jest poprzez wywołanie funkcji movmean.
% Wybór kraju i źródła energii należy określić poprzez nadanie w tej funkcji wartości zmiennym typu string: country, source.
% Dopuszczalne wartości tych zmiennych można sprawdzić poprzez sprawdzenie zawartości struktury energy zapisanej w pliku energy.mat.
% 
% energy - struktura danych wczytana z pliku energy.mat
% country - [String] nazwa kraju
% source  - [String] źródło energii
% degrees - wektor zawierający cztery stopnie wielomianu dla których wyznaczono aproksymację
% y_original - dane wejściowe, czyli pomiary produkcji energii zawarte w wektorze energy.(country).(source).EnergyProduction
% y_movmean - średnia 12-miesięczna danych wejściowych, y_movmean = movmean(y_original,[11,0]);
% y_approximation - tablica komórkowa przechowująca cztery wartości funkcji aproksymującej wygładzone dane wejściowe. y_approximation stanowi aproksymację stopnia degrees(i).
% mse - wektor o rozmiarze 4x1: mse(i) zawiera wartość błędu średniokwadratowego obliczonego dla aproksymacji stopnia degrees(i).

country = 'India';
source = 'Solar';
degrees = [1, 5, 15, 25];
y_original = [];
y_approximation= cell(1, length(degrees));
mse = zeros(1, length(degrees));

% Sprawdzenie dostępności danych
if isfield(energy, country) && isfield(energy.(country), source)
    % Przygotowanie danych do aproksymacji
    dates = energy.(country).(source).Dates;
    y_original = energy.(country).(source).EnergyProduction;
    y_movmean = movmean(y_original,[11,0]);

    x = linspace(-1,1,length(y_original))';

    % Pętla po wielomianach różnych stopni
    for i = 1:length(degrees)
        p_movmean = polyfit(x, y_movmean, degrees(i)); % Aproksymacja wielomianowa
        y_approx_movmean = polyval(p_movmean, x); % Wyznaczenie wartości aproksymacji
        y_approximation{i} = y_approx_movmean; % Przechowywanie wyniku aproksymacji
        mse(i) = mean((y_movmean - y_approx_movmean).^2); % Obliczenie błędu średniokwadratowego
    end

     % Tworzenie wykresów
    figure;
    
    % Górny wykres - dane oryginalne, wygładzone i aproksymacje
    subplot(2, 1, 1);
    plot(x, y_original, 'k', 'DisplayName', 'Oryginalne dane');
    hold on;
    plot(x, y_movmean, 'b', 'DisplayName', 'Średnia ruchoma');
    colors = ['r', 'g', 'm', 'c']; % Kolory dla różnych aproksymacji
    for i = 1:length(degrees)
        plot(x, y_approximation{i}, colors(i), 'DisplayName', ['Stopień ' num2str(degrees(i))]);
    end
    hold off;
    xlabel('Normalizowane Daty');
    ylabel('Produkcja Energii');
    title('Aproksymacja Wielomianowa Produkcji Energii');
    legend;
    
    % Dolny wykres - błąd średniokwadratowy
    subplot(2, 1, 2);
    bar(mse);
    set(gca, 'XTickLabel', degrees);
    xlabel('Stopień Wielomianu');
    ylabel('Błąd Średniokwadratowy');
    title('Błąd Średniokwadratowy dla Aproksymacji');
    
    % Zapisanie wykresu do pliku
    saveas(gcf, 'zadanie2.png');

else
    disp(['Dane dla (country=', country, ') oraz (source=', source, ') nie są dostępne.']);
end

end