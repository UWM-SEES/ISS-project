function [] = display_individual_masses_v2_RBI(obj)

     fprintf("Number of RBIs %2.0f \n", obj.numRBI) 
     fprintf("\tRBI switchgear total mass: %4.3f kg \n", obj.DRB_Switchgear_Mass)  
    fprintf("\t Total RBI mass: %4.3f kg \n", obj.Total_DRB_Mass) 
    fprintf("\t Total Conductor & Connector mass: %4.3f kg \n", obj.Total_Conductor_Connector_Mass_DRB)
    fprintf("\t Total Control and Monitor hardware mass: %4.3f kg \n", obj.Total_DRB_CM_Mass)
    fprintf("\t\t Individual RBI mass: %4.3f kg \n", obj.DRB_Mass)
    fprintf("\t\t Individual Conductor & Connector mass: %4.3f kg \n", obj.Conductor_Connector_Mass_DRB)
    fprintf("\t\t Individual Control and Monitor hardware mass: %4.3f kg \n", obj.DRB_CM_Mass)
    fprintf("\t RBI radiator mass: %4.3f kg \n", obj.radiator_Mass) 
    fprintf("\t Box Mass: %4.3f kg \n", obj.box_Mass)
    fprintf('\n\t Specific Power of Switchgear Assembly %4.3f kWe/kg \n',obj.specific_power)
    fprintf('\t Box Volume: %2.3f [L]\n', obj.Component_Volume*1000)
    fprintf('\t\t Box Width: %2.3f [m]\n', obj.CC_Width)
    fprintf('\t\t Box Length: %2.3f [m]\n', obj.CC_Length)
    fprintf('\t\t Box Height: %2.3f [m]\n', obj.CC_Height)
    fprintf('\tPower Density of Switchgear Assembly %4.3f kWe/L \n\n',obj.power_density)
    
%     obj.x = obj.Rectifier_Stage_Mass + obj.Chopper_Stage_Mass + obj.Inverter_Transformer_Stage_Mass;
%     fprintf("\t DC/DC Converter Elemental Parts Mass: %4.3f kg \n", obj.x)   
%     fprintf("\t\t Chopper Stage Mass: %4.3f kg \n", obj.Chopper_Stage_Mass)   
%     fprintf("\t\t Rectifier Stage Mass: %4.3f kg \n", obj.Rectifier_Stage_Mass)
%     fprintf("\t\t Inverter Transformer Stage Mass: %4.3f kg \n", obj.Inverter_Transformer_Stage_Mass)
%     fprintf("\t Filter Stage Total Mass: %4.3f kg \n", obj.Filter_Stage_Mass_Input + obj.Filter_Stage_Mass_Output)  
%     fprintf("\t\t Input Filter Stage Mass: %4.3f kg \n", obj.Filter_Stage_Mass_Input )  
%     fprintf("\t\t Output Filter Stage Mass: %4.3f kg \n", obj.Filter_Stage_Mass_Output)  
%     fprintf("\t Box Mass: %4.3f kg \n", obj.box_Mass)
%     fprintf("\t Radiator Mass: %4.3f kg \n", obj.radiator_Mass)
%     fprintf("\t DC/DC Converter Control and Monitoring Mass: %4.3f kg \n", obj.CM_Mass)
%     fprintf("\t DC/DC Converter Conductor/Connector Mass: " + obj.Conductor_Connector_Mass + " kg\n")
%     fprintf('\nSpecific Power of DC/DC Converter %4.3f kWe/kg \n',obj.specific_power)
%     
%     fprintf('Box Volume: %2.3f [Liters]\n', obj.Component_Volume*1000)
%     fprintf('\t Box Width: %2.3f [m]\n', obj.CC_Width)
%     fprintf('\t Box Length: %2.3f [m]\n', obj.CC_Length)
%     fprintf('\t Box Height: %2.3f [m]\n', obj.CC_Height)
%     fprintf('Power Density of DC/DC Converter %4.3f kWe/L \n\n',obj.power_density)
    
    
    %fprintf("\t DC RBI Mass: %4.3f kg \n", DRB_Mass)
    %fprintf("\t DC RBI Control and Monitoring Mass: %4.3f kg \n", DRB_CM_Mass)
    % disp("DC RBI Conductor/Connector Mass: " + Conductor_Connector_Mass_DRB + " kg")
   
    %fprintf("\DC/DC Converter Elemental Parts Mass: %4.3f kg kg", x)
    
end  
    