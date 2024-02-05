function [png] = Chargingdock_pdf()
global global_info

png.PN_name='Chargingdock';

png.set_of_Ps={'pCDQue','pCDInUse','pCDOutBuffer',...
    'pCDEnterCountTemp','pCDExitCountTemp',... %temp
    };
png.set_of_Ts={'tCDEnter','tCDFindDock','tCDComplete','tCDExit','tCDByPass'};
png.set_of_As= {'tCDEnter','pCDEnterCountTemp',1,...
    'tCDEnter','pCDQue',1,'pCDQue','tCDFindDock',1,'tCDFindDock','pCDInUse',1,'pCDInUse','tCDComplete',1,...
    'tCDComplete','pCDOutBuffer',1,'pCDOutBuffer','tCDExit',1,...
    'tCDExit','pCDExitCountTemp',1,... %temp
    'pCDQue','tCDByPass',1,'tCDByPass','pCDOutBuffer',1};
png.set_of_Ports = {'tCDEnter','tCDExit'};

