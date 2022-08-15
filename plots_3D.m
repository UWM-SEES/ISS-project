%Creates 3D plots
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