%% plots_3D: Creates 3D plots
% creates plots of chopper, inverter transformer, rectifier, input and
% output filter, and remote bus isolators

%% default values
F1 = 20;
F2 = 40;
Vin = 120;
Vout = 5000; %not used
Available_Modules = 1;
Required_Modules = 1;
number_of_sample_points = 20;

%% chopper stage
figure(1)

% equal steps
chopper_efficiency_high = 0.984;
chopper_efficiency_low = 0.968;
chopper_efficiency_range = chopper_efficiency_high - chopper_efficiency_low;
chopper_efficiency_step = chopper_efficiency_range/number_of_sample_points;
Chopper_efficiency_array = [chopper_efficiency_low: chopper_efficiency_step: chopper_efficiency_high];
Chopper_power_array = [5:10:250];
[chopper_efficiency_mesh, chopper_power_mesh] = meshgrid(Chopper_efficiency_array, Chopper_power_array);

F1 = 20;
F2 = 40;
Vin = 120;
Vout = 0; %not used
Pout = chopper_power_mesh;
Available_Modules = 1;
Required_Modules = 1;

CS_efficiency = chopper_efficiency_mesh;


CS_mass_mesh_1 = Calculate_Chopper_Stage_Mass(F1, Vin, Vout, Pout, Available_Modules, Required_Modules, CS_efficiency);
CS_mass_mesh_2 = Calculate_Chopper_Stage_Mass(F2, Vin, Vout, Pout, Available_Modules, Required_Modules, CS_efficiency);

specific_power_mesh_1 = Pout./CS_mass_mesh_1;
specific_power_mesh_2 = Pout./CS_mass_mesh_2;

surf(chopper_power_mesh, chopper_efficiency_mesh, specific_power_mesh_1)
xlabel('Power [kW]')
ylabel('Efficiency')
zlabel('Specific Power [kW/kg]')
title('Chopper Stage')
hold on
surf(chopper_power_mesh, chopper_efficiency_mesh, specific_power_mesh_2)
legend('20 kHz', '40 kHz') %legend still tbd. 


%% inverter transformer stage
figure(2)

inverter_transformer_efficiency_high = 0.996;
inverter_transformer_efficiency_low = 0.986;
inverter_transformer_efficiency_range = inverter_transformer_efficiency_high - inverter_transformer_efficiency_low;
inverter_transformer_efficiency_step = inverter_transformer_efficiency_range/number_of_sample_points;
Inverter_transformer_efficiency_array = [inverter_transformer_efficiency_low: inverter_transformer_efficiency_step: inverter_transformer_efficiency_high];
Inverter_transformer_power_array = [5:10:250];
[inverter_transformer_efficiency_mesh, inverter_transformer_power_mesh] = meshgrid(Inverter_transformer_efficiency_array, Inverter_transformer_power_array);

F1 = 20;
F2 = 40;
Vin = 120;
Vout = 4500; %not used
Pout = inverter_transformer_power_mesh;
Available_Modules = 1;
Required_Modules = 1;

ITS_efficiency = inverter_transformer_efficiency_mesh;

ITS_mass_mesh_1 = Calculate_Inverter_Transformer_Stage_Mass(F1, Vin, Vout, Pout, Available_Modules, Required_Modules, ITS_efficiency);
ITS_mass_mesh_2 = Calculate_Inverter_Transformer_Stage_Mass(F2, Vin, Vout, Pout, Available_Modules, Required_Modules, ITS_efficiency);

ITS_specific_power_mesh_1 = Pout./ITS_mass_mesh_1;
ITS_specific_power_mesh_2 = Pout./ITS_mass_mesh_2;

surf(inverter_transformer_power_mesh, inverter_transformer_efficiency_mesh, ITS_specific_power_mesh_1)
xlabel('Power [kW]')
ylabel('Efficiency')
zlabel('Specific Power [kW/kg]')
title('Inverter Transformer Stage')
hold on
surf(inverter_transformer_power_mesh, inverter_transformer_efficiency_mesh, ITS_specific_power_mesh_2)
legend('20 kHz', '40 kHz')

%% rectifier stage

figure(3)

rectifier_efficiency_high = 0.991;
rectifier_efficiency_low = 0.983;
rectifier_efficiency_range = rectifier_efficiency_high - rectifier_efficiency_low;
rectifier_efficiency_step = rectifier_efficiency_range/number_of_sample_points;
Rectifier_efficiency_array = [rectifier_efficiency_low: rectifier_efficiency_step: rectifier_efficiency_high];

Rectifier_power_array = [5:10:250];
[rectifier_efficiency_mesh, rectifier_power_mesh] = meshgrid(Rectifier_efficiency_array, Rectifier_power_array);

