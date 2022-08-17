function [Radiator_Mass] = Calculate_Radiator_Mass(Radiator_Type, Q, maxBaseplateTemp, maxRadiatorSinkTemp, maxRadiatorBaseplateDelta, radiatorMaterial, CC_Length, CC_Width, CC_Height)
    Radiator_Area = (1.0823E+10/Radiator_Type*Q)/((maxBaseplateTemp + 273 - maxRadiatorBaseplateDelta)^4 - maxRadiatorSinkTemp^4);
%     L = 172.7;
%     W = 59.0;
    
    switch(radiatorMaterial)
        case 'Al'
            Radiator_Mass = (22.26*(CC_Length*CC_Width) + 22.26*Radiator_Area)/1000;
        case 'CC'
            Radiator_Mass = (13.6*(CC_Length*CC_Width) + 13.6*Radiator_Area)/1000;
    end