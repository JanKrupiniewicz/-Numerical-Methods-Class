
%% Task 6
% Wczytanie danych
load('filtr_dielektryczny.mat');

% Metoda 1: Rozwiązanie dokładne
x_exact = A\b;
residual_exact = norm(A*x_exact - b);
residual_exact

% Metoda Jacobiego
[~,~,~,~,x_Jacobi,~,~,~,~] = solve_Jacobi_m(A, b);
residual_norm_Jacobi = norm(A * x_Jacobi - b);
residual_norm_Jacobi

% Metoda Gaussa-Seidela
[~,~,~,~,x_Gauss_Seidel,~,~,~,~] = solve_Gauss_Seidel_m(A, b);
residual_norm_Gauss_Seidel = norm(A * x_Gauss_Seidel - b);
residual_norm_Gauss_Seidel