F1 = 40;
% F2 = 40;
Vin = 120;
Vout = 0; %not used
Pout = rectifier_power_mesh;
Available_Modules = 1;
Required_Modules = 1;

RS_efficiency = rectifier_efficiency_mesh;

RS_mass_mesh_1 = Calculate_Rectifier_Stage_Mass(F1, Vin, Vout, Pout, Available_Modules, Required_Modules, RS_efficiency);
% RS_mass_mesh_2 = Calculate_Rectifier_Stage_Mass(F2, Vin, Vout, Pout, Available_Modules, Required_Modules, RS_efficiency);

RS_specific_power_mesh_1 = Pout./RS_mass_mesh_1;
% RS_specific_power_mesh_2 = Pout./RS_mass_mesh_2;

surf(rectifier_power_mesh, rectifier_efficiency_mesh, RS_specific_power_mesh_1)
xlabel('Power [kW]')
ylabel('Efficiency')
zlabel('Specific Power [kW/kg]')
title('Rectifier Stage')
hold on
% surf(rectifier_power_mesh, rectifier_efficiency_mesh, RS_specific_power_mesh_2)
legend('40 kHz')
% legend('20 kHz', '40 kHz') % this doesn't matter for rectifier

%% input filter stage

figure(4)

filter_efficiency_high = 0.997;
filter_efficiency_low = 0.999;
filter_efficiency_range = filter_efficiency_high - filter_efficiency_low;
filter_efficiency_step = filter_efficiency_range/number_of_sample_points;
Input_filter_efficiency_array = [filter_efficiency_low: filter_efficiency_step: filter_efficiency_high];

Input_filter_power_array = [5:10:250];
[input_filter_efficiency_mesh, input_filter_power_mesh] = meshgrid(Input_filter_efficiency_array, Input_filter_power_array);

F1 = 40;
%F2 = 20;
Vin = 120;
Pout = input_filter_power_mesh;
Available_Modules = 1;
Required_Modules = 1;
FS_ripple = 0.004;

IFS_efficiency = input_filter_efficiency_mesh;

IFS_mass_mesh_1 = Calculate_Filter_Stage_Mass(F1, Vin, Pout, Available_Modules, Required_Modules, IFS_efficiency, FS_ripple);
%IFS_mass_mesh_2 = Calculate_Filter_Stage_Mass(F2, Vin, Pout, Available_Modules, Required_Modules, IFS_efficiency, FS_ripple);

IFS_specific_power_mesh_1 = Pout./IFS_mass_mesh_1;
%IFS_specific_power_mesh_2 = Pout./IFS_mass_mesh_2;

surf(input_filter_power_mesh, input_filter_efficiency_mesh, IFS_specific_power_mesh_1)
xlabel('Power [kW]')
ylabel('Efficiency')
zlabel('Specific Power [kW/kg]')
title('Input Filter Stage')
hold on
%surf(input_filter_power_mesh, input_filter_efficiency_mesh, IFS_specific_power_mesh_2)
%legend('20 kHz', '40 kHz') 
legend('40 kHz')

%% output filter stage

figure(5)
filter_efficiency_high = 0.997;
filter_efficiency_low = 0.999;
filter_efficiency_range = filter_efficiency_high - filter_efficiency_low;
filter_efficiency_step = filter_efficiency_range/number_of_sample_points;
Output_filter_efficiency_array = [filter_efficiency_low: filter_efficiency_step: filter_efficiency_high];

Output_filter_power_array = [5:10:250];
[output_filter_efficiency_mesh, output_filter_power_mesh] = meshgrid(Output_filter_efficiency_array, Output_filter_power_array);

F1 = 40; %if using both F1 and F2, set F1 to 20 and F2 to 40
%F2 = 20;
Vout = 4500;
Pout = output_filter_power_mesh;
Available_Modules = 1;
Required_Modules = 1;
FS_ripple = 0.004;

OFS_efficiency = output_filter_efficiency_mesh;

OFS_mass_mesh_1 = Calculate_Filter_Stage_Mass(F1, Vout, Pout, Available_Modules, Required_Modules, OFS_efficiency, FS_ripple);
%OFS_mass_mesh_2 = Calculate_Filter_Stage_Mass(F2, Vout, Pout, Available_Modules, Required_Modules, OFS_efficiency, FS_ripple);

OFS_specific_power_mesh_1 = Pout./OFS_mass_mesh_1;
%OFS_specific_power_mesh_2 = Pout./OFS_mass_mesh_2;

surf(output_filter_power_mesh, output_filter_efficiency_mesh, OFS_specific_power_mesh_1)
xlabel('Power [kW]')
ylabel('Efficiency')
zlabel('Specific Power [kW/kg]')
title('Output Filter Stage')
hold on
%surf(output_filter_power_mesh, output_filter_efficiency_mesh, OFS_specific_power_mesh_2)
legend('40 kHz') 

