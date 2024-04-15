function [A,b,x,time_direct,err_norm,index_number] = solve_direct(N)
    % A - macierz z równania macierzowego A * x = b
    % b - wektor prawej strony równania macierzowego A * x = b
    % x - rozwiązanie równania macierzowego
    % time_direct - czas wyznaczenia rozwiązania x
    % err_norm - norma błędu rezydualnego rozwiązania x; err_norm = norm(A*x-b);
    % index_number - Twój numer indeksu
    index_number = 193320;
    L1 = 0;
    [A,b] = generate_matrix(N, L1);
    tic;
    x = A\b;
    time_sparse = toc;

    time_direct = time_sparse;
    err_norm = norm(A*x-b);
end