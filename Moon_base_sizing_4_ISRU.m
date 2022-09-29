%Mark Vygoder, Jake Gudex, Rob Cuzner
%The Roofless Lab
%Dept. of Electrical Engineering
%University of Wisconsin - Milwaukee
%Oct. 20th, 2021

% Scaling Laws derived from this paper:
%Colozza, Anthony J. "Small lunar base camp and in situ resource utilization oxygen production facility power system comparison." (2020).


%% NOTES
%The paper sizes the power system and important equipment such as the lunar
%habitat and life support, oxygen production, communication, and compares
%power source PV vs Nuclear, and energy storage systems (ESS) of
%lithon-Ion and RFC (Regenerative Fuel Cell). 
%Things are spec'ed out for a crew of 6.
%Assume for location is at 30 degrees N. The Artemis program is looking at
%the south pole, so the assumptions in the paper need to be double checked
%or modified for conditions at the Lunar south pole. 

%In the paper, 1.65 kg/h of O2 is repeatidly used. I guess this is needed for a crew of 6.
% O2 production needs both thermal power and electrical. thermal can be
% provided by electrical. To compensate for the lower temperatures at the 
% Lunar south pole, thermal power needs to be increased by 32%, or 16.5% of
% all power is electric (electric heater is used).

% Power loss for Environmental Controls and Life Support System (ECLSS) is
% 21.05 kW. The losses from equipment is great than heat loss of habitat at
% 30 degree N location. This needs to be double check with colder location
% at south pole, since heat loss is to the 4th power. 
%% Oxygen production rate vs power consumption
%Total Electrical 

Total_Elec_x = [0.097
0.48
0.978
1.495
1.975
2.478];

Total_Elec_y = [0.844
2.906
5.906
8.625
11.25
14.25]*1e3;

Total_thermal_x = [0.457
0.978
1.458
1.994
2.478];

Total_thermal_y = [5.062
10.125
15
20.156
24.844]*1e3;

Oxygen_production_power_Electrical = fit(Total_Elec_x, Total_Elec_y, 'poly1')
Oxygen_production_power_Thermal = fit(Total_thermal_x, Total_thermal_y, 'poly1')

Oxy_mass_x = [0.093
0.458
0.955
1.422
1.919
1.997
2.279
2.489];

Oxy_mass_y = [310.154
492.923
758.769
1013.538
1284.923
1323.692
1473.231
1584];

Oxygen_production_mass  = fit(Oxy_mass_x, Oxy_mass_y, 'poly1');

O2_rate = 1.65; %kg/hour
%curve fit needs some improvement.
Oxygen_production_power_Electrical(O2_rate) 
Oxygen_production_power_Thermal(O2_rate)
Oxygen_production_mass(O2_rate)

% Page 17: "Operating at a time with higher surface temperatures will reduce the amount of heat
% needed to bring the ilmenite up to the desired temperature, whereas operating near the poles will require
% additional heat due to the cold surface temperatures even while sunlit. For example, operating near the
% poles where the surface temperature is 100 K will increase the power required to heat the ilmenite by
% 32 percent (from 13.4 to 17.7 kW) or a 16.5-percent increase in the total power required by the ISRU
% system. This approximately represents the maximum effect that site selection and time of operation can
% have on the system power requirement."
south_pole_factor = 1.165 

Oxygen_production_total_power = (Oxygen_production_power_Electrical(O2_rate) +...
Oxygen_production_power_Thermal(O2_rate))*south_pole_factor


%% Habitat
Habitat_power = 21.05e3;

%% Heat losses of Habitat
%Constants
epsilon_hw = 0.07; %Habitat wall emissivity
epsilon_i = 0.07; %Insulation emissivity
n_l = 25; % Number of insolation layers
d_h = 8.0; % Habitat diameter
A_pt = 1.00; % Percent Area Passthrough

sigma = 5.670374419e-8; % Stefan-Boltzman Constant W?m?2?K?4

T_hi = 295; %Internal habitat temperature
T_sn = 84;%50; %k night time temperature
T_ls = 385; % k Suface temperature max

A_h = pi*d_h^2/2; %Habitat Area;

