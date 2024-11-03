clc
clear
close all

%% Identify the optimal production plan for the next three months, in a way that it can meet demand without delays.

% 1st step: Define the decision variables

% 3 months: no of normal hours, no of extra hours
% x_ij - quantity of x produced in way i ∈ {N,E} in month j = 1,2,3, N-
% normal, E - extra, altogether 6 variables

% how many products will be stocked in every month
% s_j - quantity in stock at the end of month j = 1,2,3
% auxilary variable - just to make it simpler, we don't have to use it, but
% then the objective function will be much longer

% 2nd step: Create the objective function
% min F = 4*0.5*(x_N1 + x_N2 + x_N3) + 6.5*0.5*(x_E1 + x_E2 + x_E3) + 0.25*(s_1 +
% s_2 + s_3)
% because the time required for producing one unit of X is 0.5 hours

% 3rd step: Build the contraints

% meet the demand
% 1500 + x_N1 + x_E1 - s_1 = 35000
% s_1 + x_N2 + x_E2 - s_2 = 20000
% s_2 + x_N3 + x_E3 - s_3 = 40000

% do not exceed normal production capacity
% x_N1 <= 25000
% x_N2 <= 25000
% x_N3 <= 25000

% 25 units/worker * 100 workers = extra production capacity
% x_E1 <= 2500
% x_E2 <= 2500
% x_E3 <= 2500

% units are intigers
% x_ij ∈ N, i ∈ {N,E}, j = 1,2,3
% s_j ∈ N, ju = 1,2,3

% [x_N1 x_N2 x_N3 x_E1 x_E2 x_E3 s_1 s_2 s_3] - this is the order! 

f = [2 2 2 3.25 3.25 3.25 0.25 0.25 0.25]; %default is minimization so with "+"
% Ax <= B
% Aeq X <= Beq

a1 = [1 0 0 1 0 0 -1 0 0];
a2 = [0 1 0 0 1 0 1 -1 0]; 
a3 = [0 0 1 0 0 1 0 1 -1];


Aeq = [a1; a2; a3];
Beq = [35000-1500 20000 40000];
UB = [25000 25000 25000 2500 2500 2500 inf inf inf]; 
LB = zeros(1,9); 

[X, obj, flag] = intlinprog(f, (1:9), [], [], Aeq, Beq, LB, UB);

%flag is -2 so no feasible solution found, if 1 - found

%% Assume that in each month the company can hire and fire workers with the following costs

% Cost of hiring: 500.00€ / worker
% Cost of firing: 750.00€ / worker

% we add the following decision variables:
% Ri - number of workers to hire in month j=1,2,3
% Dj - number of workers to fire in month j=1,2,3

% Create the new objective function
% min Z = 4*0.5*(x_N1 + x_N2 + x_N3) + 6.5*0.5*(x_E1 + x_E2 + x_E3) + 0.25*(s_1 +
% s_2 + s_3) + 500*(R1 + R2 + R3) + 750*(D1 + D2 + D3)

% Build the contraints
% meet the demand - DO NOT CHANGE
% 1500 + x_N1 + x_E1 - s_1 = 35000
% s_1 + x_N2 + x_E2 - s_2 = 20000
% s_2 + x_N3 + x_E3 - s_3 = 40000

% do not exceed normal production capacity - CHANGE
% x_N1 <= 250*(100 + R1 - D1)
% x_N2 <= 250*(100 + R1 - D1 + R2 - D2)
% x_N3 <= 250*(100 + R1 - D1 + R2 - D2 + R3 - D3)

% 25 units/worker * 100 workers = extra production capacity - CHANGE
% x_E1 <= 25*(100 + R1 - D1)
% x_E2 <= 25*(100 + R1 - D1 + R2 - D2)
% x_E3 <= 25*(100 + R1 - D1 + R2 - D2 + R3 - D3)

% units are intigers
% x_ij ∈ N, i ∈ {N,E}, j = 1,2,3
% s_j ∈ N, ju = 1,2,3

% [x_N1 x_N2 x_N3 x_E1 x_E2 x_E3 s_1 s_2 s_3 R1 R2 R3 D1 D2 D3] - this is the order! 

% 0.5 * 4 = 2
% 0.5 * 6.5 = 3.25
f = [2 2 2 3.25 3.25 3.25 0.25 0.25 0.25 500 500 500 750 750 750]; %default is minimization so with "+"
% Ax <= B
% Aeq X <= Beq

a1 = [1 0 0 1 0 0 -1 0 0 zeros(1,6)];
a2 = [0 1 0 0 1 0 1 -1 0 zeros(1,6)]; 
a3 = [0 0 1 0 0 1 0 1 -1 zeros(1,6)];

Aeq = [a1; a2; a3];
Beq = [35000-1500 20000 40000];

