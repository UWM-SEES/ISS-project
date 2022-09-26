function [DDCU_Mass] = Calculate_DDCU_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, DRB_efficiency, FS_efficiency, FS_ripple, RS_efficiency, ITS_efficiency, CS_efficiency, CC_Efficiency, CC_Length, CC_Width, CC_Height, harnessMaterial, enclosureType, enclosureMaterial, CM_Power)
    % we probably want THIS to be in total_Mass, along with DC RBI
    % switchgear, and call smaller Calculate functions w/in here

    Filter_Stage_Mass_Input = Calculate_Filter_Stage_Mass(F, Vin, Pout, Available_Modules, Required_Modules, FS_efficiency, FS_ripple);
    Filter_Stage_Mass_Output = Calculate_Filter_Stage_Mass(F, Vout, Pout, Available_Modules, Required_Modules, FS_efficiency, FS_ripple);
    Rectifier_Stage_Mass = Calculate_Rectifier_Stage_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, RS_efficiency);
    Inverter_Transformer_Stage_Mass = Calculate_Inverter_Transformer_Stage_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, ITS_efficiency);
    Chopper_Stage_Mass = Calculate_Chopper_Stage_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CS_efficiency);


    box_Mass = Calculate_Box_Mass(Pout, Required_Modules, CC_Length, CC_Width, CC_Height, enclosureType, enclosureMaterial);
    
    radiator_Mass = Calculate_Radiator_Mass(radiatorType, Q, maxBaseplateTemp, maxRadiatorSinkTemp, maxRadiatorBaseplateDelta, radiatorMaterial, CC_Length, CC_Width, CC_Height);
    
    Conductor_Connector_Mass_DDCU = Calculate_Conductor_Connector_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CC_Efficiency, CC_Length, CC_Width, CC_Height, harnessMaterial, enclosureType, 2)
    % we temporarily removed Conductor_Connector mass calculations because
    % they didn't seem to give accurate numbers
    
    CM_Mass = Calculate_Control_Monitoring_Mass(Available_Modules, Required_Modules, Pout, 0);

    
%     Q_DDCU = Pout * (1 - DDCSE); % i think
%     Pin = Pout/DDCE;
    
    DDCU_Mass = Filter_Stage_Mass_Input + Filter_Stage_Mass_Output+  Rectifier_Stage_Mass + Inverter_Transformer_Stage_Mass + ...
        Chopper_Stage_Mass + box_Mass + radiator_Mass + CM_Mass;