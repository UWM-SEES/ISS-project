function [DRB_Mass] = Calculate_DC_Remote_Bus_Isolator_Mass(Vout, Pout, Available_Modules, Required_Modules, DRB_efficiency)

    DRBE = DRB_efficiency; % DC RBI Efficiency
    DRBAM = Available_Modules; % Dc RBI Available Modules
    DRBRM = Required_Modules; % Dc RBI Required Modules
    DRBPo = Pout; % Dc RBI Power Output (kWe)
    DRBVo = Vout; % Dc RBI Voltage Output (Vdc)

    DRBM_mass_coefficient = 0.12;
    DRBM_efficiency_factor = (exp(0.0008./(1-DRBE)))./1.7;
    DRBM_redundancy_factor = DRBAM./DRBRM;
    DRBM_power_level_multiplier = DRBPo;
    DRBM_power_level_factor = (DRBPo./DRBRM).^(-0.15);
    DRBM_voltage_level_factor = (DRBVo./200).^0.13;

    DRB_Mass = DRBM_mass_coefficient .* DRBM_efficiency_factor .* DRBM_redundancy_factor...
    .* DRBM_power_level_multiplier .* DRBM_power_level_factor ...
    .* DRBM_voltage_level_factor;


end
