function [FS_Mass] = Calculate_FS_Mass(F, V_rated, Pout, Available_Modules, Required_Modules, FS_efficiency, FS_ripple)

    FSRF = FS_ripple; % Dc Filter Stage Ripple Factor (0.1 to 5%)
    FSE = FS_efficiency; % Dc Filter Stage Efficiency (99.8%)
    FSAM = Available_Modules; % Dc Filter Stage Available Modules
    FSRM = Required_Modules; % Dc Filter Stage Required Modules
    FSPo = Pout; % Dc Filter Stage Power Output (kWe)
    FSVo = V_rated; % Dc Filter Stage Voltage Rating (Vdc)
    FSF = F; % Dc Filter Stage Frequency (kHz)

    FSM_mass_coefficient = 22.05;
    FSM_ripple_factor = (1/(FSRF/0.01)^0.5);
    FSM_efficiency_factor = ((1-0.998)/(1-FSE));
    FSM_redundancy_factor = (FSAM/FSRM);
    FSM_power_level_multiplier = FSPo;
    FSM_voltage_level_factors = (FSVo^(-0.9) + 0.000015);
    FSM_frequency_factor = 40/FSF;

    FS_Mass = FSM_mass_coefficient * FSM_ripple_factor * FSM_efficiency_factor...
    * FSM_redundancy_factor * FSM_power_level_multiplier * FSM_voltage_level_factors...
    * FSM_frequency_factor;

end