%% input dc breaker stage

figure(6)
Input_RBI_efficiency_array = [0.9980:0.0001: 0.9990];
Input_RBI_power_array = [5:10:250];

[input_RBI_efficiency_mesh, input_RBI_power_mesh] = meshgrid(Input_RBI_efficiency_array, Input_RBI_power_array);

F1 = 40;
Vin = 120;
Vout = 0; % vout is not used!
Pout = input_RBI_power_mesh;
Available_Modules = 1;
Required_Modules = 1;

IDRB_efficiency = input_RBI_efficiency_mesh;
IRBI_mass_mesh_1 = Calculate_DC_Remote_Bus_Isolator_Mass(Vin, Pout, Available_Modules, Required_Modules, IDRB_efficiency);

IRBI_specific_power_mesh_1 = Pout./IRBI_mass_mesh_1;

surf(input_RBI_power_mesh, input_RBI_efficiency_mesh, IRBI_specific_power_mesh_1)
xlabel('Power [kW]')
ylabel('Efficiency')
zlabel('Specific Power [kW/kg]')
title('Input DC Breaker Stage')
hold on
legend('40 kHz') % only 40 kHz 

%% output dc breaker stage

figure(7)
Output_RBI_efficiency_array = [0.9980:0.0001: 0.9990];
Output_RBI_power_array = [5:10:250];

[output_RBI_efficiency_mesh, output_RBI_power_mesh] = meshgrid(Output_RBI_efficiency_array, Output_RBI_power_array);

F1 = 40;
Vin = 0; % vin is not used!
Vout = 4500; 
Pout = output_RBI_power_mesh;
Available_Modules = 1;
Required_Modules = 1;

ODRB_efficiency = output_RBI_efficiency_mesh;
ORBI_mass_mesh_1 = Calculate_DC_Remote_Bus_Isolator_Mass(Vout, Pout, Available_Modules, Required_Modules, ODRB_efficiency);

ORBI_specific_power_mesh_1 = Pout./ORBI_mass_mesh_1;

surf(output_RBI_power_mesh, output_RBI_efficiency_mesh, ORBI_specific_power_mesh_1)
xlabel('Power [kW]')
ylabel('Efficiency')
zlabel('Specific Power [kW/kg]')
title('Output DC Breaker Stage')
hold on
legend('40 kHz') % only 40 kHz 


%% DC DC converter stage

figure(8)

efficiency_array = Chopper_efficiency_array .* Inverter_transformer_efficiency_array .* Rectifier_efficiency_array .* Input_filter_efficiency_array .* Output_filter_efficiency_array;
power_array = [5:10:250];

[efficiency_mesh, power_mesh] = meshgrid(efficiency_array, power_array);

F1 = 40;
Vin = 120;
Vout = 0; % vout is not used!
Pout = power_mesh;
Available_Modules = 1;
Required_Modules = 1;


DDCU_mass_mesh = CS_mass_mesh_2 + ITS_mass_mesh_2 + RS_mass_mesh_1 + IFS_mass_mesh_1 + OFS_mass_mesh_1;

% DDCU_efficiency_mesh_40kHz = chopper_efficiency_mesh .* inverter_transformer_efficiency_mesh .* rectifier_efficiency_mesh ...
%     .* input_filter_efficiency_mesh .* output_filter_efficiency_mesh .* input_RBI_efficiency_mesh ...
%     .* output_RBI_efficiency_mesh;

DDCU_specific_power_mesh_40kHz = Pout./DDCU_mass_mesh;

DDCU_specific_power_mesh = Pout./DDCU_mass_mesh;


surf(power_mesh, efficiency_mesh, DDCU_specific_power_mesh)
xlabel('Power [kW]')
ylabel('Efficiency')
zlabel('Specific Power [kW/kg]')
title('DDCU Stage')
hold on
legend('40 kHz') % only 40 kHz 

%% calculating CC_length, CC_width, CC_height

% to determine CC_Length, CC_Width, and CC_Height for the CC_Masses
    packaged_electronics_density = 0.222; % this is for FH, for CP it is 0.249
%     switch(enclosureType)
%         case 'CP'
%             packaged_electronics_density = 0.249;
%         case 'FH'
%             packaged_electronics_density = 0.222; 

    Component_Electronics_Mass = DDCU_mass_mesh;
    Component_Volume = Component_Electronics_Mass./(1000.*packaged_electronics_density);

    CC_Length = 1.351.*Component_Volume.^0.3333;
    CC_Width = 1.148.*Component_Volume.^0.3333;
    CC_Height = 0.646.*Component_Volume.^0.3333;   
% end of determinining CC_Length, width, and height

%% box
figure(9)

