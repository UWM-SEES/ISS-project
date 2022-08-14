function [total_Mass] = Calculate_Total_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, DRB_efficiency, FS_efficiency, FS_ripple, RS_efficiency, ITS_efficiency, CS_efficiency, CC_Efficiency, CC_Length, CC_Width, CC_Height, harnessMaterial, enclosureType, enclosureMaterial)
 
    Filter_Stage_Mass_Input = Calculate_FS_Mass(F, Vin, Pout, Available_Modules, Required_Modules, FS_efficiency, FS_ripple);
    Filter_Stage_Mass_Output = Calculate_FS_Mass(F, Vout, Pout, Available_Modules, Required_Modules, FS_efficiency, FS_ripple);
    Rectifier_Stage_Mass = Calculate_RS_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, RS_efficiency);
    Inverter_Transformer_Stage_Mass = Calculate_ITS_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, ITS_efficiency);
    Chopper_Stage_Mass = Calculate_CS_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CS_efficiency);
    
    % to determine CC_Length, CC_Width, and CC_Height for the CC_Masses
    packaged_electronics_density = 0.222; % this is for FH, for CP it is 0.249
    Component_Electronics_Mass = Filter_Stage_Mass_Input + Filter_Stage_Mass_Output + Rectifier_Stage_Mass + Inverter_Transformer_Stage_Mass + Chopper_Stage_Mass;
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
    Conductor_Connector_Mass_DDCU = Calculate_CC_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CC_Efficiency, CC_Length, CC_Width, CC_Height, harnessMaterial, enclosureType, 2)
    DDCU_CM_Mass = Calculate_CM_Mass(Available_Modules, Required_Modules, Pout, 0);
    
    
    %drb calculations
    DRB_CM_Mass = Calculate_CM_Mass(Available_Modules, Required_Modules, Pout, 1);
    Conductor_Connector_Mass_DRB = Calculate_CC_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CC_Efficiency, CC_Length, CC_Width, CC_Height, harnessMaterial, enclosureType, 1)
    DRB_Mass = Calculate_DRB_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, DRB_efficiency);
   
    
    total_Mass = Filter_Stage_Mass_Input + Filter_Stage_Mass_Output+  Rectifier_Stage_Mass + Inverter_Transformer_Stage_Mass + ...
        Chopper_Stage_Mass + DRB_Mass + ...
        DDCU_CM_Mass + DRB_CM_Mass + box_Mass;
    
     fprintf('Total DC/DC Converter Mass: %4.3f kg \n', total_Mass)
    
    display_individual_masses(Filter_Stage_Mass_Input,Filter_Stage_Mass_Output, Rectifier_Stage_Mass, Inverter_Transformer_Stage_Mass, Chopper_Stage_Mass, box_Mass, DRB_Mass, DDCU_CM_Mass, DRB_CM_Mass); 
    
    specific_power = Pout/total_Mass;
    fprintf('\nSpecific Power of DC/DC Converter %4.3f kWe/kg \n',specific_power)
    
    box_volume = CC_Length*CC_Width*CC_Height*1000;
    fprintf('Box Volume: %2.3f [Liters]\n', box_volume)
    fprintf('\t Box Width: %2.3f [m]\n', CC_Width)
    fprintf('\t Box Length: %2.3f [m]\n', CC_Length)
    fprintf('\t Box Height: %2.3f [m]\n', CC_Height)
    power_density = Pout/box_volume;
    fprintf('Power Density of DC/DC Converter %4.3f kWe/L \n',power_density)
    
 


    % we eventually want this to look like:
    % DDCU_Mass = Calculate_DDCU_Mass(JOFJODIJODIS)
    % DRB_Switchgear_Mass = Calculate DRB_Switchgear_Mass(OSIDFJOIDFJ)
    % total_Mass = DDCU_Mass + DRB_Switchgear_Mass
end