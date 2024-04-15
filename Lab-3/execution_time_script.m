%% Task 6
a = 1;
b = 60000;
ytolerance = 1e-12;
max_iterations = 100;

[n_bisection, ~, ~, xtab_bisection, xdif_bisection] = bisection_method(a, b, max_iterations, ytolerance, @estimate_execution_time);
[n_secant, ~, ~, xtab_secant, xdif_secant] = secant_method(a, b, max_iterations, ytolerance, @estimate_execution_time);

figure;
subplot(2,1,1);
plot(1:length(xtab_bisection), xtab_bisection, 'DisplayName', 'Bisection Method');
hold on;
plot(1:length(xtab_secant), xtab_secant, 'DisplayName', 'Secant Method');
xlabel('Iteration');
ylabel('x approximation');
title('Iterations vs. x approximation');
legend;

subplot(2,1,2);
semilogy(1:length(xdif_bisection), xdif_bisection, 'DisplayName', 'Bisection Method');
hold on;
semilogy(1:length(xdif_secant), xdif_secant, 'DisplayName', 'Secant Method');
xlabel('Iteration');
ylabel('Difference in x approximation');
title('Iterations vs. Difference in x approximation');
legend;
