function [circles, index_number, circle_areas, rand_counts, counts_mean] = generate_circles(a, r_max, n_max)
    index_number = 193320;
    circle_areas = zeros(1, n_max);
    rand_counts = ones(1, n_max);
    counts_mean = zeros(1, n_max);
    circles = zeros(n_max, 3);
    
    for i = 1:n_max
        checkCircle = true;
        while checkCircle 
            X = abs(mod(rand() * a, a));
            Y = abs(mod(rand() * a, a));
            R = abs(mod(rand() * r_max, r_max));
            checkCircle = false;
            for j = 1:i-1
                d = sqrt(power((circles(j, 1) - X), 2) + power((circles(j, 2) - Y), 2));
                if (R + circles(j, 3)) > abs(d)
                    checkCircle = true;
                    rand_counts(i) = rand_counts(i) + 1;
                    break;
                end
            end

            if (Y + R > a) || (X + R > a) || (X - R < 0) || (Y - R < 0)
                checkCircle = true;
                rand_counts(i) = rand_counts(i) + 1;
            end
        end 

        circle_areas(i) = pi*power(R, 2);
        counts_mean(i) = mean(rand_counts(1:i));

        circles(i, 1) = X;
        circles(i, 2) = Y;
        circles(i, 3) = R;
    end
    circle_areas = cumsum(circle_areas);
end
