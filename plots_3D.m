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


mass_mesh_1 = Calculate_CS_Mass(F1, Vin, Vout, Pout, Available_Modules, Required_Modules, CS_efficiency)
mass_mesh_2 = Calculate_CS_Mass(F2, Vin, Vout, Pout, Available_Modules, Required_Modules, CS_efficiency)

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
Vout = 0; %not used
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

F1 = 20;
F2 = 40;
Vin = 120;
Vout = 0; %not used
Pout = rectifier_power_mesh;
Available_Modules = 1;
Required_Modules = 1;

RS_efficiency = rectifier_efficiency_mesh;

RS_mass_mesh_1 = Calculate_RS_Mass(F1, Vin, Vout, Pout, Available_Modules, Required_Modules, ITS_efficiency);
RS_mass_mesh_2 = Calculate_RS_Mass(F2, Vin, Vout, Pout, Available_Modules, Required_Modules, ITS_efficiency);

RS_specific_power_mesh_1 = Pout./RS_mass_mesh_1;
RS_specific_power_mesh_2 = Pout./RS_mass_mesh_2;

surf(rectifier_power_mesh, rectifier_efficiency_mesh, RS_specific_power_mesh_1)
xlabel('Power [kW]')
ylabel('Efficiency')
zlabel('Specific Power [kW/kg]')
title('Rectifier Stage')
hold on
surf(rectifier_power_mesh, rectifier_efficiency_mesh, RS_specific_power_mesh_2)
legend('20 kHz', '40 kHz') % this doesn't matter for rectifier

%% filter stage
