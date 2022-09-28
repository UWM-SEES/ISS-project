function [DDCU, RBI] = Calculate_Total_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, DRB_efficiency, FS_efficiency, FS_ripple, RS_efficiency, ITS_efficiency, CS_efficiency, CC_Efficiency, harnessMaterial, enclosureType, enclosureMaterial, radiatorMaterial, radiatorType, maxRadiatorSinkTemp, maxBaseplateTemp, maxRadiatorBaseplateDelta)
 
    Filter_Stage_Mass_Input = Calculate_Filter_Stage_Mass(F, Vin, Pout, Available_Modules, Required_Modules, FS_efficiency, FS_ripple);
    Filter_Stage_Mass_Output = Calculate_Filter_Stage_Mass(F, Vout, Pout, Available_Modules, Required_Modules, FS_efficiency, FS_ripple);
    Rectifier_Stage_Mass = Calculate_Rectifier_Stage_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, RS_efficiency);
    Inverter_Transformer_Stage_Mass = Calculate_Inverter_Transformer_Stage_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, ITS_efficiency);
    Chopper_Stage_Mass = Calculate_Chopper_Stage_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CS_efficiency);
    
    % to determine CC_Length, CC_Width, and CC_Height for the CC_Masses

    % end of determinining CC_Length, width, and height
        %Calculation Thermal power Q in kw. 
   
    
    %box_Mass = Calculate_Box_Mass(Pout, Required_Modules, CC_Length, CC_Width, CC_Height, enclosureType, enclosureMaterial);
   % radiator_Mass = Calculate_Radiator_Mass(radiatorType, Q, maxBaseplateTemp, maxRadiatorSinkTemp, maxRadiatorBaseplateDelta, radiatorMaterial, CC_Length, CC_Width, CC_Height);
    %Conductor_Connector_Mass_DDCU = Calculate_Conductor_Connector_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CC_Efficiency, CC_Length, CC_Width, CC_Height, harnessMaterial, enclosureType, 2);
    % we temporarily removed Conductor_Connector mass calculations because
    % they didn't seem to give accurate numbers
    %DDCU_CM_Mass = Calculate_Control_Monitoring_Mass(Available_Modules, Required_Modules, Pout, 0);

    %drb calculations
    %DRB_CM_Mass = Calculate_Control_Monitoring_Mass(Available_Modules, Required_Modules, Pout, 1);
    %Conductor_Connector_Mass_DRB = Calculate_Conductor_Connector_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CC_Efficiency, CC_Length, CC_Width, CC_Height, harnessMaterial, enclosureType, 1);
    % we temporarily removed Conductor_Connector mass calculations because
    % they didn't seem to give accurate numbers
    
    %DRB_Mass = Calculate_DC_Remote_Bus_Isolator_Mass(Vout, Pout, Available_Modules, Required_Modules, DRB_efficiency);
   
    
   % total_Mass = Filter_Stage_Mass_Input + Filter_Stage_Mass_Output+  Rectifier_Stage_Mass + Inverter_Transformer_Stage_Mass + ...
    %    Chopper_Stage_Mass + DRB_Mass + ...
    %    DDCU_CM_Mass + DRB_CM_Mass + box_Mass + radiator_Mass;
    
    DDCU = Calculate_DDCU_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, FS_efficiency, FS_ripple, RS_efficiency, ITS_efficiency, CS_efficiency, CC_Efficiency,  harnessMaterial, enclosureType, enclosureMaterial, radiatorType, maxBaseplateTemp, maxRadiatorSinkTemp, maxRadiatorBaseplateDelta, radiatorMaterial);
   % total_DDCU_Mass = Filter_Stage_Mass_Input + Filter_Stage_Mass_Output+  Rectifier_Stage_Mass + Inverter_Transformer_Stage_Mass + ...
    %    Chopper_Stage_Mass + box_Mass + r
    %adiator_Mass + DDCU_CM_Mass + Conductor_Connector_Mass_DDCU;

    %total_DRB_Mass = DRB_CM_Mass + DRB_Mass + radiator_Mass + box_Mass;
    %numRBI = 1;
    RBI.mass_1 = Calculate_DC_RBI_Switchgear_Mass(1, F, Vin, Vout, Pout, Available_Modules, Required_Modules, DRB_efficiency, CC_Efficiency,  harnessMaterial, enclosureType, enclosureMaterial, radiatorType, maxBaseplateTemp, maxRadiatorSinkTemp, maxRadiatorBaseplateDelta, radiatorMaterial)
    RBI.mass_3 = Calculate_DC_RBI_Switchgear_Mass(3, F, Vin, Vout, Pout, Available_Modules, Required_Modules, DRB_efficiency, CC_Efficiency,  harnessMaterial, enclosureType, enclosureMaterial, radiatorType, maxBaseplateTemp, maxRadiatorSinkTemp, maxRadiatorBaseplateDelta, radiatorMaterial)
    RBI.mass_4 = Calculate_DC_RBI_Switchgear_Mass(4, F, Vin, Vout, Pout, Available_Modules, Required_Modules, DRB_efficiency, CC_Efficiency,  harnessMaterial, enclosureType, enclosureMaterial, radiatorType, maxBaseplateTemp, maxRadiatorSinkTemp, maxRadiatorBaseplateDelta, radiatorMaterial)

     fprintf('Total DC/DC Converter Mass: %4.3f kg \n', DDCU.total_Mass)
    
    %TO BE FIXED AT END --MAYBE
    %display_individual_masses(Filter_Stage_Mass_Input,Filter_Stage_Mass_Output, Rectifier_Stage_Mass, Inverter_Transformer_Stage_Mass, Chopper_Stage_Mass, box_Mass, radiator_Mass, DRB_Mass, DDCU_CM_Mass, DRB_CM_Mass, Conductor_Connector_Mass_DDCU); 
    
    

    display_individual_masses_v2(DDCU)
    
%     box_volume = CC_Length*CC_Width*CC_Height*1000;
%     fprintf('Box Volume: %2.3f [Liters]\n', box_volume)
%     fprintf('\t Box Width: %2.3f [m]\n', CC_Width)
%     fprintf('\t Box Length: %2.3f [m]\n', CC_Length)
%     fprintf('\t Box Height: %2.3f [m]\n', CC_Height)
%     power_density = Pout/box_volume;
%     fprintf('Power Density of DC/DC Converter %4.3f kWe/L \n',power_density)
    
    %fprintf('Total DRBI Mass: %4.3f kg \n',  Mass_obj.RBI_mass_4)
    
   % total_Mass = RBI_Mass_4 + total_DDCU_Mass;
    % we eventually want this to look like:
    % DDCU_Mass = Calculate_DDCU_Mass(JOFJODIJODIS)
    % DRB_Switchgear_Mass = Calculate DC_RBI_Switchgear_Mass(OSIDFJOIDFJ)
    % total_Mass = DDCU_Mass + DRB_Switchgear_Mass
end