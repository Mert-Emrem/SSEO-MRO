c = 299792458;

freq = 8439.55*10^6; % hz

lambda = c/freq; % m

d = 374.49e9; %distance, m

L_FS = -20*log10(((4*pi*d)/lambda)); % free space loss

d_tx = 3; % m
d_rx = 34; % m

eta_tx = 0.65; % aperture efficiency

P_tx = 20; % transmitter power, dB

G_tx = 10 * log10((pi^2 * d_tx^2 * eta_tx) / lambda^2); % transmitter gain

L_c = -1; % cable loss

EIRP = P_tx + G_tx + L_c

A_eff_real = 10^(46.7/10) * lambda^2 / (4*pi)

e_ap_real = 4*A_eff_real/(pi*d_tx^2)

theta_tx = 70*lambda/3;

theta_rx = 70*lambda/34;

e = 0.1292;

L_point = -12*((0.1192+0.006)/theta_tx)^2

L_point = -12 * (e / theta_rx)^2;

L_atm = 0.058/sin(deg2rad(10))

G_rx = 10 * log10((pi^2 * d_rx^2 * eta_tx) / lambda^2); % transmitter gain

G_rx = 68.41; % receiving gain dB

P_rx = EIRP + L_FS + L_atm + G_rx + L_point

%ebn0 = P_tx + L_c + G_tx + L_FS + L_atm + G_rx - 10*log10(R) - N0;

B = 10*log10(6000) - 10*log10(9000); % bandwidth

k = 1.32e-23

%P_noise = k * T_e * B