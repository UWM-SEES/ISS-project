function [DRB_Switchgear_Mass] = Calculate_DC_RBI_Switchgear_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, DRB_efficiency, FS_efficiency, FS_ripple, RS_efficiency, ITS_efficiency, CS_efficiency, CC_Efficiency, CC_Length, CC_Width, CC_Height, harnessMaterial, enclosureType, enclosureMaterial, CM_Power)
    DRB_CM_Mass = Calculate_Control_Monitoring_Mass(Available_Modules, Required_Modules, Pout, 1);
    Conductor_Connector_Mass_DRB = Calculate_Conductor_Connector_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CC_Efficiency, CC_Length, CC_Width, CC_Height, harnessMaterial, enclosureType, 1); % currently not using because of unexpectedly large output
    DRB_Mass = Calculate_DC_Remote_Bus_Isolator_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, DRB_efficiency);
%add heatsink/radiator

    DRB_Switchgear_Mass = DRB_CM_Mass + DRB_Mass;