efficiency_array = Chopper_efficiency_array .* Inverter_transformer_efficiency_array .* Rectifier_efficiency_array .* Input_filter_efficiency_array .* Output_filter_efficiency_array;
power_array = [5:10:250];

[efficiency_mesh, power_mesh] = meshgrid(efficiency_array, power_array);

Pout = power_mesh;
Available_Modules = 1;
Required_Modules = 1;

box_mass = Calculate_Box_Mass(Pout, Required_Modules, CC_Length, CC_Width, CC_Height, enclosureType, enclosureMaterial);
DDCU_box_mass_mesh = DDCU_mass_mesh + box_mass;

% DDCU_efficiency_mesh_40kHz = chopper_efficiency_mesh .* inverter_transformer_efficiency_mesh .* rectifier_efficiency_mesh ...
%     .* input_filter_efficiency_mesh .* output_filter_efficiency_mesh .* input_RBI_efficiency_mesh ...
%     .* output_RBI_efficiency_mesh;

% DDCU_specific_power_mesh_40kHz = Pout./DDCU_mass_mesh;

DDCU__box_specific_power_mesh = Pout./DDCU_box_mass_mesh;


surf(power_mesh, efficiency_mesh, DDCU__box_specific_power_mesh)
xlabel('Power [kW]')
ylabel('Efficiency')
zlabel('Specific Power [kW/kg]')
title('DDCU W/ Box Stage')
hold on
legend('40 kHz') % only 40 kHz 

%% radiator
figure(10)

efficiency_array = Chopper_efficiency_array .* Inverter_transformer_efficiency_array .* Rectifier_efficiency_array .* Input_filter_efficiency_array .* Output_filter_efficiency_array;
power_array = [5:10:250];

[efficiency_mesh, power_mesh] = meshgrid(efficiency_array, power_array);

Pout = power_mesh;

radiator_mass = Calculate_Radiator_Mass(Radiator_Type, Q, maxBaseplateTemp, maxRadiatorSinkTemp, maxRadiatorBaseplateDelta, radiatorMaterial, CC_Length, CC_Width, CC_Height);
DDCU_radiator_mass_mesh = DDCU_mass_mesh + radiator_mass;

% DDCU_efficiency_mesh_40kHz = chopper_efficiency_mesh .* inverter_transformer_efficiency_mesh .* rectifier_efficiency_mesh ...
%     .* input_filter_efficiency_mesh .* output_filter_efficiency_mesh .* input_RBI_efficiency_mesh ...
%     .* output_RBI_efficiency_mesh;

% DDCU_specific_power_mesh_40kHz = Pout./DDCU_mass_mesh;

DDCU_radiator_specific_power_mesh = Pout./DDCU_radiator_mass_mesh;


surf(power_mesh, efficiency_mesh, DDCU_radiator_specific_power_mesh)
xlabel('Power [kW]')
ylabel('Efficiency')
zlabel('Specific Power [kW/kg]')
title('DDCU W/ Radiator Stage')
hold on
legend('40 kHz') % only 40 kHz 

%% connector
% figure(11)
% 
% efficiency_array = Chopper_efficiency_array .* Inverter_transformer_efficiency_array .* Rectifier_efficiency_array .* Input_filter_efficiency_array .* Output_filter_efficiency_array;
% power_array = [5:10:250];
% 
% [efficiency_mesh, power_mesh] = meshgrid(efficiency_array, power_array);
% 
% F1 = 40;
% Vin = 120;
% Vout = 0; % vout is not used!
% Pout = power_mesh;
% Available_Modules = 1;
% Required_Modules = 1;
% 
% radiator_mass = Calculate_Radiator_Mass(Radiator_Type, Q, maxBaseplateTemp, maxRadiatorSinkTemp, maxRadiatorBaseplateDelta, radiatorMaterial, CC_Length, CC_Width, CC_Height);
% DDCU_radiator_mass_mesh = DDCU_mass_mesh + radiator_mass;
% 
% % DDCU_efficiency_mesh_40kHz = chopper_efficiency_mesh .* inverter_transformer_efficiency_mesh .* rectifier_efficiency_mesh ...
% %     .* input_filter_efficiency_mesh .* output_filter_efficiency_mesh .* input_RBI_efficiency_mesh ...
% %     .* output_RBI_efficiency_mesh;
% 
% % DDCU_specific_power_mesh_40kHz = Pout./DDCU_mass_mesh;
% 
% DDCU_radiator_specific_power_mesh = Pout./DDCU_radiator_mass_mesh;
% 
% 
% surf(power_mesh, efficiency_mesh, DDCU_radiator_specific_power_mesh)
% xlabel('Power [kW]')
% ylabel('Efficiency')
% zlabel('Specific Power [kW/kg]')
% title('DDCU W/ Radiator Stage')
% hold on
% legend('40 kHz') % only 40 kHz

%% all

