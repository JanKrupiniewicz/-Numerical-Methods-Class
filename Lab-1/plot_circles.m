function plot_circles(a, circles, index_number)
    % R - promień okręgu
    % X - współrzędna x środka okręgu
    % Y - współrzędna y środka okręgu
    axis equal;
    axis([0 a 0 a]);

    for i = 1:size(circles, 1)
        hold on;
        plot_circle(circles(i, 3), circles(i, 1), circles(i, 2));
        hold off;
        pause(0.1);
    end
end