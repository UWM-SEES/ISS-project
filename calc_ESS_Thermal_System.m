% This function calculated the mass of the thermal system of the ESS.

function[obj] = calc_ESS_Thermal_System(Battery_Mass,ESS_EFFICIENCY_CHARGE, ESS_charge_max)
    M_b = Battery_Mass;
    
    a_ls = 0.3;% Lunar suface albedao -- Table II
    
    %Constants
    Is = 1359; %Irradiance W/m^2;
    T_ls = 385; % k Suface temperature max
    sigma = 5.670374419e-8; % Stefan-Boltzman Constant W*m^2/K^4
    n_l = 25; % Number of insolation layers
    
    % TABLE 16 Radiator Sizing Variables
    eta_r = 0.84; %Emissivity
    T_r = 300; % Temperature in Kelvin
    alpha_rls =0.3; %Lunar surface absorptivity
    f_ls = 0.5; %View factor to lunar surface
    alpha_rs = 0.14; %Solar absorptivity;
    theta_rs = 75; %Maximum Suna angle to radiator [degrees]
    F_al = 1.3; %Louver area adjustment factor

    % TABLE 17 - Radiator Mass Scaling Coefficients [kg/m^2)
    C_p = 3.30; % Panels
    C_c = 0.42; % Coating
    C_t = 1.31; % Tubing
    C_h = 0.23; % Header
    C_a = 0.29; % Adhesives
    C_s = 1.50; % Stingers
    C_at = 0.75; % Attachments
    C_lv = 4.5; % Louvers

    % TABLE 18 - Multilayer Insulation Mass Scaling Coefficients [kg/m^2]
    C_sp = 0.0063; % Spacer
    C_rl = 0.0550; % Reflective Layer
    C_oc = 0.1100; % Outer Cover
    C_ic = 0.0500; % Inner cover
    C_as = 0.1000; % Attachment and seals

    % TABLE 19 - Cold Plate Component Mass Scaling Coefficients
    C_cf = 0.25; % Cold plate coverage coefficient.
    t_c = 0.005; % Cold plate thickness [m].
    w_c = 0.1; % Cold plate width [m].
    L_c = 0.1; % Cold plate length [m].
    rho_c = 2700; % Cold plate density [kg/m^3].
    C_hp = 0.15; % Heat pipe mass coefficient [kg/m].

    %Thermal power that needs to be rejected. Eq (78).
    P_r = (1-ESS_EFFICIENCY_CHARGE)*ESS_charge_max;

    %Radiator Area. Eq (77)
    A_r = P_r*F_al/(sigma*(eta_r*T_r^4 - alpha_rls*f_ls*T_ls^4)-alpha_rs*Is*(cosd(theta_rs)+f_ls*a_ls));

    %Radiator Mass. Eq (79)
    M_r = (C_p + C_c + C_t + C_h + C_a + C_s + C_at + C_lv)*A_r;

    %Specific volumne of selected Lithium-ion Batteries. Ref 24:
    %Herron, David: Gasoline, Electricity, and the Energy to Move Transportation Systems, Green
    %Transportation. 2019. https://greentransportation.info/energy-transportation/introduction.html
    %Accessed Feb. 1, 2019.
    S_vb = 5.5e-4; %m^3/kg; 

    %Surface area of the battery enclosure. Eq (80). in meters^2.
    A_be = 6*(M_b*S_vb)^(2/3);

    %Multi-layer insolation mass [kg]. Eq (81).
    M_mli = (((C_sp + C_rl)*n_l + C_oc + C_ic)*A_be)*(1 + C_as);

    %Cold plate mass [kg]. Eq (82).
    M_cp = A_be*C_cf*t_c*rho_c;

    %Heat pipes mass [kg]. Eq (83).
    M_hp = (C_cf*C_hp*A_be^1.5)/(1.225*w_c*L_c);

    %Total thermal control sstem mass [kg]. Eq (84)
    M_tc = M_r+M_mli+M_cp+M_hp;

    obj.Mass_Radiator = M_r;
    obj.Mass_multilayer_insolation = M_mli;
    obj.Mass_cold_plate = M_cp;
    obj.Mass_heat_pipe = M_hp;
    obj.Mass_total_thermal_system = M_tc;