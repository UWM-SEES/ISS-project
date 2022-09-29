function [obj] = calc_PV_array_mass(P_a_peak, A_a)

% Mass Calculation of PV array
rho_a = 1.59; %[kg/m^2] areal density of UltraFlex multijunction array. Page 45;
M_apv = A_a*rho_a; % [kg]. Eq (66). 
rho_as = 0.55; %[kg/m^2] specific mass of PV array supporting structure. Made out of Carbon Fiber.
M_as = A_a*rho_as; %[kg]. Mass of array structure. Eq (67).

S_a = 3; %[m]. Spacing between PV panels
%n_w = (sqrt(A_a)/S_a)^2
n_w = ceil((sqrt(A_a)/S_a)^2); % Number of wires runs between the arrays and junction box. Eq (68).
L_w = sqrt(A_a)/2; % [m]. Eq (69). Average length of each of the wire runs. 

%P_a_peak = 70.9e3;
%P_a_peak = max(P_a); %Peak PV array output power)
V_a = 120; %[V]. Not sure if correct
I_w = P_a_peak/(V_a*n_w); %[A]. Current per wire. Eq (71).

%Wire Gauge. Eq (72).
%G_w = -5.911*log(I_w) + 27.963
%G_w = ceil(-5.911*log(I_w) + 27.963)
G_w = floor(-5.911*log(I_w) + 27.963);

%Wire Specific Mass. Kg/m. Figure 33. Page 46. Eq(70).
M_sw = -(4.671e-5)*G_w^3 + (2.842e-3)*G_w^2 - 0.0592*G_w + 0.4302;

%Power transmission wire mass. [m]. Eq (73).
M_w = M_sw*n_w*L_w;

%Mass of Breaker switch box. [m]. Eq (74).
M_bb = 9.6736*log(n_w)-13.86;

obj.Mass_PV_panels = M_apv;
obj.Mass_PV_Structure = M_as;
