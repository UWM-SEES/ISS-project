% creating and assigning variables

%Hello World
%% CHOPPER STAGE MODEL
% CSM_1; % single-phase chopper stage mass
% CSM_3; % three-phase chopper stage mass
CSE = .976; % chopper stage efficiency
CSE_range = [.968: .002: .984];
CSAM = 1; % Chopper Stage Available Modules
CSRM = 1; % Chopper Stage Required Modules
CSVi = 120; % Chopper Stage Voltage Input (Vdc)
CSF = 40; % Chopper Stage Frequency (kHz)
CSF_range = [10: 5: 70];
CSPo_range = [0: 5: 250];
LCSVi_range = [20: 10: 120];
HCSVi_range = [500:500:10000];

CSPo = 100; % Chopper Stage Power Output (kWe) 

CSM_mass_coefficient = 0.645; % mass coefficient

CSM_efficiency_factor = exp(0.01./(1-CSE))/1.5169;

CSM_redundancy_factor = CSAM/CSRM;

CSM_power_level_multiplier = CSPo;

CSM_power_level_factor = (CSPo/CSRM)^(-0.065);

CSM_voltage_level_factors = (CSVi/(CSVi-2))^7 * exp(CSVi/40000);

CSM_frequency_factors = (20/CSF)^0.45 * exp(CSPo^0.1 * CSF/200);


% CSM_1 = 0.645 * exp(0.01/(1-CSE))/1.5169 * CSPo * (CSPo/CSRM)^(-0.065) ...
% * (CSVi/(CSVi-2))^7 * exp(CSVi/40000) * (20/CSF)^0.45 ...
% * exp(CSPo^0.1 * CSF/200); % for reference

% for specific plots
CSM_efficiency_factor_range = exp(0.01./(1-CSE_range))./1.5169;
CSM_frequency_factors_range = (20./CSF_range).^0.45 .* exp(CSPo^0.1 .* CSF_range./200); % is this right
CSM_power_level_factor_range = (CSPo_range./CSRM).^(-0.065);
CSM_power_level_multiplier_range = CSPo_range;
CSM_power_frequency_range = (20./CSF).^0.45 * exp(CSPo_range.^0.1 .* CSF./200);
CSM_LV_level_factors_range = (LCSVi_range./(LCSVi_range-2)).^7 .* exp(LCSVi_range./40000);
CSM_HV_level_factors_range = (HCSVi_range./(HCSVi_range-2)).^7 .* exp(HCSVi_range./40000);

% p, v, fsw, n
CSM_1_efficiency = CSM_mass_coefficient .* CSM_efficiency_factor_range .* CSM_power_level_multiplier ...
    .* CSM_power_level_factor .* CSM_voltage_level_factors .* CSM_frequency_factors...
    .* CSM_redundancy_factor;

CSM_1_power = CSM_mass_coefficient .* CSM_efficiency_factor .* CSM_power_level_multiplier_range ...
    .* CSM_power_level_factor_range .* CSM_voltage_level_factors .* CSM_frequency_factors ...
    .* CSM_redundancy_factor;

CSM_1_frequency = CSM_mass_coefficient .* CSM_efficiency_factor .* CSM_power_level_multiplier ...
    .* CSM_power_level_factor .* CSM_voltage_level_factors .* CSM_frequency_factors_range...
    .* CSM_redundancy_factor;

CSM_1_LV = CSM_mass_coefficient .* CSM_efficiency_factor .* CSM_power_level_multiplier ...
    .* CSM_power_level_factor .* CSM_LV_level_factors_range .* CSM_frequency_factors...
    .* CSM_redundancy_factor;

CSM_1_HV = CSM_mass_coefficient .* CSM_efficiency_factor .* CSM_power_level_multiplier ...
    .* CSM_power_level_factor .* CSM_HV_level_factors_range .* CSM_frequency_factors...
    .* CSM_redundancy_factor;

fig1 = figure(1); clf;

plot(CSE_range, CSM_1_efficiency./CSPo, '.--', 'MarkerSize', 20, 'LineWidth', 1) %works!
title('Figure 1: Chopper SPWT vs Efficiency');
xlabel('Efficiency');
ylabel('kg/kWe');
grid on; hold on;

figure(2)

