function T_gg = gravitygradient(R,theta)

% input R is the orbit

R = R + 3396.2; %addition of the mars radius from MEX
mu = 4.28e13; %planetary constant of mars (MEX)
I_max = ;
I_min = ;

T_gg =  3*mu/2/R^3*(I_max-I_min)*sin(2*theta)
end