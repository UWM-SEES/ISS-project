function [CS_Mass] = Calculate_Chopper_Stage_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CS_efficiency)

    CSE = CS_efficiency; % chopper stage efficiency
    CSAM = Available_Modules;
    CSRM = Required_Modules;
    CSVi = Vin;
    CSF = F; % Chopper Stage Frequency (kHz)

    CSPo = Pout; % Chopper Stage Power Output (kWe) 

    CSM_mass_coefficient = 0.645; % mass coefficient

    CSM_efficiency_factor = exp(0.01./(1-CSE))./1.5169;

    CSM_redundancy_factor = CSAM./CSRM;

    CSM_power_level_multiplier = CSPo;

    CSM_power_level_factor = (CSPo./CSRM).^(-0.065);

    CSM_voltage_level_factors = (CSVi./(CSVi-2)).^7 * exp(CSVi./40000);

    CSM_frequency_factors = (20./CSF).^0.45 * exp(CSPo.^0.1 * CSF./200);

      CS_Mass = CSM_mass_coefficient .* CSM_efficiency_factor .* CSM_redundancy_factor ...
    .* CSM_power_level_multiplier .* CSM_power_level_factor .* CSM_voltage_level_factors ...
    .* CSM_frequency_factors;
      
end