function [] = display_individual_masses_v2(DDCU)
    DDCU.x = DDCU.Rectifier_Stage_Mass + DDCU.Chopper_Stage_Mass + DDCU.Inverter_Transformer_Stage_Mass;
    fprintf("\t DC/DC Converter Elemental Parts Mass: %4.3f kg \n", DDCU.x)   
    fprintf("\t\t Chopper Stage Mass: %4.3f kg \n", DDCU.Chopper_Stage_Mass)   
    fprintf("\t\t Rectifier Stage Mass: %4.3f kg \n", DDCU.Rectifier_Stage_Mass)
    fprintf("\t\t Inverter Transformer Stage Mass: %4.3f kg \n", DDCU.Inverter_Transformer_Stage_Mass)
    fprintf("\t Filter Stage Total Mass: %4.3f kg \n", DDCU.Filter_Stage_Mass_Input + DDCU.Filter_Stage_Mass_Output)  
    fprintf("\t\t Input Filter Stage Mass: %4.3f kg \n", DDCU.Filter_Stage_Mass_Input )  
    fprintf("\t\t Output Filter Stage Mass: %4.3f kg \n", DDCU.Filter_Stage_Mass_Output)  
    fprintf("\t Box Mass: %4.3f kg \n", DDCU.box_Mass)
    fprintf("\t Radiator Mass: %4.3f kg \n", DDCU.radiator_Mass)
    fprintf("\t DC/DC Converter Control and Monitoring Mass: %4.3f kg \n", DDCU.CM_Mass)
    fprintf("\t DC/DC Converter Conductor/Connector Mass: " + DDCU.Conductor_Connector_Mass + " kg\n")
    fprintf('\nSpecific Power of DC/DC Converter %4.3f kWe/kg \n',DDCU.specific_power)
    
    fprintf('Box Volume: %2.3f [Liters]\n', DDCU.Component_Volume*1000)
    fprintf('\t Box Width: %2.3f [m]\n', DDCU.CC_Width)
    fprintf('\t Box Length: %2.3f [m]\n', DDCU.CC_Length)
    fprintf('\t Box Height: %2.3f [m]\n', DDCU.CC_Height)
    fprintf('Power Density of DC/DC Converter %4.3f kWe/L \n\n',DDCU.power_density)
    
    
    %fprintf("\t DC RBI Mass: %4.3f kg \n", DRB_Mass)
    %fprintf("\t DC RBI Control and Monitoring Mass: %4.3f kg \n", DRB_CM_Mass)
    % disp("DC RBI Conductor/Connector Mass: " + Conductor_Connector_Mass_DRB + " kg")
   
    %fprintf("\DC/DC Converter Elemental Parts Mass: %4.3f kg kg", x)
    
end  
    