%Heat lost through habitat material.
Q_hi = A_h*sigma*(T_hi^4 - T_sn^4)/(1/epsilon_hw + 2*n_l/epsilon_i -(n_l-1)) 

%Mean temperature insolation
T_m =((T_hi^2 + T_sn^2)*(T_hi + T_sn)/4)^(1/3)

% Passthrough contant 1
f_p = 0.73+0.27*A_pt;

% Passthrough contant 2
n_i = 9;
f_n = 4.547-0.501*n_i;

%Heat lost to insolation and seams
Q_ps = 0.664*(0.000136/(4*sigma*T_m^2)+0.000121*T_m^2)*f_p*f_n*A_h*sigma*(T_hi^4 - T_sn^4)

%% Airlock Structure
n_cp = 2; %Number of conductive Paths
k = 19; %W/(m*k) Thermal conductivity of material
d_icp = 1.48; %Inner diameter [m]
t_cp= 0.1; %Thickness [m].
L_cp = 0.25; %Length [m]
A_cp = pi*((d_icp/2+t_cp)^2-(d_icp/2)^2);

Q_as = n_cp*k*A_cp*(T_hi-T_sn)/L_cp

%% Support Legs
n_cp = 10;
k = 6.7;
d_icp = 0.46;
t_cp= 0.02;
L_cp = 1;
A_cp = pi*((d_icp/2+t_cp)^2-(d_icp/2)^2);

Q_sl = n_cp*k*A_cp*(T_hi-T_sn)/L_cp

%% Radiator coolant lines
n_cp = 16;
k = 19;
d_icp = 0.02;
t_cp= 0.001;
L_cp = 0.1;
A_cp = pi*((d_icp/2+t_cp)^2-(d_icp/2)^2);

Q_ra = n_cp*k*A_cp*(T_hi-T_sn)/L_cp

Q_h = Q_ra + Q_sl + Q_as + Q_ps

%% PV Sizing
Is = 1359; %Irradiance W/m^2;
n_sc = 0.28; % efficiency of solar cell
n_b_dis = 0.95; % Battery Discharge efficiency
n_b_char = 0.95; % Battery Charge efficiency
n_fl = 0.65; %Fuel Cell efficiency
n_e = 0.85; %Electrolyzer efficiency
f_sc = 0.89; %Array Solar cell fill factor

%% Irradiance Profile
t_d = 708.33; %Hours in Lunar day

delta_t = 0.1; % Hour

t_i = 0:delta_t:t_d; % instantanious lunar day.

beta = -89%30; % degree facing south

angle = 2*pi*t_i./t_d - pi;
cos_angle = cos(abs(angle));
y = tand(beta).*cos_angle;
theta = atan(y);

figure(1), clf;
row = 4; col = 1;

subplot(row, col, 1)
stairs(t_i,angle)
grid on;
xlabel('Lunar Hour')
ylabel('2\pi t_i/t_d - \pi')

subplot(row, col, 2)
stairs(t_i, cos_angle);
grid on;
xlabel('Lunar Hour')
ylabel('cos(2\pi t_i/t_d - \pi)')

subplot(row, col, 3)
stairs(t_i, y)
grid on;
xlabel('Lunar Hour')
ylabel('tan(\beta)cos(2\pi t_i/t_d - \pi)')

subplot(row, col, 4)
stairs(t_i,theta)
grid on;
xlabel('Lunar Hour')
ylabel('tan^{-1}(tan(\beta)cos(2\pi t_i/t_d - \pi))')

%% Lattitude impact on irradiance
phi = -89;% degrees latitude;
Psi = 0.75; %degrees
figure(2), clf;

sun_ratio = 2*pi*t_i./t_d;
cos_sun_ratio = cos(sun_ratio);
angle_2 = sind(phi)*sind(Psi) - cosd(phi)*cosd(Psi).*cos_sun_ratio;

yy = acos(angle_2);
row = 5; col = 1;
alpha = pi/2 - yy;

subplot(row, col, 1)
stairs(t_i,sun_ratio)
grid on;
xlabel('Lunar Hour')
ylabel('2\pi t_i/t_d')

