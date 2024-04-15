function [numer_indeksu, Edges, I, B, A, b, r] = page_rank()
numer_indeksu = 193320;
    numer_indeksu = 193320; % l1=2, l2=3
    Edges = [1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 7, 8;
             4, 6, 3, 4, 5, 5, 6, 7, 5, 6, 8, 4, 6, 4, 7, 6, 3];
    
    N = 8;
    d = 0.85;
    
    I = speye(N);
    B = sparse(Edges(2,:), Edges(1,:), 1, N, N);
    
    L = zeros([size(B,1),1]);
    for i = 1 : size(B,1)
        for j = 1 : size(B,1)
            L(i) = L(i) + B(j,i);
        end
        L(i) = 1/L(i);
    end
    
    A = spdiags(L, 0, size(B,1), size(B,1));
    b = ((1 - d)/N) * ones(N, 1);
    
    M = I - d*B*A;
    r = M\b;
end
    