function [DDCU_Mass] = Calculate_DDCU_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, DRB_efficiency, FS_efficiency, FS_ripple, RS_efficiency, ITS_efficiency, CS_efficiency, CC_Efficiency, CC_Length, CC_Width, CC_Height, harnessMaterial, enclosureType, enclosureMaterial, CM_Power)
    % we probably want THIS to be in total_Mass, along with DC RBI
    % switchgear, and call smaller Calculate functions w/in here
    DDCSE = FS_efficiency^2 * CS_efficiency * ITS_efficiency * RS_efficiency; %FS squared because two filters
    DDCE = Pout/((Pout/FS_efficiency/RS_efficiency/ITS_efficiency/CS_efficiency + CM_Power/1000)/FS_efficiency);
    
    Filter_Stage_Mass = Calculate_FS_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, FS_efficiency, FS_ripple);
    Rectifier_Stage_Mass = Calculate_RS_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, RS_efficiency);
    Inverter_Transformer_Stage_Mass = Calculate_ITS_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, ITS_efficiency);
    Chopper_Stage_Mass = Calculate_CS_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CS_efficiency);
    
    
    DDCEM = 
    Pin = Pout/DDCE;
    
    DDCU_Mass = 0;