function [total_Mass] = Calculate_Total_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, DRB_efficiency, FS_efficiency, FS_ripple, RS_efficiency, ITS_efficiency, CS_efficiency, CC_Efficiency, harnessMaterial, enclosureType, enclosureMaterial, radiatorMaterial, Q, radiatorType, maxRadiatorSinkTemp, maxBaseplateTemp, maxRadiatorBaseplateDelta)
 
    Filter_Stage_Mass_Input = Calculate_Filter_Stage_Mass(F, Vin, Pout, Available_Modules, Required_Modules, FS_efficiency, FS_ripple);
    Filter_Stage_Mass_Output = Calculate_Filter_Stage_Mass(F, Vout, Pout, Available_Modules, Required_Modules, FS_efficiency, FS_ripple);
    Rectifier_Stage_Mass = Calculate_Rectifier_Stage_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, RS_efficiency);
    Inverter_Transformer_Stage_Mass = Calculate_Inverter_Transformer_Stage_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, ITS_efficiency);
    Chopper_Stage_Mass = Calculate_Chopper_Stage_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CS_efficiency);
    
    % to determine CC_Length, CC_Width, and CC_Height for the CC_Masses
    packaged_electronics_density = 0.222; % this is for FH, for CP it is 0.249
%     switch(enclosureType)
%         case 'CP'
%             packaged_electronics_density = 0.249;
%         case 'FH'
%             packaged_electronics_density = 0.222; 

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
    radiator_Mass = Calculate_Radiator_Mass(radiatorType, Q, maxBaseplateTemp, maxRadiatorSinkTemp, maxRadiatorBaseplateDelta, radiatorMaterial, CC_Length, CC_Width, CC_Height);
    Conductor_Connector_Mass_DDCU = Calculate_Conductor_Connector_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CC_Efficiency, CC_Length, CC_Width, CC_Height, harnessMaterial, enclosureType, 2);
    % we temporarily removed Conductor_Connector mass calculations because
    % they didn't seem to give accurate numbers
    DDCU_CM_Mass = Calculate_Control_Monitoring_Mass(Available_Modules, Required_Modules, Pout, 0);

    %drb calculations
    DRB_CM_Mass = Calculate_Control_Monitoring_Mass(Available_Modules, Required_Modules, Pout, 1);
    Conductor_Connector_Mass_DRB = Calculate_Conductor_Connector_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CC_Efficiency, CC_Length, CC_Width, CC_Height, harnessMaterial, enclosureType, 1);
    % we temporarily removed Conductor_Connector mass calculations because
    % they didn't seem to give accurate numbers
    
    DRB_Mass = Calculate_DC_Remote_Bus_Isolator_Mass(Vout, Pout, Available_Modules, Required_Modules, DRB_efficiency);
   
    
    total_Mass = Filter_Stage_Mass_Input + Filter_Stage_Mass_Output+  Rectifier_Stage_Mass + Inverter_Transformer_Stage_Mass + ...
        Chopper_Stage_Mass + DRB_Mass + ...
        DDCU_CM_Mass + DRB_CM_Mass + box_Mass + radiator_Mass;
    
    total_DDCU_Mass = Filter_Stage_Mass_Input + Filter_Stage_Mass_Output+  Rectifier_Stage_Mass + Inverter_Transformer_Stage_Mass + ...
        Chopper_Stage_Mass + box_Mass + radiator_Mass + DDCU_CM_Mass + Conductor_Connector_Mass_DDCU;

    total_DRB_Mass = DRB_CM_Mass + DRB_Mass + radiator_Mass + box_Mass;

     fprintf('Total DC/DC Converter Mass: %4.3f kg \n', total_DDCU_Mass)
    
    display_individual_masses(Filter_Stage_Mass_Input,Filter_Stage_Mass_Output, Rectifier_Stage_Mass, Inverter_Transformer_Stage_Mass, Chopper_Stage_Mass, box_Mass, radiator_Mass, DRB_Mass, DDCU_CM_Mass, DRB_CM_Mass, Conductor_Connector_Mass_DDCU); 
    
    specific_power = Pout/total_Mass;
    fprintf('\nSpecific Power of DC/DC Converter %4.3f kWe/kg \n',specific_power)
    
    box_volume = CC_Length*CC_Width*CC_Height*1000;
    fprintf('Box Volume: %2.3f [Liters]\n', box_volume)
    fprintf('\t Box Width: %2.3f [m]\n', CC_Width)
    fprintf('\t Box Length: %2.3f [m]\n', CC_Length)
    fprintf('\t Box Height: %2.3f [m]\n', CC_Height)
    power_density = Pout/box_volume;
    fprintf('Power Density of DC/DC Converter %4.3f kWe/L \n',power_density)
    
    fprintf('Total DRBI Mass: %4.3f kg \n', total_DRB_Mass)


    % we eventually want this to look like:
    % DDCU_Mass = Calculate_DDCU_Mass(JOFJODIJODIS)
    % DRB_Switchgear_Mass = Calculate DC_RBI_Switchgear_Mass(OSIDFJOIDFJ)
    % total_Mass = DDCU_Mass + DRB_Switchgear_Mass
end