function [ITS_Mass] = Calculate_ITS_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, ITS_efficiency)

    ITSE = ITS_efficiency; % Inverter Transformer Stage Efficiency
    ITSAM = Available_Modules; % Inverter Transformer Stage Available Modules
    ITSRM = Required_Modules; % Inverter Transformer Stage Required Modules
    ITSPo = Pout; % Inverter Transformer Stage Power Output (kWe)
    ITSVi = Vin; % Inverter Transformer Stage Voltage Input (Vrms)
    ITSVo = Vout; % Inverter Transformer Stage Voltage Output (Vrms)
    ITSF = F; % Inverter Transformer Stage Frequency (kHz)

    ITSM_mass_coefficient = 1.27;
    ITSM_efficiency_factor = (exp(0.0048./(1-ITSE)))./1.8221;
    ITSM_redundancy_factor = ITSAM./ITSRM;
    ITSM_power_level_multiplier = ITSPo;
    ITSM_power_level_factor = (ITSPo./ITSRM).^(-0.08);
    ITSM_voltage_level_factors = exp(ITSVi./200000).*exp(ITSVo./200000);
    ITSM_frequency_level_factors = (ITSF).^(-0.47) + (ITSF./300).^1.4 - ...
    (200./ITSPo).^0.03 .* ((max(0, ITSF-30))./300).^1.7;

    ITS_Mass = ITSM_mass_coefficient .* ITSM_efficiency_factor...
    .* ITSM_redundancy_factor .* ITSM_power_level_multiplier ...
    .* ITSM_power_level_factor .* ITSM_voltage_level_factors ...
    .* ITSM_frequency_level_factors;

end