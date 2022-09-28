function [DRB_Switchgear_Mass] = Calculate_DC_RBI_Switchgear_Mass(numRBI, F, Vin, Vout, Pout, Available_Modules, Required_Modules, DRB_efficiency, CC_Efficiency,  harnessMaterial, enclosureType, enclosureMaterial, radiatorType, maxBaseplateTemp, maxRadiatorSinkTemp, maxRadiatorBaseplateDelta, radiatorMaterial)
       
    DRB_Mass =  Calculate_DC_Remote_Bus_Isolator_Mass(Vout, Pout, Available_Modules, Required_Modules, DRB_efficiency);   
   
    Total_DRB_Mass = numRBI*DRB_Mass
    
   packaged_electronics_density = 0.222;
    
    Component_Electronics_Mass = Total_DRB_Mass;%Filter_Stage_Mass_Input + Filter_Stage_Mass_Output + Rectifier_Stage_Mass + Inverter_Transformer_Stage_Mass + Chopper_Stage_Mass;
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
    
    %add heatsink/radiator

    box_Mass = Calculate_Box_Mass(Pout, Required_Modules, CC_Length, CC_Width, CC_Height, enclosureType, enclosureMaterial);
    
    Conductor_Connector_Mass_DRB = Calculate_Conductor_Connector_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CC_Efficiency, CC_Length, CC_Width, CC_Height, harnessMaterial, enclosureType, 1) % currently not using because of unexpectedly large output
    DRB_CM_Mass = Calculate_Control_Monitoring_Mass(Available_Modules, Required_Modules, Pout, 1)
    
    Total_DRB_CM_Mass = numRBI *DRB_CM_Mass;
    Total_Conductor_Connector_Mass_DRB = numRBI*Conductor_Connector_Mass_DRB;
    
    DC_RBI_efficiency = DRB_efficiency*CC_Efficiency
    Q_DC_RBI = (1-DC_RBI_efficiency)*Pout
    Q_total =Q_DC_RBI*numRBI
    radiator_Mass = Calculate_Radiator_Mass(radiatorType, Q_total, maxBaseplateTemp, maxRadiatorSinkTemp, maxRadiatorBaseplateDelta, radiatorMaterial, CC_Length, CC_Width, CC_Height)%how do i calculate CC_L, W, H for the RBI?

    DRB_Switchgear_Mass = Total_DRB_CM_Mass + Total_DRB_Mass + Total_Conductor_Connector_Mass_DRB + box_Mass + radiator_Mass;