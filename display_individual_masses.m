function [] = display_individual_masses(Filter_Stage_Mass, Rectifier_Stage_Mass, Inverter_Transformer_Stage_Mass, Chopper_Stage_Mass, box_Mass, DRB_Mass, DDCU_CM_Mass, DRB_CM_Mass)
    disp("Filter Stage Mass: " + Filter_Stage_Mass + " kg")
    disp("Rectifier Stage Mass: " + Rectifier_Stage_Mass + " kg")
    disp("Inverter Transformer Stage Mass: " + Inverter_Transformer_Stage_Mass + " kg")
    disp("Chopper Stage Mass: " + Chopper_Stage_Mass + " kg")
    disp("Box Mass: " + box_Mass + " kg")
    disp("Inverter Transformer Stage Mass: " + Inverter_Transformer_Stage_Mass + " kg")
    disp("DC RBI Switchgear Mass: " + DRB_Mass + " kg")
    disp("DC RBI Control and Monitoring Mass: " + DRB_CM_Mass + " kg")
    % disp("DC RBI Conductor/Connector Mass: " + Conductor_Connector_Mass_DRB + " kg")
    x = Rectifier_Stage_Mass + Chopper_Stage_Mass + Inverter_Transformer_Stage_Mass;
    disp("DC/DC Converter Elemental Parts Mass: " + x + " kg")
    disp("DC/DC Converter Control and Monitoring Mass: " + DDCU_CM_Mass + " kg")
    % disp("DC/DC Converter Conductor/Connector Mass: " + Conductor_Connector_Mass_DDCU + " kg")
    
    