plot(CSPo_range, CSM_1_power./CSPo_range, '.--', 'MarkerSize', 20, 'LineWidth', 1) % works!
title('Figure 2: Chopper SPWT vs Power Level');
xlabel('Power (kWe)');
ylabel('kg/kWe');
grid on; hold on;

figure(4)

plot(LCSVi_range, CSM_1_LV./CSPo, '.--', 'MarkerSize', 20, 'LineWidth', 1) % sorta in the range
title('Figure 4: Chopper SPWT vs Voltage- Low Voltage Region'); % should I stick to the figure numbers in the article?
xlabel('Input Voltage (Vdc)');
ylabel('kg/kWe');
grid on; hold on;

figure(5)

plot(HCSVi_range, CSM_1_HV./CSPo, '.--', 'MarkerSize', 20, 'LineWidth', 1) % works!
title('Figure 5: Chopper SPWT vs Voltage- High Voltage Region');
xlabel('Input Voltage (Vdc)');
ylabel('kg/kWe');
grid on; hold on;

figure(6)
plot(CSF_range, CSM_1_frequency./CSPo, '.--', 'MarkerSize', 20, 'LineWidth', 1) %works!
title('Figure 6: Chopper SPWT vs Frequency');
xlabel('Frequency (kHz)');
ylabel('kg/kWe');
grid on; hold on;


% legend('$10kWe$', 'interpreter', 'latex')
% fig1.CurrentAxes.FontWeight = 'bold'
% fig1.CurrentAxes.FontSize = 14
% fig1.CurrentAxes.GridAlpha = 0.5

%% INVERTER TRANSFORMER STAGE MODEL
% ITSM_1; % Single-Phase Inverter Transformer Stage Mass
% ITSM_3; % 3-Phase Inverter Transformer Stage Mass
ITSE = .992; % Inverter Transformer Stage Efficiency
ITSAM = 1; % Inverter Transformer Stage Available Modules
ITSRM = 1; % Inverter Transformer Stage Required Modules
ITSPo = 100; % Inverter Transformer Stage Power Output (kWe)
ITSVi = 120; % Inverter Transformer Stage Voltage Input (Vrms)
ITSVo = 120; % Inverter Transformer Stage Voltage Output (Vrms)
ITSF = 20; % Inverter Transformer Stage Frequency (kHz)

% ranges for plots
ITSE_range = [.986: .001: .996];
ITSPo_range = [10:10:250];
ITSV_range = [0:1000:10000];
ITSF_range = [5:10:95]; % wide or narrow range?

%FIX
ITSM_mass_coefficient = 1.27;
ITSM_efficiency_factor = (exp(0.0048/(1-ITSE)))/1.8221;
ITSM_redundancy_factor = ITSAM/ITSRM;
ITSM_power_level_multiplier = ITSPo;
ITSM_power_level_factor = (ITSPo/ITSRM)^(-0.08);
ITSM_voltage_level_factors = exp(ITSVi/200000)*exp(ITSVo/200000);
ITSM_frequency_level_factors = (ITSF)^(-0.47) + (ITSF/300)^1.4 - ...
    (200/ITSPo)^0.03 * ((max(0, ITSF-30))/300)^1.7;


% ITSM_1 = 1.27*((exp(0.0048/(1-ITSE)))/1.8221) * (ITSAM/ITSRM) * ITSPo ...
%     * (ITSPo/ITSRM)^(-0.08)*exp(ITSVi/200000)*exp(ITSVo/200000)...
%     * (ITSF)^(-0.47) + (ITSF/300)^1.4 - (200/ITSPo)^0.03 ...
%     * ((max(0, ITSF-30)/300)^1.7); % for reference

ITSM_1 = ITSM_mass_coefficient * ITSM_efficiency_factor...
    * ITSM_redundancy_factor * ITSM_power_level_multiplier ...
    * ITSM_power_level_factor * ITSM_voltage_level_factors ...
    * ITSM_frequency_level_factors;

ITSM_efficiency_factor_range = (exp(0.0048./(1-ITSE_range)))./1.8221;
ITSM_power_level_factor_range = (ITSPo_range./ITSRM).^(-0.08);
ITSM_voltage_level_factors_range = exp(ITSV_range./200000).*exp(ITSV_range./200000);
ITSM_power_level_multiplier_range = ITSPo_range;
ITSM_frequency_level_factors_range = (ITSF_range).^(-0.47) + (ITSF_range./300).^1.4 - ...
    (200/ITSPo).^0.03 * ((max(0, ITSF_range-30))./300).^1.7;

