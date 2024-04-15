function plot_direct(N,vtime_direct)
    % N - wektor zawierający rozmiary macierzy dla których zmierzono czas obliczeń metody bezpośredniej
    % vtime_direct - czas obliczeń metody bezpośredniej dla kolejnych wartości N
    n = length(N);
    for i = 1:n
        [~, ~, ~, time_direct, ~, ~] = solve_direct(N(i));
        vtime_direct(i) = time_direct;
    end

    plot(N, vtime_direct);
    xlabel('Matrix Size');
    ylabel('Time (s)');
    title('Time taken by Direct Solver vs Matrix Size');
end