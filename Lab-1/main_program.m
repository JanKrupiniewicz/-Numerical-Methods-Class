
%% Pęcherzyki Task 1
a = 1000;
r_max = a/2;
n_max = 200;

[circles, index_number, circle_areas, rand_counts, counts_mean] = generate_circles(a, r_max, n_max);
plot_circles(a, circles, index_number);

%% Pęcherzyki Task 2, 3
plot_circle_areas(circle_areas);

%% Pęcherzyki Task 4, 5
plot_counts_mean(counts_mean);

%% PageRank Task 6
[numer_indeksu, Edges, I, B, A, b, r] = page_rank();

%% PageRank Task 6
plot_PageRank(r);