a4 = [1 0 0 0 0 0 0 0 0 -250*[1 0 0 -1 0 0]]; 
a5 = [0 1 0 0 0 0 0 0 0 -250*[1 1 0 -1 -1 0]];
a6 = [0 0 1 0 0 0 0 0 0 -250*[1 1 1 -1 -1 -1]];
a7 = [0 0 0 1 0 0 0 0 0 -25*[1 0 0 -1 0 0]];
a8 = [0 0 0 0 1 0 0 0 0 -25*[1 1 0 -1 -1 0]];
a9 = [0 0 0 0 0 1 0 0 0 -25*[1 1 1 -1 -1 -1]];

A = [a4; a5; a6; a7; a8; a9];
B = [25000 25000 25000 2500 2500 2500];

LB = zeros(1,15);
UB = inf*ones(1,15);

[X2, obj2, flag2] = intlinprog(f, (1:15), A, B, Aeq, Beq, LB, UB);


%% Gurobi task 1

namesa = {'XN1'; 'XN2'; 'XN3'; 'XE1'; 'XE2'; 'XE3'; 'S1'; 'S2'; 'S3'};
model_lab04a.obj = [2 2 2 3.25 3.25 3.25 0.25 0.25 0.25];

a1 = [1 0 0 1 0 0 -1 0 0];
a2 = [0 1 0 0 1 0 1 -1 0]; 
a3 = [0 0 1 0 0 1 0 1 -1];
model_lab04a.A = sparse([a1;a2;a3]);

model_lab04a.rhs = [35000-1500 20000 40000];
model_lab04a.sense = '==='; %equality in all of 3 constraints, eq. <==, <>=
% Alternative expression: model_lab04a.sense = repmat('=',1,3);

model_lab04a.vtype = 'I'; %Integers, it can be 'CIB' if there are different types
% Equivalent to model_lab04a.vtype = repmat('I',1,9);

% Definition of notation
% 'C' -> Continuous
% 'B' -> Binary
% 'I' -> Integers
% 'S' -> Semi-continuous
% 'N' -> Semi-integers

model_lab04a.modelsense = 'min'; %minimization or maximization

model_lab04a.ub = [25000 25000 25000 2500 2500 2500 inf inf inf]; 

model_lab04a.varnames = namesa;

% The following command saves the model in a lp format file
gurobi_write(model_lab04a, 'lab04a.lp');

params.outputflag = 0;

resulta = gurobi(model_lab04a, params);

%% Gurobi task 2

namesb = {'XN1'; 'XN2'; 'XN3'; 'XE1'; 'XE2'; 'XE3'; 'S1'; 'S2'; 'S3'; 'R1'; 'R2'; 'R3'; 'D1'; 'D2'; 'D3'};
model_lab04b.obj = [2 2 2 3.25 3.25 3.25 0.25 0.25 0.25 500 500 500 750 750 750];

a1 = [1 0 0 1 0 0 -1 0 0 zeros(1,6)];
a2 = [0 1 0 0 1 0 1 -1 0 zeros(1,6)]; 
a3 = [0 0 1 0 0 1 0 1 -1 zeros(1,6)];
a4 = [1 0 0 0 0 0 0 0 0 -250*[1 0 0 -1 0 0]]; 
a5 = [0 1 0 0 0 0 0 0 0 -250*[1 1 0 -1 -1 0]];
a6 = [0 0 1 0 0 0 0 0 0 -250*[1 1 1 -1 -1 -1]];
a7 = [0 0 0 1 0 0 0 0 0 -25*[1 0 0 -1 0 0]];
a8 = [0 0 0 0 1 0 0 0 0 -25*[1 1 0 -1 -1 0]];
a9 = [0 0 0 0 0 1 0 0 0 -25*[1 1 1 -1 -1 -1]];


model_lab04b.A = sparse([a1;a2;a3;a4;a5;a6;a7;a8;a9]);

model_lab04b.rhs = [35000-1500 20000 40000 25000 25000 25000 2500 2500 2500];
model_lab04b.sense = '===<<<<<<'; %equality in all of 3 constraints, eq. <==, <>=
% Alternative expression: model_lab04a.sense = repmat('=',1,3);

model_lab04b.vtype = 'I'; %Integers, it can be 'CIB' if there are different types
% Equivalent to model_lab04a.vtype = repmat('I',1,9);

% Definition of notation
% 'C' -> Continuous
% 'B' -> Binary
% 'I' -> Integers
% 'S' -> Semi-continuous
% 'N' -> Semi-integers

model_lab04b.modelsense = 'min'; %minimization or maximization

model_lab04b.lb = zeros(1,15);
model_lab04b.ub = inf*ones(1,15); 

model_lab04b.varnames = namesb;

% The following command saves the model in a lp format file
gurobi_write(model_lab04b, 'lab04b.lp');

params.outputflag = 0;

resultb = gurobi(model_lab04b, params);