subplot(row, col, 2)
stairs(t_i, cos_sun_ratio);
grid on;
xlabel('Lunar Hour')
ylabel('cos(2\pi t_i/t_d)')

subplot(row, col, 3)
stairs(t_i, angle_2)
grid on;
xlabel('Lunar Hour')
ylabel('angle_2')

subplot(row, col, 4)
stairs(t_i,yy)
grid on;
xlabel('Lunar Hour')
ylabel('acos(angle_2)')

subplot(row, col, 5)
stairs(t_i,alpha)
grid on;
xlabel('Lunar Hour')
ylabel('alpha')

%% PV Output per Irrandiance profile
X_d = 0 % percent dust coverage
PV_Array_constants = (1-X_d)*f_sc*n_sc*Is;

A_a = 120; % Area of Solar Array (m)

P_a = PV_Array_constants.*A_a.*sin(alpha + theta);

%Make same length vector, but with only positive values. There is probably
%a fast way to do this. 
P_a_pos = zeros(1, length(P_a));
k =1
for i = 1:1:length(P_a)
    if P_a(i) > 0
        P_a_pos(i) = P_a(i);
        temp(k) = P_a(i);
        k = k+1;
     %   i
     %   P_a(i)
     %   P_a_pos(i)
    else
        P_a_pos(i) = 0;
    end  
end

figure(3), clf;
stairs(t_i, P_a)
xlabel('Lunar Hour')
hold on;grid on;
stairs(t_i, P_a_pos)

%% Sanity Check
PV_farm_power_avg = sum(temp)/length(temp);
PV_farm_time_on = 532.6-176.5;
PV_farm_Energy = PV_farm_power_avg*PV_farm_time_on;
PV_farm_Energy_kWh = PV_farm_Energy/1000
%% Calculate Energy from PV farm
Energy_PV_farm = zeros(1, length(P_a_pos));

Energy_PV_farm(1) = P_a_pos(1)*delta_t;
for j = 2:1:length(P_a_pos)
    Energy_PV_farm(j) = P_a_pos(j)*delta_t + Energy_PV_farm(j-1);
end

figure(4), clf;
stairs(t_i, Energy_PV_farm);
xlabel('Lunar Hour');
grid on;
ylabel('Energy [Wh]')

%% Oxygen Production Energy
E_ox = Oxygen_production_total_power*t_d; %Wh


%% Sizing PV Array to meet energy demands

X_d = 0; % percent dust coverage
PV_Array_constants = (1-X_d)*f_sc*n_sc*Is;
A_a = 1;
P_a = PV_Array_constants.*A_a.*sin(alpha + theta);
E_ox = Oxygen_production_total_power*t_d;
%E_ox = 25.8e3*t_d;
P_a_pos = zeros(1, length(P_a));
%k =1
Energy_PV_farm = zeros(1, length(P_a));

Final_PV_Farm_energy = Energy_PV_farm(1, end);

Ox_production_power_plot = zeros(1, length(P_a));
%Ox_production_power_plot(1,:) = 25.8e3;
Ox_production_power_plot(1,:) = Oxygen_production_total_power
%keep running loop while PV farm energy <= Energy needed for O_2 production
while Final_PV_Farm_energy <= E_ox
    
    %Max PV power based on Area, tilt angle.
    P_a = PV_Array_constants.*A_a.*sin(alpha + theta);
    
    %create variable of same length
    P_a_pos = zeros(1, length(P_a));

    % Set negative values to zero (PV array output cannot be negative)
    for i = 1:1:length(P_a)
        if P_a(i) > 0
            P_a_pos(i) = P_a(i);
           % temp(k) = P_a(i);
           % k = k+1;
         %   i
         %   P_a(i)
         %   P_a_pos(i)
        else
            P_a_pos(i) = 0;
        end  
    end

  
    
    %create variable of same length
    Energy_PV_farm = zeros(1, length(P_a_pos));
    
    %Calculate Energy from PV farm
    Energy_PV_farm(1) = P_a_pos(1)*delta_t;
    
    %integrate through array to calculate total energy over time.
    for j = 2:1:length(P_a_pos)
        Energy_PV_farm(j) = P_a_pos(j)*delta_t + Energy_PV_farm(j-1);
    end
    
    %add to array size
    A_a = A_a +0.5;
    
    %select last value
    Final_PV_Farm_energy = Energy_PV_farm(1, end);
    