ITSM_1_efficiency = ITSM_mass_coefficient .* ITSM_efficiency_factor_range...
    .* ITSM_redundancy_factor .* ITSM_power_level_multiplier ...
    .* ITSM_power_level_factor .* ITSM_voltage_level_factors ...
    .* ITSM_frequency_level_factors;
ITSM_1_power = ITSM_mass_coefficient .* ITSM_efficiency_factor...
    .* ITSM_redundancy_factor .* ITSM_power_level_multiplier_range ...
    .* ITSM_power_level_factor_range .* ITSM_voltage_level_factors ...
    .* ITSM_frequency_level_factors;
ITSM_1_voltage = ITSM_mass_coefficient .* ITSM_efficiency_factor...
    .* ITSM_redundancy_factor .* ITSM_power_level_multiplier ...
    .* ITSM_power_level_factor .* ITSM_voltage_level_factors_range ...
    .* ITSM_frequency_level_factors;
ITSM_1_frequency = ITSM_mass_coefficient .* ITSM_efficiency_factor...
    .* ITSM_redundancy_factor .* ITSM_power_level_multiplier ...
    .* ITSM_power_level_factor .* ITSM_voltage_level_factors ...
    .* ITSM_frequency_level_factors_range;


figure(8)

plot(ITSE_range, ITSM_1_efficiency./ITSPo, '.--', 'MarkerSize', 20, 'LineWidth', 1) %works!
title('Figure 8: Inverter Transformer SPWT vs Efficiency');
xlabel('Efficiency');
ylabel('kg/kWe');
grid on; hold on;

figure(10)

plot(ITSPo_range, ITSM_1_power./ITSPo_range, '.--', 'MarkerSize', 20, 'LineWidth', 1) % works!
title('Figure 10: Inverter Transformer SPWT vs Power');
xlabel('Output Power (kWe)');
ylabel('kg/kWe');
grid on; hold on;

figure(12)

plot(ITSV_range, ITSM_1_voltage./ITSPo, '.--', 'MarkerSize', 20, 'LineWidth', 1) % works!
title('Figure 12: Inverter Transformer SPWT vs Voltage');
xlabel('Input or Output Voltage Level (Vrms)');
ylabel('kg/kWe');
grid on; hold on;

figure(14)

plot(ITSF_range, ITSM_1_frequency./ITSPo, '.--', 'MarkerSize', 20, 'LineWidth', 1) %works!
title('Figure 14: Inverter Transformer SPWT vs Frequency');
xlabel('Frequency (kHz)');
ylabel('kg/kWe');
grid on; hold on;

%% RECTIFIER STAGE MODEL

RSE = 0.987; % Rectifier Stage Efficiency
RSAM = 1; % Rectifier Stage Available Modules
RSRM = 1; % Rectifier Stage Required Modules
RSPo = 100; % Rectifier Stage Power Output (kWe)
RSVi = 120; % Rectifier Stage Voltage Input (Vrms)

RSPo_range = [10:10:250];
RSE_range = [0.983:0.001:0.991];
RSVi_range = [20:10:120];


RSM_mass_coefficient = 0.1175;
RSM_efficiency_factor = ((exp(0.005/(1-RSE)))/1.469);
RSM_redundancy_factor = RSAM/RSRM;
RSM_power_level_multiplier = RSPo;
RSM_voltage_level_factors = (RSVi/(RSVi-2))^6;


RSM_efficiency_factor_range = exp(0.005./(1-RSE_range))./1.469;
RSM_voltage_level_factors_range = (RSVi_range./(RSVi_range-2)).^6;
RSM_power_level_multiplier_range = RSPo_range;

RSM_1 = RSM_mass_coefficient * RSM_efficiency_factor * RSM_redundancy_factor...
    * RSM_power_level_multiplier * RSM_voltage_level_factors;

RSM_1_efficiency = RSM_mass_coefficient .* RSM_efficiency_factor_range .* RSM_redundancy_factor...
    .* RSM_power_level_multiplier .* RSM_voltage_level_factors;

