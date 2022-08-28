% % poll user for switching frequency
% F = input('What is the switching frequency? (kHz) ');
% if gt(F, 100) || lt(F, 10)
%     error('Outside of range');
% end
% 
% % poll user for input voltage
% Vin = input('What is the input voltage? (Vdc) ');
% if gt(Vin, 10000) || lt(Vin, 20)
%     error('Outside of range');
% end
% 
% % poll user for output voltage
% Vout = input('What is the output voltage? (Vdc) ');
% if gt(Vout, 10000) || lt(Vout, 20)
%     error('Outside of range');
% end
% 
% % poll user for output power
% Pout = input('What is the output power? (kWe) ');
% if lt(Pout, 0.5) || gt(Pout, 250)
%     error('Outside of range');
% end
% 
% % poll user for available modules
% Available_Modules = input('How many available modules are there? ');
% if lt(Available_Modules, 1) || gt(Available_Modules, 5)
%     error('Outside of range');
% end
% 
% % poll user for required modules
% Required_Modules = input('How many required modules are there? ');
% if lt(Required_Modules, 1) || gt(Required_Modules, 5) || gt(Required_Modules, Available_Modules)
%     error('Outside of range');
% end
% 
% % poll user for DRB efficiency
% DRB_efficiency = input('What is the DC RBI efficiency? (0.998-0.999) ');
% if lt(DRB_efficiency, 0.998) || gt(DRB_efficiency, 0.999)
%     error('Outside of range');
% end
% 
% % poll user for FS efficiency
% FS_efficiency = input('What is the DC filter efficiency? (0.997-0.999) ');
% if lt(FS_efficiency, 0.997) || gt(FS_efficiency, 0.999)
%     error('Outside of range');
% end
% 
% % poll user for FS ripple factor
% FS_ripple = input('What is the DC filter ripple factor? (0.001-0.05) ');
% if lt(FS_ripple, 0.001) || gt(FS_ripple, 0.05)
%     error('Outside of range');
% end
% 
% % poll user for RS efficiency
% RS_efficiency = input('What is the rectifier efficiency? (0.983-0.991) ');
% if lt(RS_efficiency, 0.983) || gt(RS_efficiency, 0.991)
%     error('Outside of range');
% end
% 
% % poll user for ITS efficiency
% ITS_efficiency = input('What is the inverter transformer efficiency? (0.986-0.996) ');
% if lt(ITS_efficiency, 0.986) || gt(ITS_efficiency, 0.996)
%     error('Outside of range');
% end
% 
% % poll user for CS efficiency
% CS_efficiency = input('What is the chopper efficiency? (0.968-0.984) ');
% if lt(CS_efficiency, 0.968) || gt(CS_efficiency, 0.984)
%     error('Outside of range');
% end
% 
% % poll user for conductor/connector efficiency
% CC_efficiency = input('What is the conductor efficiency? ');
% if lt(CC_efficiency, 0.968) || gt(CC_efficiency, 0.984)
%     error('Outside of range');
% end
% 
% % poll user for packaged electronics length--not needed!!!!
% CC_L = input('What is the packaged electronics length? (meters) ');
% if lt(CC_L, 0)
%     error('Outside of range')
% end
% 
% % poll user for packaged electronics width
% CC_W = input('What is the packaged electronics width? (meters) ');
% if lt(CC_W, 0)
%     error('Outside of range')
% end
% 
% % poll user for packaged electronics height
% CC_H = input('What is the packaged electronics height? (meters) ');
% if lt(CC_H, 0)
%     error('Outside of range')
% end
% 
% % poll user for enclosure/baseplate type
% enclosureType = input('What is the box type used for the enclosure/baseplate design? (FH for finned heat exchanger, CP for coldplate) ');
% if ~(strcmp(enclosureType, 'FH')) && ~(strcmp(enclosureType, 'CP'))
%     error('Unavailable')
% end
% 
% % poll user for enclosure/baseplate material
% enclosureMaterial = input('What is the material used for the enclosure/baseplate? (Al for aluminum, CC for carbon-carbon) ');
% if ~(strcmp(enclosureMaterial, 'Al')) && ~(strcmp(enclosureMaterial, 'CC'))
%     error('Unavailable')
% end
% 
% % poll user for coldplate/radiator material
% radiatorMaterial = input('What is the material used for the coldplate/radiator? (Al for aluminum, CC for carbon-carbon) ');
% if ~(strcmp(radiatorMaterial, 'Al')) && ~(strcmp(radiatorMaterial, 'CC'))
%     error('Unavailable')
% end
% 
% % poll user for control and monitoring harness material
% harnessMaterial = input('What is the material used for the control and monitoring harness? (FO for fiber optic, Cu for copper) ');
% if ~(strcmp(harnessMaterial, 'FO')) && ~(strcmp(harnessMaterial, 'Cu'))
%     error('Unavailable')
% end
% 
% % poll user for radiator type
% radiatorType = input('Single or two sided radiator? (1 for single, 2 for two sided)');
% if radiatorType ~= 1 && radiatorType ~= 2
%     error('Outside of range')
% end
% 
% % poll user for maximum radiator sink temperature
% maxRadiatorSinkTemp = input('What is the maximum radiator sink temperature? (K) ');
% if gt(maxRadiatorSinkTemp, 300) || lt(maxRadiatorSinkTemp, 200)
%     error('Outside of range')
% end
% 
% % poll user for maximum baseplate temperature
% maxBaseplateTemp = input('What is the maximum baseplate temperature? (C) ');
% if gt(maxBaseplateTemp, -30) || lt(maxBaseplateTemp, 65)
%     error('Outside of range')
% end
% 
% % poll user for maximum baseplate radiator delta
% maxRadiatorBaseplateDelta = input('What is the maximum temperature difference between the baseplate and radiator? ');
% if gt(maxRadiatorBaseplateDelta, 20) || lt(maxRadiatorBaseplateDelta, 3)
%     error('Outside of range')
% end

