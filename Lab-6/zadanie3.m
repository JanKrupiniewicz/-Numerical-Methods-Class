function [integration_error, Nt, ft_5, integral_1000] = zadanie3()
    % Numeryczne całkowanie metodą Simpsona.
    % Nt - wektor zawierający liczby podprzedziałów całkowania
    % integration_error - integration_error(1,i) zawiera błąd całkowania wyznaczony
    %   dla liczby podprzedziałów równej Nt(i). Zakładając, że obliczona wartość całki
    %   dla Nt(i) liczby podprzedziałów całkowania wyniosła integration_result,
    %   to integration_error(1,i) = abs(integration_result - reference_value),
    %   gdzie reference_value jest wartością referencyjną całki.
    % ft_5 - gęstość funkcji prawdopodobieństwa dla n=5
    % integral_1000 - całka od 0 do 5 funkcji gęstości prawdopodobieństwa
    %   dla 1000 podprzedziałów całkowania

    reference_value = 0.0473612919396179; % wartość referencyjna całki

    Nt = 5:50:10^4;
    integration_error = zeros(1, length(Nt));
    
    for i = 1:length(Nt)
        integration_result = calculate_simpson_method(@f, Nt(i));
        integration_error(i) = abs(integration_result-reference_value);
    end

    loglog(Nt, integration_error);
    xlabel('Liczby podprzedziałów całkowania N');
    ylabel('Błąd całkowania');
    title('Błąd całkowania metodą Simpsona');
    saveas(gcf, 'zadanie3.png');

    ft_5 = f(5);
    integral_1000 = calculate_simpson_method(@f, 1000);
end

function result = calculate_simpson_method(f, N)
    result = 0;
    a = 0;
    b = 5;
    delta_x = (b - a)/N;

    for i = 1:N
        x_i = a + (i - 1)*delta_x;
        next_x_i = a + i*delta_x;
        result = result + f(x_i) + 4*f((x_i + next_x_i)/2) + f(next_x_i);
    end
    result = (result * delta_x)/6;
end

function y = f(t)
    mi = 10;
    sigma = 3;
    y = 1/(sigma * sqrt(2*pi)) * exp((-(t-mi)^2)/(2*sigma^2));
end