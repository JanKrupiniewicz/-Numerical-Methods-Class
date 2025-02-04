%% Task 1
omega = 10
impedance_delta = impedance_magnitude(omega)

%% Task 2
format long
f = @(x) x.^2 - 4.01;
a = 0;
b = 4;
max_iterations = 100;
ytolerance = 1e-12;
[xsolution,ysolution,iterations,xtab,xdif] = bisection_method(a,b,max_iterations,ytolerance,f)

%% Task 3
format long
f = @(x) x.^2 - 4.01;
a = 0;
b = 4;
max_iterations = 100;
ytolerance = 1e-12;
[xsolution,ysolution,iterations,xtab,xdif] = secant_method(a,b,max_iterations,ytolerance,f)

% Task 4 - rlc_script.m

%% Task 5
time = 10 
velocity_delta = rocket_velocity(time)

% Task 6 - rocket_velocity_script.m

%% Task 7
N = 40000;
time_delta = estimate_execution_time(N)

% Task 8 - execution_time_script.m
% Task 9 - tan_zero.m