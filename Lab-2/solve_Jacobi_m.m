function [A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Jacobi_m(A, b)
    % A - macierz z równania macierzowego A * x = b
    % b - wektor prawej strony równania macierzowego A * x = b
    % M - macierz pomocnicza opisana w instrukcji do Laboratorium 3 – sprawdź wzór (5) w instrukcji, który definiuje M jako M_J.
    % bm - wektor pomocniczy opisany w instrukcji do Laboratorium 3 – sprawdź wzór (5) w instrukcji, który definiuje bm jako b_{mJ}.
    % x - rozwiązanie równania macierzowego
    % err_norm - norma błędu rezydualnego rozwiązania x; err_norm = norm(A*x-b)
    % time - czas wyznaczenia rozwiązania x
    % iterations - liczba iteracji wykonana w procesie iteracyjnym metody Jacobiego
    index_number = 193320;

    L = tril(A, -1);
    U = triu(A, 1);
    D = diag(diag(A));
    
    x = ones(size(A, 2),1);
    M = -D\(L + U);
    bm = D\b;
    iterations = 1000;

    tic
    for i = 1:iterations
       err_norm = norm(A*x-b);
        if err_norm < 1E-12
            break
        end
        x = M*x + bm; 
    end
    time = toc;
end