RSM_1_power = RSM_mass_coefficient .* RSM_efficiency_factor .* RSM_redundancy_factor...
    .* RSM_power_level_multiplier_range .* RSM_voltage_level_factors;

RSM_1_voltage = RSM_mass_coefficient .* RSM_efficiency_factor .* RSM_redundancy_factor...
    .* RSM_power_level_multiplier .* RSM_voltage_level_factors_range; % slightly off at the smaller voltages

figure(15)

plot(RSPo_range, RSM_1_power./RSPo_range, '.--', 'MarkerSize', 20, 'LineWidth', 1) % works!
title('Figure 15: Rectifier SPWT');
xlabel('Power (kWe)');
ylabel('kg/kWe');
ylim([0 0.5]);
grid on; hold on;

figure(16)

plot(RSE_range, RSM_1_efficiency./RSPo, '.--', 'MarkerSize', 20, 'LineWidth', 1) %works!
title('Figure 16: Rectifier SPWT vs Efficiency');
xlabel('Efficiency');
ylabel('kg/kWe');
grid on; hold on;

figure(17)

plot(RSVi_range, RSM_1_voltage./RSPo, '.--', 'MarkerSize', 20, 'LineWidth', 1) % works!
title('Figure 17: Rectifier SPWT vs Low Voltages');
xlabel('Input Voltage (Vrms)');
ylabel('kg/kWe');
grid on; hold on;


% started 3d plot things!
% figure(31)
% plot3(RSVi_range, RSM_1_voltage./RSPo, RSM_1_voltage./RSE, '.--', 'MarkerSize', 20, 'LineWidth', 1);
% title('Figure 31: Rectifier SPWT vs Efficiency vs Low Voltages');
% xlabel('Input Voltage (Vrms)');
% ylabel('kg/kWe');
% zlabel('Efficiency');
% grid on; hold on;

%% DC FILTER STAGE MODEL

FSRF = 0.004; % Dc Filter Stage Ripple Factor (0.1 to 5%)
FSE = 0.998;% Dc Filter Stage Efficiency (99.8%)
FSAM = 1; % Dc Filter Stage Available Modules
FSRM = 1; % Dc Filter Stage Required Modules
FSPo = 100; % Dc Filter Stage Power Output (kWe)
FSVo = 120; % Dc Filter Stage Voltage Output (Vdc)
FSF = 40; % Dc Filter Stage Frequency (kHz)

FSRF_range = [0.001:0.001:0.020];
FSE_range = [0.997: 0.0002:0.999];
FSPo_range = [10:10:200];
FSLVo_range = [20:10:120];
FSHVo_range = [100:500:10000];
FSF_range = [5:5:100];


FSM_mass_coefficient = 22.05;
FSM_ripple_factor = (1/(FSRF/0.01)^0.5);
FSM_efficiency_factor = ((1-0.998)/(1-FSE));
FSM_redundancy_factor = (FSAM/FSRM);
FSM_power_level_multiplier = FSPo;
FSM_voltage_level_factors = (FSVo^(-0.9) + 0.000015);
FSM_frequency_factor = 40/FSF;

FSM_ripple_factor_range = (1./(FSRF_range./0.01).^0.5);
FSM_efficiency_factor_range = ((1-0.998)./(1-FSE_range));
FSM_power_level_multiplier_range = FSPo_range;
FSM_frequency_factor_range = 40./FSF_range;
FSM_HV_level_factors_range = FSHVo_range.^(-0.9) + 0.000015;
FSM_LV_level_factors_range = FSLVo_range.^(-0.9) + 0.000015;

FSM_1 = FSM_mass_coefficient * FSM_ripple_factor * FSM_efficiency_factor...
    * FSM_redundancy_factor * FSM_power_level_multiplier * FSM_voltage_level_factors...
    * FSM_frequency_factor;

FSM_1_ripple = FSM_mass_coefficient .* FSM_ripple_factor_range .* FSM_efficiency_factor...
    .* FSM_redundancy_factor .* FSM_power_level_multiplier .* FSM_voltage_level_factors...
    .* FSM_frequency_factor;

