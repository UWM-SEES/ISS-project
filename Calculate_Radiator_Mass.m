function [Radiator_Mass] = Calculate_Radiator_Mass(Radiator_Type, Q, maxBaseplateTemp, maxRadiatorSinkTemp, maxRadiatorBaseplateDelta, radiatorMaterial)
    Radiator_Area = (1.0823E+10/Radiator_Type*Q)/((maxBaseplateTemp + 273 - maxRadiatorBaseplateDelta)^4 - maxRadiatorSinkTemp^4);
    L = 1.727; %meters %172.7; --cm
    W = 0.59;% meters %59.0; --cm
    
    switch(radiatorMaterial)
        case 'Al'
            Radiator_Mass = 22.26*(L*W) + 22.26*Radiator_Area;
        case 'CC'
            Radiator_Mass = 13.6*(L*W) + 13.6*Radiator_Area;
    end