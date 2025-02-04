function [xsolution,ysolution,iterations,xtab,xdif] = bisection_method(a,b,max_iterations,ytolerance,fun)
% a - lewa granica przedziału poszukiwań miejsca zerowego
% b - prawa granica przedziału poszukiwań miejsca zerowego
% max_iterations - maksymalna liczba iteracji działania metody bisekcji
% ytolerance - wartość abs(fun(xsolution)) powinna być mniejsza niż ytolerance
% fun - nazwa funkcji, której miejsce zerowe będzie wyznaczane
%
% xsolution - obliczone miejsce zerowe
% ysolution - wartość fun(xsolution)
% iterations - liczba iteracji wykonana w celu wyznaczenia xsolution
% xtab - wektor z kolejnymi kandydatami na miejsce zerowe, począwszy od xtab(1)= (a+b)/2
% xdiff - wektor wartości bezwzględnych z różnic pomiędzy i-tym oraz (i+1)-ym elementem wektora xtab; xdiff(1) = abs(xtab(2)-xtab(1));

    xsolution = [];
    ysolution = [];
    iterations = [];
    xtab = [];
    xdif = [];

    for k = 1:max_iterations
        c = (a + b)/2;
        xtab = [xtab; c];
        if abs(fun(c)) < ytolerance || abs(b - a) < 1e-12
            xsolution = c;
            ysolution = fun(c);
            iterations = k;
            break;
        elseif fun(a)*fun(c) < 0
            b = c;
        else 
            a = c;
        end
    end
    xdif = abs(diff(xtab));
end