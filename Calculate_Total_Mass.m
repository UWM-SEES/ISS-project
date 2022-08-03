function [total_Mass] = Calculate_Total_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, DRB_efficiency, FS_efficiency, FS_ripple, RS_efficiency, ITS_efficiency, CS_efficiency, CC_Efficiency, CC_Length, CC_Width, CC_Height)
    Filter_Stage_Mass = Calculate_FS_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, FS_efficiency, FS_ripple);
    Rectifier_Stage_Mass = Calculate_RS_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, RS_efficiency);
    Inverter_Transformer_Stage_Mass = Calculate_ITS_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, ITS_efficiency);
    Chopper_Stage_Mass = Calculate_CS_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CS_efficiency);
    Conductor_Connector_Mass = Calculate_CC_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CC_Efficiency, CC_Length, CC_Width, CC_Height);
    DRB_Mass = Calculate_DRB_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, DRB_efficiency);
    
    total_Mass = Filter_Stage_Mass + Rectifier_Stage_Mass + Inverter_Transformer_Stage_Mass + ...
        Conductor_Connector_Mass + Chopper_Stage_Mass + DRB_Mass;
end