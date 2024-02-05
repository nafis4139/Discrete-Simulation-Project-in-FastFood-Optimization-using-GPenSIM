function [png] = IMC_pdf() 

png.PN_name = 'IMC';

png.set_of_Ps = {'pIMCInBuffer', 'pIMCOutBuffer',...
    'pIMCExitCountTemp',... %temp
    };
png.set_of_Ts = {'tIMCCustDistribution', 'tIMCExit'};
png.set_of_As = {'tEntExit','pIMCInBuffer',1,...
    'pIMCInBuffer','tIMCCustDistribution',1,...
    'tIMCCustDistribution','pIMCOutBuffer',1,...
    'pIMCOutBuffer','tIMCExit',1,...
    'tIMCExit','pIMCExitCountTemp',1,... %temp
    'pIMCOutBuffer','tCEnter',1,'tCExit','pIMCInBuffer',1,... %Counter 
    'pIMCOutBuffer','tTabEnter',1,'tTabExit','pIMCInBuffer',1,... %Table
    'pIMCOutBuffer','tTEnter',1,'tTExit','pIMCInBuffer',1,... %Toilet
    'pIMCOutBuffer','tKZEnter',1,'tKZExit','pIMCInBuffer',1,... %KidsZone
    'pIMCOutBuffer','tCDEnter',1,'tCDExit','pIMCInBuffer',1,... %ChargingDock
    };
