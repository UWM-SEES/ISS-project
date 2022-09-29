function [obj] = Calculate_DC_RBI_Switchgear_Mass(numRBI, F, Vin, Vout, Pout, Available_Modules, Required_Modules, DRB_efficiency, CC_Efficiency,  harnessMaterial, enclosureType, enclosureMaterial, radiatorType, maxBaseplateTemp, maxRadiatorSinkTemp, maxRadiatorBaseplateDelta, radiatorMaterial)
       
    obj.DRB_Mass =  Calculate_DC_Remote_Bus_Isolator_Mass(Vout, Pout, Available_Modules, Required_Modules, DRB_efficiency);   
   obj.numRBI = numRBI;
   obj.Pout = Pout;
    obj.DRB_efficiency = DRB_efficiency;
    obj.CC_Efficiency = CC_Efficiency;
    obj.Total_DRB_Mass = obj.numRBI*obj.DRB_Mass
    
   obj.packaged_electronics_density = 0.222;
    
    obj.Component_Electronics_Mass = obj.Total_DRB_Mass;%Filter_Stage_Mass_Input + Filter_Stage_Mass_Output + Rectifier_Stage_Mass + Inverter_Transformer_Stage_Mass + Chopper_Stage_Mass;
    obj.Component_Volume = obj.Component_Electronics_Mass/(1000*obj.packaged_electronics_density);
   
    switch(enclosureType)
        case 'CP'
            obj.CC_Length = 1.610*obj.Component_Volume^0.3333;
            obj.CC_Width = 1.043*obj.Component_Volume^0.3333;
            obj.CC_Height = 0.596*obj.Component_Volume^0.3333;
        case 'FH'
            obj.CC_Length = 1.351*obj.Component_Volume^0.3333;
            obj.CC_Width = 1.148*obj.Component_Volume^0.3333;
            obj.CC_Height = 0.646*obj.Component_Volume^0.3333;   
    end
    
    %add heatsink/radiator

    obj.box_Mass = Calculate_Box_Mass(Pout, Required_Modules, obj.CC_Length, obj.CC_Width, obj.CC_Height, enclosureType, enclosureMaterial);
    
    obj.Conductor_Connector_Mass_DRB = Calculate_Conductor_Connector_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CC_Efficiency, obj.CC_Length, obj.CC_Width, obj.CC_Height, harnessMaterial, enclosureType, 1) % currently not using because of unexpectedly large output
    obj.DRB_CM_Mass = Calculate_Control_Monitoring_Mass(Available_Modules, Required_Modules, Pout, 1)
    
    obj.Total_DRB_CM_Mass = obj.numRBI *obj.DRB_CM_Mass;
    obj.Total_Conductor_Connector_Mass_DRB = obj.numRBI*obj.Conductor_Connector_Mass_DRB;
    
    obj.DC_RBI_efficiency = obj.DRB_efficiency*obj.CC_Efficiency
    obj.Q_DC_RBI = (1-obj.DC_RBI_efficiency)*Pout
    obj.Q_total =obj.Q_DC_RBI*obj.numRBI
    obj.radiator_Mass = Calculate_Radiator_Mass(radiatorType, obj.Q_total, maxBaseplateTemp, maxRadiatorSinkTemp, maxRadiatorBaseplateDelta, radiatorMaterial, obj.CC_Length, obj.CC_Width, obj.CC_Height)%how do i calculate CC_L, W, H for the RBI?

    obj.DRB_Switchgear_Mass = obj.Total_DRB_CM_Mass + obj.Total_DRB_Mass + obj.Total_Conductor_Connector_Mass_DRB + obj.box_Mass + obj.radiator_Mass;
    obj.specific_power = obj.Pout/obj.DRB_Switchgear_Mass;
    obj.Box_Volume_liters = obj.Component_Volume*1000;
    obj.power_density = obj.Pout/obj.Box_Volume_liters;