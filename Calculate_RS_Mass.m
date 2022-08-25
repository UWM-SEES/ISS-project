function [RS_Mass] = Calculate_RS_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, RS_efficiency)

    RSE = RS_efficiency; % Rectifier Stage Efficiency
    RSAM = Available_Modules; % Rectifier Stage Available Modules
    RSRM = Required_Modules; % Rectifier Stage Required Modules
    RSPo = Pout; % Rectifier Stage Power Output (kWe)
    RSVi = Vin; % Rectifier Stage Voltage Input (Vrms)

    RSM_mass_coefficient = 0.1175;
    RSM_efficiency_factor = ((exp(0.005./(1-RSE)))./1.469);
    RSM_redundancy_factor = RSAM./RSRM;
    RSM_power_level_multiplier = RSPo;
    RSM_voltage_level_factors = (RSVi./(RSVi-2)).^6;

    RS_Mass = RSM_mass_coefficient .* RSM_efficiency_factor .* RSM_redundancy_factor...
    .* RSM_power_level_multiplier .* RSM_voltage_level_factors;

end