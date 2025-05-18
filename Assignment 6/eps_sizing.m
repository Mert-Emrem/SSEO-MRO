clc;
clear;
close;

%% SA DATA

P_e = 1009.764; % Power request in eclipse [W]
T_e = 2224.632642; % Eclipse duration [s]
T_orbit = 6715.479273;
X_e = 0.6; % Line efficiency in eclipse [-], depends on power control strategy
P_l = 1072.428; % Power request in sunlight [W]
T_l = T_orbit - T_e; % Sunlight duration [min]
X_l = 0.8; % Line efficiency in sunlight [-], depends on power control strategy
P0_mars = 586.2; % Sun irradiance at Mars [W/m^2] 
eps = 0.266; % Solar cells efficiency %0.266 [-]
I_d = 0.8; % Degradation factor [-]
theta = deg2rad(2); % Sun aspect angle [rad]
dpy = 0.03; % Yearly degradation factor 1/[year]
lifetime_days = 1967; % from launch to 31.12.2010
lifetime = 1967/365.25; % years
A_cell = 27.5 / 1e4; % Single cell surface [m^2]
V_cell = 2.3; % Single cell voltage [V]
V_sys = 28; % Bus voltage [V]

%% SA SIZING

% Power produced with SA:
P_sa = (P_e * T_e / X_e  + P_l * T_l / X_l) / T_l; % [W]

% Specific power of solar cells at BOL:
P_bol_specific = P0_mars * eps * I_d * cos(theta); % [W/m^2]

% Specific power of solar cells at EOL:
P_eol_specific = P_bol_specific * (1 - dpy) ^ lifetime; % [W/m^2]

% Solar arrays surface:
A_sa = P_sa / P_eol_specific; % [m^2]

% Number of cells:
N_cells = ceil(A_sa / A_cell); % [-]

%% SA REFINED SIZING

N_series = ceil(V_sys / V_cell); % [-]

N_parallels = ceil(N_cells / N_series) + 1; % [-]

N_cells_refined = N_parallels * N_series; % [-]

A_sa_refined = N_cells_refined * A_cell; % [m^2]

P_eol = A_sa_refined * P0_mars * eps * I_d * (1 - dpy) ^ lifetime * cos(theta); % [W]

N_cells_real = 3744*2;

N_cells_diff = N_cells_real - N_cells_refined

N_cells_diffratio = N_cells_refined/(N_cells_real) *100

%% REVERSE 

N_series_real = 18;
N_parallel_real = 3744*2/18;

mass_cell_total = N_cells_refined * 85*10^-6 % [kg]

A_single_array = A_sa_refined/2; % [m^2]

A_inboard = A_sa_refined/2; % [m^2]

A_outboard = A_sa_refined/2; % [m^2]

rho_inboard = 2.83132; % [kg/m^2]

rho_outboard = 1.71248; % [kg/m^2]

M_inboard = rho_inboard * A_inboard + mass_cell_total/4;

M_outboard = rho_outboard * A_outboard + mass_cell_total/4;

M_single_array = M_inboard + M_outboard;

M_both = M_single_array*2;

Th_inboard = (30.126 + 0.15)/1000;

Th_outboard = (23.226 + 0.15)/1000;

V_inboard = A_inboard*Th_inboard;

V_outboard = A_outboard*Th_outboard;

V_single_array = V_inboard + V_outboard

V_both = V_single_array*2