%         figure(5), clf;
%     row = 2; col = 1;
% 
%     subplot(row, col, 1)
%     stairs(t_i, P_a_pos)
%     grid on; hold on;
% 
%     subplot(row, col, 2)
%     stairs(t_i, Energy_PV_farm)
%     grid on; hold on;
%     stairs(t_i, E_ox)
    
end

%remove PV array size increase in last line of previous loop.
A_a = A_a -0.5;

figure(5), clf;
row = 2; col = 1;

subplot(row, col, 1)
stairs(t_i, P_a_pos./1000)
grid on; hold on;
xlabel('Time (Hours)')
ylabel('Power (kW)')
xlim([0 t_d])
stairs(t_i, Ox_production_power_plot/1000)
legend('PV Power', 'Oxygen Production Power')

subplot(row, col, 2)
stairs(t_i, Energy_PV_farm./1e3)
grid on; hold on;
xlabel('Time (Hours)')
ylabel('Energy kWh')
xlim([0 t_d])
%stairs(t_i, E_ox)

P_a_peak = max(P_a)


%% Size ESS system.
%subtract load size from PV profile. 

ESS_EFFICIENCY_ROUND_TRIP = 0.99^2;
ESS_EFFICIENCY_CHARGE = sqrt(ESS_EFFICIENCY_ROUND_TRIP);
ESS_EFFICIENCY_DISCHARGE = sqrt(ESS_EFFICIENCY_ROUND_TRIP);
ESS_MIN_SOC = 0.2;
ESS_DEPTH_OF_DISCHARGE = 1-ESS_MIN_SOC;
ESS_final_energy =-1;

%keep running loop while PV farm energy <= Energy needed for O_2 production
while ESS_final_energy < 0
    
    %Max PV power based on Area, tilt angle.
    P_a = PV_Array_constants.*A_a.*sin(alpha + theta);
    
    %create variable of same length
    P_a_pos = zeros(1, length(P_a));

    % Set negative values to zero (PV array output cannot be negative)
    for i = 1:1:length(P_a)
        if P_a(i) > 0
            P_a_pos(i) = P_a(i);
           % temp(k) = P_a(i);
           % k = k+1;
         %   i
         %   P_a(i)
         %   P_a_pos(i)
        else
            P_a_pos(i) = 0;
        end  
    end

  
    
    %create variable of same length
    Energy_PV_farm = zeros(1, length(P_a_pos));
    
    %Calculate Energy from PV farm
    Energy_PV_farm(1) = P_a_pos(1)*delta_t;
    
    %integrate through array to calculate total energy over time.
    for j = 2:1:length(P_a_pos)
        Energy_PV_farm(j) = P_a_pos(j)*delta_t + Energy_PV_farm(j-1);
    end
    
    %add to array size
    A_a = A_a +0.5;
    
    %select last value
    Final_PV_Farm_energy = Energy_PV_farm(1, end);



    ESS_energy_time = zeros(1, length(P_a_pos));
    delta_power = zeros(1, length(P_a_pos));

    Load_profile = Ox_production_power_plot;


     if(Load_profile(i) > P_a_pos(i))
           delta_power(i) = Load_profile(i) - P_a_pos(i);
           ESS_energy_time(i) = delta_power(i)*delta_t;
     end
    for i =2:1:length(P_a)
        %ESS will discharge
        if(Load_profile(i) > P_a_pos(i))

            %Amount of power needed to satify the load
           delta_power(i) = Load_profile(i) - P_a_pos(i);

           %new energy value
           ESS_energy_time(i) = ESS_energy_time(i-1) -delta_power(i)*delta_t/ESS_EFFICIENCY_DISCHARGE;
        else
        %ESS will charge

            delta_power(i) = P_a_pos(i) - Load_profile(i);
            ESS_energy_time(i) = ESS_energy_time(i-1) + delta_power(i)*delta_t*ESS_EFFICIENCY_CHARGE;
        end  
    end
    stairs(t_i,ESS_energy_time/1000)

    ESS_final_energy = ESS_energy_time(1, end);
