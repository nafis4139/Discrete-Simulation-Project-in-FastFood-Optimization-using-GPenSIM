function [png] = Toilet_pdf()
global global_info

png.PN_name='Toilet';

png.set_of_Ps ={'pTQue','pTInUse','pTSinkQue','pTSinkUse','pTOutBuffer',...
    'pTEnterCountTemp','pTExitCountTemp',... %temp
    };
png.set_of_Ts={'tTEnter','tTIn','tTleave','tTSinkIn','tTSinkOut','tTExit','tTByPass'};
png.set_of_As={'tTEnter','pTEnterCountTemp',1,... %temp
    'tTEnter','pTQue',1,'pTQue','tTIn',1,'tTIn','pTInUse',1,'pTInUse','tTleave',1,...
    'tTleave','pTSinkQue',1,'pTSinkQue','tTSinkIn',1,'tTSinkIn','pTSinkUse',1,'pTSinkUse','tTSinkOut',1,...
    'tTSinkOut','pTOutBuffer',1,'pTOutBuffer','tTExit',1,...
    'tTExit','pTExitCountTemp',1,... %temp
    'pTQue','tTByPass',1,'tTByPass','pTOutBuffer',1};
png.set_of_Ports = {'tTEnter','tTExit'};
