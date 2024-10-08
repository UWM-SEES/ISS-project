%Creates 3D plots

%% chopper stage
figure(1)
Chopper_efficiency_array = [0.968:0.001:0.984];
Chopper_power_array = [10:5:100];
[chopper_efficiency_mesh, chopper_power_mesh] = meshgrid(Chopper_efficiency_array, Chopper_power_array);

F1 = 20;
F2 = 40;
Vin = 120;
Vout = 0; %not used
Pout = chopper_power_mesh;
Available_Modules = 1;
Required_Modules = 1;

CS_efficiency = chopper_efficiency_mesh;


mass_mesh_1 = Calculate_CS_Mass(F1, Vin, Vout, Pout, Available_Modules, Required_Modules, CS_efficiency);
mass_mesh_2 = Calculate_CS_Mass(F2, Vin, Vout, Pout, Available_Modules, Required_Modules, CS_efficiency);

specific_power_mesh_1 = Pout./mass_mesh_1;
specific_power_mesh_2 = Pout./mass_mesh_2;

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
Inverter_transformer_efficiency_array = [.986: .001: .996];
Inverter_transformer_power_array = [10:10:250];
[inverter_transformer_efficiency_mesh, inverter_transformer_power_mesh] = meshgrid(Inverter_transformer_efficiency_array, Inverter_transformer_power_array);

F1 = 20;
F2 = 40;
Vin = 120;
Vout = 5000; %not used
Pout = inverter_transformer_power_mesh;
Available_Modules = 1;
Required_Modules = 1;

ITS_efficiency = inverter_transformer_efficiency_mesh;

ITS_mass_mesh_1 = Calculate_ITS_Mass(F1, Vin, Vout, Pout, Available_Modules, Required_Modules, ITS_efficiency);
ITS_mass_mesh_2 = Calculate_ITS_Mass(F2, Vin, Vout, Pout, Available_Modules, Required_Modules, ITS_efficiency);

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
Rectifier_efficiency_array = [.986: .001: .996];
Rectifier_power_array = [10:10:250];
[rectifier_efficiency_mesh, rectifier_power_mesh] = meshgrid(Rectifier_efficiency_array, Rectifier_power_array);

F1 = 40;
% F2 = 40;
Vin = 120;
Vout = 0; %not used
Pout = rectifier_power_mesh;
Available_Modules = 1;
Required_Modules = 1;

RS_efficiency = rectifier_efficiency_mesh;

RS_mass_mesh_1 = Calculate_RS_Mass(F1, Vin, Vout, Pout, Available_Modules, Required_Modules, RS_efficiency);
RS_mass_mesh_2 = Calculate_RS_Mass(F2, Vin, Vout, Pout, Available_Modules, Required_Modules, RS_efficiency);

RS_specific_power_mesh_1 = Pout./RS_mass_mesh_1;
RS_specific_power_mesh_2 = Pout./RS_mass_mesh_2;

surf(rectifier_power_mesh, rectifier_efficiency_mesh, RS_specific_power_mesh_1)
xlabel('Power [kW]')
ylabel('Efficiency')
zlabel('Specific Power [kW/kg]')
title('Rectifier Stage')
hold on
%surf(rectifier_power_mesh, rectifier_efficiency_mesh, RS_specific_power_mesh_2)
legend('40 kHz')
% legend('20 kHz', '40 kHz') % this doesn't matter for rectifier

%% input filter stage

figure(4)
Input_filter_efficiency_array = [0.997: 0.0002:0.999];
Input_filter_power_array = [10:10:200];
[input_filter_efficiency_mesh, input_filter_power_mesh] = meshgrid(Input_filter_efficiency_array, Input_filter_power_array);

F1 = 40;
%F2 = 20;
Vin = 120;
Pout = input_filter_power_mesh;
Available_Modules = 1;
Required_Modules = 1;
FS_ripple = 0.004;

IFS_efficiency = input_filter_efficiency_mesh;

IFS_mass_mesh_1 = Calculate_FS_Mass(F1, Vin, Pout, Available_Modules, Required_Modules, IFS_efficiency, FS_ripple);
%IFS_mass_mesh_2 = Calculate_FS_Mass(F2, Vin, Pout, Available_Modules, Required_Modules, IFS_efficiency, FS_ripple);

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
Output_filter_efficiency_array = [0.997: 0.0002:0.999];
Output_filter_power_array = [10:10:200];
[output_filter_efficiency_mesh, output_filter_power_mesh] = meshgrid(Output_filter_efficiency_array, Output_filter_power_array);

F1 = 40; %if using both F1 and F2, set F1 to 20 and F2 to 40
%F2 = 20;
Vout = 5000;
Pout = output_filter_power_mesh;
Available_Modules = 1;
Required_Modules = 1;
FS_ripple = 0.004;

OFS_efficiency = output_filter_efficiency_mesh;

OFS_mass_mesh_1 = Calculate_FS_Mass(F1, Vout, Pout, Available_Modules, Required_Modules, OFS_efficiency, FS_ripple);
%OFS_mass_mesh_2 = Calculate_FS_Mass(F2, Vout, Pout, Available_Modules, Required_Modules, OFS_efficiency, FS_ripple);

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
IRBI_mass_mesh_1 = Calculate_DRB_Mass(F1, Vout, Vin, Pout, Available_Modules, Required_Modules, IDRB_efficiency);

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
Vout = 5000; 
Pout = output_RBI_power_mesh;
Available_Modules = 1;
Required_Modules = 1;

ODRB_efficiency = output_RBI_efficiency_mesh;
ORBI_mass_mesh_1 = Calculate_DRB_Mass(F1, Vin, Vout, Pout, Available_Modules, Required_Modules, ODRB_efficiency);

ORBI_specific_power_mesh_1 = Pout./ORBI_mass_mesh_1;

surf(output_RBI_power_mesh, output_RBI_efficiency_mesh, ORBI_specific_power_mesh_1)
xlabel('Power [kW]')
ylabel('Efficiency')
zlabel('Specific Power [kW/kg]')
title('Output DC Breaker Stage')
hold on
legend('40 kHz') % only 40 kHz 