FSM_1_efficiency = FSM_mass_coefficient .* FSM_ripple_factor .* FSM_efficiency_factor_range...
    .* FSM_redundancy_factor .* FSM_power_level_multiplier .* FSM_voltage_level_factors...
    .* FSM_frequency_factor;

FSM_1_HV = FSM_mass_coefficient .* FSM_ripple_factor .* FSM_efficiency_factor...
    .* FSM_redundancy_factor .* FSM_power_level_multiplier .* FSM_HV_level_factors_range...
    .* FSM_frequency_factor;

FSM_1_LV = FSM_mass_coefficient .* FSM_ripple_factor .* FSM_efficiency_factor...
    .* FSM_redundancy_factor .* FSM_power_level_multiplier .* FSM_LV_level_factors_range...
    .* FSM_frequency_factor;

FSM_1_power = FSM_mass_coefficient .* FSM_ripple_factor .* FSM_efficiency_factor...
    .* FSM_redundancy_factor .* FSM_power_level_multiplier_range .* FSM_voltage_level_factors...
    .* FSM_frequency_factor;

FSM_1_frequency = FSM_mass_coefficient .* FSM_ripple_factor .* FSM_efficiency_factor...
    .* FSM_redundancy_factor .* FSM_power_level_multiplier .* FSM_voltage_level_factors...
    .* FSM_frequency_factor_range;

figure(18)

plot(FSRF_range, FSM_1_ripple./FSPo, '.--', 'MarkerSize', 20, 'LineWidth', 1) % works!
title('Figure 18: DC Filter SPWT vs Ripple Factor');
xlabel('Required Ripple Factor');
ylabel('kg/kWe');
grid on; hold on;

figure(19)

plot(FSE_range, FSM_1_efficiency./FSPo, '.--', 'MarkerSize', 20, 'LineWidth', 1) %works!
title('Figure 19: DC Filter SPWT vs Efficiency');
xlabel('Efficiency');
ylabel('kg/kWe');
grid on; hold on;

figure(20)

plot(FSPo_range, FSM_1_power./FSPo_range, '.--', 'MarkerSize', 20, 'LineWidth', 1) % works!
title('Figure 20: DC Filter SPWT vs Power');
xlabel('Power (kWe)');
ylabel('kg/kWe');
ylim([0 1])
grid on; hold on;

figure(21)

plot(FSLVo_range, FSM_1_LV./FSPo, '.--', 'MarkerSize', 20, 'LineWidth', 1) % works!
title('Figure 21: DC Filter SPWT vs Voltage - Low Voltage Region');
xlabel('Output Voltage (Vdc)');
ylabel('kg/kWe');
grid on; hold on;

figure(22)

plot(FSHVo_range, FSM_1_HV./FSPo, '.--', 'MarkerSize', 20, 'LineWidth', 1) % works!
title('Figure 22: DC Filter SPWT vs Voltage - High Voltage Region');
xlabel('Output Voltage (Vdc)');
ylabel('kg/kWe');
grid on; hold on;

figure(23)

plot(FSF_range, FSM_1_frequency./FSPo, '.--', 'MarkerSize', 20, 'LineWidth', 1) %works!
title('Figure 23: DC Filter SPWT vs Frequency');
xlabel('Frequency(kHz)');
ylabel('kg/kWe');
grid on; hold on;


%% DC RBI STAGE MODEL
DRBE = 0.9985; % DC RBI Efficiency
DRBAM = 1; % Dc RBI Available Modules
DRBRM = 1; % Dc RBI Required Modules
DRBPo = 100; % Dc RBI Power Output (kWe)
DRBVo = 120; % Dc RBI Voltage Output (Vdc)

DRBE_range = [0.9980:0.0001: 0.9990];
DRBPo_range = [5:10:250];
DRBVo_range = [0:1000:10000];

DRBM_mass_coefficient = 0.12;
DRBM_efficiency_factor = ((exp(0.0008/(1-DRBE)))/1.7);
DRBM_redundancy_factor = DRBAM/DRBRM;
DRBM_power_level_multiplier = DRBPo;
DRBM_power_level_factor = (DRBPo/DRBRM)^(-0.15);
DRBM_voltage_level_factor = (DRBVo/200)^0.13;

