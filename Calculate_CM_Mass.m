function [CM_Mass] = Calculate_CM_Mass(Available_Modules, Required_Modules, Pout)
    CM_Power = Available_Modules*43.3*(Pout/Required_Modules)^0.1;
    CM_Mass=Available_Modules*(1.2+0.158*(Pout/Required_Modules)^0.5)+70*0.75*1.1*CM_Power;

    
    
    
