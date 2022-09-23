function [] = display_individual_masses(Filter_Stage_Mass_Input, Filter_Stage_Mass_Output, Rectifier_Stage_Mass, Inverter_Transformer_Stage_Mass, Chopper_Stage_Mass, box_Mass, radiator_Mass, DRB_Mass, DDCU_CM_Mass, DRB_CM_Mass, DDCU_CC_Mass)
    x = Rectifier_Stage_Mass + Chopper_Stage_Mass + Inverter_Transformer_Stage_Mass;
    fprintf("\t DC/DC Converter Elemental Parts Mass: %4.3f kg \n", x)   
    fprintf("\t\t Chopper Stage Mass: %4.3f kg \n", Chopper_Stage_Mass)   
    fprintf("\t\t Rectifier Stage Mass: %4.3f kg \n", Rectifier_Stage_Mass)
    fprintf("\t\t Inverter Transformer Stage Mass: %4.3f kg \n", Inverter_Transformer_Stage_Mass)
    fprintf("\t Filter Stage Total Mass: %4.3f kg \n", Filter_Stage_Mass_Input + Filter_Stage_Mass_Output)  
    fprintf("\t\t Input Filter Stage Mass: %4.3f kg \n", Filter_Stage_Mass_Input )  
    fprintf("\t\t Output Filter Stage Mass: %4.3f kg \n", Filter_Stage_Mass_Output)  
    fprintf("\t Box Mass: %4.3f kg \n", box_Mass)
    fprintf("\t Radiator Mass: %4.3f kg \n", radiator_Mass)
    fprintf("\t DC/DC Converter Control and Monitoring Mass: %4.3f kg \n\n", DDCU_CM_Mass)
    fprintf("\t DC/DC Converter Conductor/Connector Mass: " + DDCU_CC_Mass + " kg")

    fprintf("\t DC RBI Mass: %4.3f kg \n", DRB_Mass)
    fprintf("\t DC RBI Control and Monitoring Mass: %4.3f kg \n", DRB_CM_Mass)
    % disp("DC RBI Conductor/Connector Mass: " + Conductor_Connector_Mass_DRB + " kg")
   
    %fprintf("\DC/DC Converter Elemental Parts Mass: %4.3f kg kg", x)
    
end  
    