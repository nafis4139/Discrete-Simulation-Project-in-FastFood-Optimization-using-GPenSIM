function [png] = Table_pdf()

global global_info

png.PN_name='Table';

png.set_of_Ps={'pTabQue','pTabInUse','pTabOutBuffer',...
    'pTabEnterCountTemp','pTabExitCountTemp'};
png.set_of_Ts={'tTabEnter','tTabFind','tTabLeave','tTabByPass','tTabExit'};
png.set_of_As={'tTabEnter','pTabEnterCountTemp',1,... %temp
    'tTabEnter','pTabQue',1,'pTabQue','tTabFind',1,'tTabFind','pTabInUse',1....
    'pTabInUse','tTabLeave',1,'tTabLeave','pTabOutBuffer',1,'pTabOutBuffer','tTabExit',1,...
    'tTabExit','pTabExitCountTemp',1,... %temp
    'pTabQue','tTabByPass',1,'tTabByPass','pTabOutBuffer',1};
png.set_of_Ports = {'tTabEnter','tTabExit'};