end

ESS_energy_time_zeroed = ESS_energy_time - min(ESS_energy_time);
 stairs(t_i,ESS_energy_time_zeroed/1000)
 
ESS_Size = max(ESS_energy_time_zeroed);
ESS_Size_adjusted_for_min_SOC = ESS_Size/ESS_DEPTH_OF_DISCHARGE;

ESS_min_SoC_energy = ESS_Size_adjusted_for_min_SOC*(1-ESS_DEPTH_OF_DISCHARGE);

ESS_Size_adjusted_for_min_SOC_energy_time = ESS_energy_time_zeroed + ESS_min_SoC_energy;

M_b = ESS_Size_adjusted_for_min_SOC/200;

ESS_charge_max = max(delta_power);



%% Mass Calculation of PV array
ISRU.PV = calc_PV_array_mass(P_a_peak, A_a)

%% Mass calculation for BESS
ISRU.BESS = calc_ESS_Thermal_System(M_b, ESS_EFFICIENCY_CHARGE, ESS_charge_max);
ISRU.BESS.Battery_mass = M_b;
%% Plots for Jan Review

fig1 = figure(6), clf;
row = 2; col = 1;

subplot(row, col, 1)
stairs(t_i, P_a_pos./1000,'linewidth', 1.25)
grid on; hold on;
xlabel('Time (Hours)')
ylabel('Power (kW)')
xlim([0 t_d])
stairs(t_i, Ox_production_power_plot/1000, 'linewidth', 1.25)
legend('PV', 'Oxygen Production')
title('PV power vs Load Profile')

fig1.CurrentAxes.FontName = 'Times New Roman';
fig1.CurrentAxes.FontSize = 12;
fig1.CurrentAxes.FontWeight = 'Bold';
fig1.CurrentAxes.GridAlpha = 0.5;
fig1.CurrentAxes.LineWidth = 1;

subplot(row, col, 2)
stairs(t_i, ESS_Size_adjusted_for_min_SOC_energy_time./1e6,'linewidth', 1.25)
grid on; hold on;
xlabel('Time (Hours)')
ylabel('Energy MWh')
xlim([0 t_d])
title('State of Charge of ESS')

fig1.CurrentAxes.FontName = 'Times New Roman';
fig1.CurrentAxes.FontSize = 12;
fig1.CurrentAxes.FontWeight = 'Bold';
fig1.CurrentAxes.GridAlpha = 0.5;
fig1.CurrentAxes.LineWidth = 1;

%% Display
fprintf("Mass of ISRU nanogrid: \n")
fprintf("\t Total Mass of PV system: %4.3f kg \n", ISRU.PV.Mass_PV_panels + ISRU.PV.Mass_PV_Structure)
fprintf("\t\t Mass of PV panels: %4.3f kg \n", ISRU.PV.Mass_PV_panels)
fprintf("\t\t Mass of PV supporting structure :  %4.3f kg \n", ISRU.PV.Mass_PV_Structure)
fprintf("\t Total Mass of BESS system: %4.3f kg \n", ISRU.BESS.Battery_mass + ISRU.BESS.Mass_total_thermal_system)
fprintf("\t\t Mass of Lithium Ion Batteries: %4.3f kg \n", ISRU.BESS.Battery_mass)
fprintf("\t\t Total Mass of BESS Thermal System: %4.3f kg \n", ISRU.BESS.Mass_total_thermal_system)
fprintf("\t\t\t Radiator Mass: %4.3f kg \n", ISRU.BESS.Mass_Radiator)
fprintf("\t\t\t Insolation Mass: %4.3f kg \n", ISRU.BESS.Mass_multilayer_insolation)
fprintf("\t\t\t Cold Plate Mass: %4.3f kg \n", ISRU.BESS.Mass_cold_plate)
fprintf("\t\t\t Heat Pipe Mass: %4.3f kg \n", ISRU.BESS.Mass_heat_pipe)



