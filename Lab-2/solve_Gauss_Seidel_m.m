function [A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Gauss_Seidel(A, b)
    % A - macierz rzadka z równania macierzowego A * x = b
    % b - wektor prawej strony równania macierzowego A * x = b
    % M - macierz pomocnicza opisana w instrukcji do Laboratorium 3 – sprawdź wzór (7) w instrukcji, który definiuje M jako M_{GS}
    % bm - wektor pomocniczy opisany w instrukcji do Laboratorium 3 – sprawdź wzór (7) w instrukcji, który definiuje bm jako b_{mGS}
    % x - rozwiązanie równania macierzowego
    % err_norm - norma błędu rezydualnego rozwiązania x; err_norm = norm(A*x-b)
    % time - czas wyznaczenia rozwiązania x
    index_number = 193320;

    L = tril(A, -1);
    U = triu(A, 1);
    D = diag(diag(A));
    
    x = ones(size(A, 2),1);
    M = -(D + L)\U;
    bm = (D + L)\b;
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