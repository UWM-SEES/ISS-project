function [CC_Mass] = Calculate_CC_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CC_Efficiency, CC_Length, CC_Width, CC_Height)

    CCCE = CC_Efficiency; %Component Efficiency- made up
    CCAM = Available_Modules; % Available Modules
    CCRM = Required_Modules; % Required Modules
    CCPo = Pout; % Power Output (kWe)
    CCVi = Vin; % Voltage Input (VrmsLL or Vdc)
    CCVo = Vout; % Voltage Output (VrmsLL or Vdc)
    CCEL = CC_Length; % Packaged Electronics Length (meters)
    CCEW = CC_Width; % Packaged Electronics Width (meters)
    CCEH = CC_Height; % Packaged Electronics Height (meters)


    
    CC_Mass = (CCAM/CCRM) * 29.3 * (0.5*(CCEL + CCEW) + CCEH)*((CCPo/CCCE/CCVi) + ...
    (CCPo/CCVo)) + CCAM *(5.22*(0.5*(CCEL + CCEW) + CCEH) + 0.238*(CCPo/CCRM)^0.1 + ...
    0.2667*(CCPo/CCRM)^0.5); % POWER CONDUCTOR SEGMENT

    

end