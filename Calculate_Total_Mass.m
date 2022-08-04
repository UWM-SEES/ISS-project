function [total_Mass] = Calculate_Total_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, DRB_efficiency, FS_efficiency, FS_ripple, RS_efficiency, ITS_efficiency, CS_efficiency, CC_Efficiency, CC_Length, CC_Width, CC_Height, harnessMaterial, enclosureType, enclosureMaterial)
 
    Filter_Stage_Mass = Calculate_FS_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, FS_efficiency, FS_ripple);
    Rectifier_Stage_Mass = Calculate_RS_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, RS_efficiency);
    Inverter_Transformer_Stage_Mass = Calculate_ITS_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, ITS_efficiency);
    Chopper_Stage_Mass = Calculate_CS_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CS_efficiency);
    
    % to determine CC_Length, CC_Width, and CC_Height for the CC_Masses
    packaged_electronics_density = 0.222; % this is for FH, for CP it is 0.249
    Component_Electronics_Mass = Filter_Stage_Mass + Rectifier_Stage_Mass + Inverter_Transformer_Stage_Mass + Chopper_Stage_Mass;
    Component_Volume = Component_Electronics_Mass/(1000*packaged_electronics_density);
   
    switch(enclosureType)
        case 'CP'
            CC_Length = 1.610*Component_Volume^0.3333;
            CC_Width = 1.043*Component_Volume^0.3333;
            CC_Height = 0.596*Component_Volume^0.3333;
        case 'FH'
            CC_Length = 1.351*Component_Volume^0.3333;
            CC_Width = 1.148*Component_Volume^0.3333;
            CC_Height = 0.646*Component_Volume^0.3333;   
    end
    % end of determinining CC_Length, width, and height
    
    box_Mass = Calculate_Box_Mass(Pout, Required_Modules, CC_Length, CC_Width, CC_Height, enclosureType, enclosureMaterial);
    Conductor_Connector_Mass_DDCU = Calculate_CC_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CC_Efficiency, CC_Length, CC_Width, CC_Height, harnessMaterial, enclosureType, 2);
    DDCU_CM_Mass = Calculate_CM_Mass(Available_Modules, Required_Modules, Pout, 0);
    
    
    %drb calculations
    DRB_CM_Mass = Calculate_CM_Mass(Available_Modules, Required_Modules, Pout, 1);
    Conductor_Connector_Mass_DRB = Calculate_CC_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CC_Efficiency, CC_Length, CC_Width, CC_Height, harnessMaterial, enclosureType, 1);
    DRB_Mass = Calculate_DRB_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, DRB_efficiency);

    display_individual_masses(Filter_Stage_Mass, Rectifier_Stage_Mass, Inverter_Transformer_Stage_Mass, Chopper_Stage_Mass, box_Mass, DRB_Mass, DDCU_CM_Mass, DRB_CM_Mass); 
    
    total_Mass = Filter_Stage_Mass + Rectifier_Stage_Mass + Inverter_Transformer_Stage_Mass + ...
        Chopper_Stage_Mass + DRB_Mass + ...
        DDCU_CM_Mass + DRB_CM_Mass + box_Mass;
end