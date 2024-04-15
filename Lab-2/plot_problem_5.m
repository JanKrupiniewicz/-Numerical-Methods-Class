function plot_problem_5(N,time_Jacobi,time_Gauss_Seidel,iterations_Jacobi,iterations_Gauss_Seidel)
    % Opis wektorów stanowiących parametry wejściowe:
    % N - rozmiary analizowanych macierzy
    % time_Jacobi - czasy wyznaczenia rozwiązania metodą Jacobiego
    % time_Gauss_Seidel - czasy wyznaczenia rozwiązania metodą Gaussa-Seidla
    % iterations_Jacobi - liczba iteracji wymagana do wyznaczenia rozwiązania metodą Jacobiego
    % iterations_Gauss_Seide - liczba iteracji wymagana do wyznaczenia rozwiązania metodą Gauss-Seidla

    subplot(2, 1, 1);
    plot(N, time_Jacobi);
    hold on;
    plot(N, time_Gauss_Seidel);
    hold off;
    title('Czas obliczeń w zależności od rozmiaru macierzy');
    xlabel('Rozmiar macierzy');
    ylabel('Czas [s]');
    legend('Jacobi', 'Gauss-Seidel', 'Location', 'eastoutside');

    subplot(2, 1, 2);
    bar(N, [iterations_Jacobi; iterations_Gauss_Seidel]', 'grouped');
    title('Liczba iteracji w zależności od rozmiaru macierzy');
    xlabel('Rozmiar macierzy');
    ylabel('Liczba iteracji');
    legend('Jacobi', 'Gauss-Seidel', 'Location', 'eastoutside');
end