% default values
F = 40;
Vin = 120;
Vout = 4500;
Pout = 8.0;
Available_Modules = 1;
Required_Modules = 1;
DRB_efficiency = 0.9985;
FS_efficiency = 0.9980;
FS_ripple = 0.004;
RS_efficiency = 0.9870;
ITS_efficiency = 0.9920;
CS_efficiency = 0.9760;
CC_efficiency = 0.9980;
% CC_L = 5;
% CC_H = 5;
% CC_W = 5;
enclosureType = 'FH';
enclosureMaterial = 'Al';
radiatorMaterial = 'Al';
harnessMaterial = 'Cu';
radiatorType = 2;
maxRadiatorSinkTemp = 294;
maxBaseplateTemp = 63;
radiatorBaseplateDelta = maxRadiatorSinkTemp-275-maxBaseplateTemp;

if(strcmp(enclosureType, 'FH'))
    maxRadiatorBaseplateDelta = 11;
else
    maxRadiatorBaseplateDelta = 4;
end

if gt(radiatorBaseplateDelta, maxRadiatorBaseplateDelta)
    error('out of range')
end
    
% Q = Pout * (1 - DRB_efficiency); % heat in kWT
Q = 290/1000;

% calculate densities-- assumed DC/DC Converter-Internal
CP_density = 0.404;
FH_density = 0.250;
    
low_v  = [20:10:120];
% polyfit for chopper efficiency at low voltages
chopper_e = [.9360 .9600 .9667 .9700 .9723 .9736 .9747 .9753 .9757 .9760 .9760]; %the .9757 says .9557 but that seems wrong
polyfit_chopper = polyfit(low_v, chopper_e, 3);
chopper_lowV_efficiency = polyval(Vin, polyfit_chopper);
% polyfit for rectifier efficiency at low voltages
rectifier_e = [.9670 .9795 .9820 .9838 .9850 .9856 .9862 .9866 .9868 .9870 .9870];
polyfit_rectifier = polyfit(low_v, rectifier_e, 3);
rectifier_lowV_efficiency = polyval(Vin, polyfit_rectifier);

% par 4.3, 4.4, 4.5

mass_total = Calculate_Total_Mass(F, Vin, Vout, Pout, Available_Modules, Required_Modules, DRB_efficiency, FS_efficiency, FS_ripple, RS_efficiency, ITS_efficiency, CS_efficiency, CC_efficiency, harnessMaterial, enclosureType, enclosureMaterial, radiatorMaterial, Q, radiatorType, maxRadiatorSinkTemp, maxBaseplateTemp, maxRadiatorBaseplateDelta);
%disp(mass_total);