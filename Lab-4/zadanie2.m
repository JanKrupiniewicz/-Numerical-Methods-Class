function [nodes_Chebyshev, V, V2, original_Runge, interpolated_Runge, interpolated_Runge_Chebyshev] = zadanie2()
    % nodes_Chebyshev - wektor wierszowy zawierający N=16 węzłów Czebyszewa drugiego rodzaju
    % V - macierz Vandermonde obliczona dla 16 węzłów interpolacji rozmieszczonych równomiernie w przedziale [-1,1]
    % V2 - macierz Vandermonde obliczona dla węzłów interpolacji zdefiniowanych w wektorze nodes_Chebyshev
    % original_Runge - wektor wierszowy zawierający wartości funkcji Runge dla wektora x_fine=linspace(-1, 1, 1000)
    % interpolated_Runge - wektor wierszowy wartości funkcji interpolującej określonej dla równomiernie rozmieszczonych węzłów interpolacji
    % interpolated_Runge_Chebyshev - wektor wierszowy wartości funkcji interpolującej wyznaczonej
    %       przy zastosowaniu 16 węzłów Czebyszewa zawartych w nodes_Chebyshev 
    N = 16;
    x_fine = linspace(-1, 1, 1000);

    original_Runge = 1./(1 + 25 * x_fine.^2);

    subplot(2,1,1);
    plot(x_fine, original_Runge); % Plot original Runge function
    hold on;

    nodes_uniform = linspace(-1, 1, N); % Uniformly spaced interpolation nodes
    y_uniform = 1./(1 + 25 * nodes_uniform.^2); % Function values at uniform nodes
    V = vandermonde_matrix_z2(N, nodes_uniform);
    c_runge_uniform = V\y_uniform'; % Calculate coefficients for uniform interpolation
    interpolated_Runge = polyval(flipud(c_runge_uniform), x_fine); % Interpolated Runge function
    plot(x_fine, interpolated_Runge); % Plot interpolated Runge function
    plot(nodes_uniform, y_uniform, 'o'); % Mark interpolated points
    title('Interpolation with Uniform Nodes')
    xlabel('x')
    ylabel('f(x)')
    legend('Original Runge', 'Interpolated Runge', 'Interpolated Points');
    hold off;

    subplot(2,1,2);
    plot(x_fine, original_Runge); % Plot original Runge function
    hold on;

    nodes_Chebyshev = get_Chebyshev_nodes(N); % Chebyshev interpolation nodes
    y_Chebyshev = 1./(1 + 25 * nodes_Chebyshev.^2); % Function values at Chebyshev nodes
    V2 = vandermonde_matrix_z2(N, nodes_Chebyshev);
    c_runge_Chebyshev = V2\y_Chebyshev'; % Calculate coefficients for Chebyshev interpolation
    interpolated_Runge_Chebyshev = polyval(flipud(c_runge_Chebyshev), x_fine); % Interpolated Runge function
    plot(x_fine, interpolated_Runge_Chebyshev); % Plot interpolated Runge function
    plot(nodes_Chebyshev, y_Chebyshev, 'o'); % Mark interpolated points
    title('Interpolation with Chebyshev Nodes')
    xlabel('x')
    ylabel('f(x)')
    legend('Original Runge', 'Interpolated Runge', 'Interpolated Points');
    hold off;
end

function nodes = get_Chebyshev_nodes(N)
    % Calculate N nodes of the second kind of Chebyshev
    nodes = cos((0:N-1)*pi / (N - 1));
end

function V = vandermonde_matrix_z2(N, x_coarse)
    % Generate Vandermonde matrix for given interpolation nodes
    V = zeros(N,N);
    for i = 1:N
        for j = 1:N
            V(i,j) = x_coarse(i)^(j - 1);
        end
    end
end