DRBM_efficiency_factor_range = (exp(0.0008./(1-DRBE_range)))./1.7;
DRBM_power_level_factor_range = (DRBPo_range./DRBRM).^(-0.15);
DRBM_power_level_multiplier_range = DRBPo_range;
DRBM_voltage_level_factor_range = (DRBVo_range./200).^0.13;


DRBM = DRBM_mass_coefficient * DRBM_efficiency_factor * DRBM_redundancy_factor...
    * DRBM_power_level_multiplier * DRBM_power_level_factor ...
    * DRBM_voltage_level_factor;

DRBM_efficiency = DRBM_mass_coefficient .* DRBM_efficiency_factor_range .* DRBM_redundancy_factor...
    .* DRBM_power_level_multiplier .* DRBM_power_level_factor ...
    .* DRBM_voltage_level_factor;

DRBM_power = DRBM_mass_coefficient .* DRBM_efficiency_factor .* DRBM_redundancy_factor...
    .* DRBM_power_level_multiplier_range .* DRBM_power_level_factor_range ...
    .* DRBM_voltage_level_factor;

DRBM_voltage = DRBM_mass_coefficient .* DRBM_efficiency_factor .* DRBM_redundancy_factor...
    .* DRBM_power_level_multiplier .* DRBM_power_level_factor ...
    .* DRBM_voltage_level_factor_range;

% plotting

figure(28)

plot(DRBE_range, DRBM_efficiency./DRBPo, '.--', 'MarkerSize', 20, 'LineWidth', 1) %works!
title('Figure 28: DC RBI SPWT vs Efficiency');
xlabel('Efficiency');
ylabel('kg/kWe');
grid on; hold on;

figure(29)

plot(DRBPo_range, DRBM_power./DRBPo_range, '.--', 'MarkerSize', 20, 'LineWidth', 1) % works!
title('Figure 29: DC RBI SPWT vs Power');
xlabel('Power (kWe)');
ylabel('kg/kWe');
grid on; hold on;

figure(30)

plot(DRBVo_range, DRBM_voltage./DRBPo, '.--', 'MarkerSize', 20, 'LineWidth', 1) % works!
title('Figure 30: DC RBI SPWT vs Voltage');
xlabel('Output Voltage (Vdc)');
ylabel('kg/kWe');
grid on; hold on;


%% CONDUCTOR AND CONNECTOR EQUATIONS

CCCE = 0.9998; %Component Efficiency- made up
CCAM = 1; % Available Modules
CCRM = 1; % Required Modules
CCPo = 100; % Power Output (kWe)
CCVi = 120; % Voltage Input (VrmsLL or Vdc)
CCVo = 120; % Voltage Output (VrmsLL or Vdc)
CCEL = 5; % Packaged Electronics Length (meters)
CCEW = 5; % Packaged Electronics Width (meters)
CCEH = 5; % Packaged Electronics Height (meters)
% 
% CC_redundancy_factor = CCAM/CCRM;
% CC_power_conductor_equation_segment = 29.3*(0.5*(CCEL + CCEW) + CCEH) * ...
%     ((CCPo/CCCE/CCVi) + (CCPo/CCVo));
% CC_control_monitoring_cable_harness_equation_segment = 5.22*(0.5*(CCEL + CCEW) + CCEH);
% CC_power_control_monitoring_connector_equation_segments = 0.238*(CCPo/CCRM)^0.1 + ...
%     0.2667*(CCPo/CCRM)^0.5; % this will not work since we are adding
%     things


CCM = (CCAM/CCRM) * 29.3 * (0.5*(CCEL + CCEW) + CCEH)*((CCPo/CCCE/CCVi) + ...
    (CCPo/CCVo)) + CCAM *(5.22*(0.5*(CCEL + CCEW) + CCEH) + 0.238*(CCPo/CCRM)^0.1 + ...
    0.2667*(CCPo/CCRM)^0.5);

%% BASEPLATE/HEAT EXCHANGER/OTHER STUFF
enclosureType = 'FH';
enclosureMaterial = 'Al';
radiatorMaterial = 'Al';
harnessMaterial = 'Cu';
radiatorType = 2;
maxRadiatorSinkTemp = 294;
maxBaseplateTemp = 63;
if(strcmp(enclosureType, 'FH'))
    maxRadiatorBaseplateDelta = 11;
else
    maxRadiatorBaseplateDelta = 4;
end
