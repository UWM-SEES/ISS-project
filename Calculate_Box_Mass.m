function [box_Mass] = Calculate_Box_Mass(Pout, Required_Modules, CC_Length, CC_Width, CC_Height, enclosureType, enclosureMaterial)
    % box masses
    if(strcmp(enclosureType, 'FH') && strcmp(enclosureMaterial, 'Al'))
        box_Mass = 3.4*(Pout/Required_Modules)^0.3+8.1*((CC_Length*CC_Width)+2*(CC_Length*CC_Height)+2*(CC_Width*CC_Height))+44.6*(CC_Length*CC_Width); % Aluminum Finned Heat Exchanger Box Mass in kilograms
    elseif(strcmp(enclosureType, 'CP') && strcmp(enclosureMaterial, 'Al'))
        box_Mass = 0.35*(Pout/Required_Modules)^0.3+8.1*((CC_Length*CC_Width)+2*(CC_Length*CC_Height)+2*(CC_Width*CC_Height))+33.45*(CC_Length*CC_Width); % Aluminum Coldplate Based Box Mass in kilograms
    elseif(strcmp(enclosureType, 'FH') && strcmp(enclosureMaterial, 'CC'))
        box_Mass = 3.4*(Pout/Required_Modules)^0.3+5.0*((CC_Length*CC_Width)+2*(CC_Length*CC_Height)+2*(CC_Width*CC_Height))+27.3*(CC_Length*CC_Width); % Carbon-Carbon Finned Heat Exchanger Box Mass in kilograms
    elseif(strcmp(enclosureType, 'CP') && strcmp(enclosureMaterial, 'CC'))
        box_Mass = 0.35*(Pout/Required_Modules)^0.3+5.0*((CC_Length*CC_Width)+2*(CC_Length*CC_Height)+2*(CC_Width*CC_Height))+20.44*(CC_Length*CC_Width); % Carbon-Carbon Coldplate Based Box Mass in kilograms
    end
