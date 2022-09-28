function [DDCU] = Calculate_DDCU_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, FS_efficiency, FS_ripple, RS_efficiency, ITS_efficiency, CS_efficiency, CC_Efficiency, harnessMaterial, enclosureType, enclosureMaterial, radiatorType, maxBaseplateTemp, maxRadiatorSinkTemp, maxRadiatorBaseplateDelta, radiatorMaterial)
    % we probably want THIS to be in total_Mass, along with DC RBI
    % switchgear, and call smaller Calculate functions w/in here
    DDCU.Vin = Vin; 
    DDCU.Vout = Vout;
    DDCU.fsw = F;
    DDCU.Pout = Pout;
    
    DDCU.Filter_Stage_Mass_Input = Calculate_Filter_Stage_Mass(F, Vin, Pout, Available_Modules, Required_Modules, FS_efficiency, FS_ripple);
    DDCU.Filter_Stage_Mass_Output = Calculate_Filter_Stage_Mass(F, Vout, Pout, Available_Modules, Required_Modules, FS_efficiency, FS_ripple);
    DDCU.Rectifier_Stage_Mass = Calculate_Rectifier_Stage_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, RS_efficiency);
    DDCU.Inverter_Transformer_Stage_Mass = Calculate_Inverter_Transformer_Stage_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, ITS_efficiency);
    DDCU.Chopper_Stage_Mass = Calculate_Chopper_Stage_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CS_efficiency);

    DDCU.packaged_electronics_density = 0.222; % this is for FH, for CP it is 0.249
%     switch(enclosureType)
%         case 'CP'
%             packaged_electronics_density = 0.249;
%         case 'FH'
%             packaged_electronics_density = 0.222; 

    DDCU.Component_Electronics_Mass = DDCU.Filter_Stage_Mass_Input + DDCU.Filter_Stage_Mass_Output + DDCU.Rectifier_Stage_Mass + DDCU.Inverter_Transformer_Stage_Mass + DDCU.Chopper_Stage_Mass;
    DDCU.Component_Volume = DDCU.Component_Electronics_Mass/(1000*DDCU.packaged_electronics_density);
   
    switch(enclosureType)
        case 'CP'
            DDCU.CC_Length = 1.610*DDCU.Component_Volume^0.3333;
            DDCU.CC_Width = 1.043*DDCU.Component_Volume^0.3333;
            DDCU.CC_Height = 0.596*DDCU.Component_Volume^0.3333;
        case 'FH'
            DDCU.CC_Length = 1.351*DDCU.Component_Volume^0.3333;
            DDCU.CC_Width = 1.148*DDCU.Component_Volume^0.3333;
            DDCU.CC_Height = 0.646*DDCU.Component_Volume^0.3333;   
    end
    
    
    DDCU.box_Mass = Calculate_Box_Mass(Pout, Required_Modules, DDCU.CC_Length, DDCU.CC_Width, DDCU.CC_Height, enclosureType, enclosureMaterial);
    
    DDCU.efficiency = FS_efficiency^2*RS_efficiency*ITS_efficiency*CS_efficiency*CC_Efficiency;
    DDCU.Q = (1-DDCU.efficiency)*Pout;
    
    DDCU.radiator_Mass = Calculate_Radiator_Mass(radiatorType, DDCU.Q, maxBaseplateTemp, maxRadiatorSinkTemp, maxRadiatorBaseplateDelta, radiatorMaterial, DDCU.CC_Length, DDCU.CC_Width, DDCU.CC_Height);
    
    DDCU.Conductor_Connector_Mass = Calculate_Conductor_Connector_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, CC_Efficiency, DDCU.CC_Length, DDCU.CC_Width, DDCU.CC_Height, harnessMaterial, enclosureType, 2);
    % we temporarily removed Conductor_Connector mass calculations because
    % they didn't seem to give accurate numbers
    
    DDCU.CM_Mass = Calculate_Control_Monitoring_Mass(Available_Modules, Required_Modules, Pout, 0);

    
%     Q_DDCU = Pout * (1 - DDCSE); % i think
%     Pin = Pout/DDCE;
    
    DDCU.total_Mass = DDCU.Filter_Stage_Mass_Input + DDCU.Filter_Stage_Mass_Output+  DDCU.Rectifier_Stage_Mass + DDCU.Inverter_Transformer_Stage_Mass + ...
        DDCU.Chopper_Stage_Mass + DDCU.box_Mass + DDCU.radiator_Mass + DDCU.CM_Mass + DDCU.Conductor_Connector_Mass;
    
    DDCU.specific_power = Pout/DDCU.total_Mass;
    DDCU.power_density = Pout/(DDCU.Component_Volume*1000); %component volume is in m^3. 1000x converts to Liters