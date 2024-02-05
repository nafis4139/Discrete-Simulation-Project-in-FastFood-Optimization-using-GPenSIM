function [png] = Kidszone_pdf()
global global_info

png.PN_name='Kidszone';

png.set_of_Ps={'pKZQue','pKZPlayZone','pKZOutBuffer',...
    'pKZEnterCountTemp','pKZExitCountTemp'};
png.set_of_Ts={'tKZEnter','tKZChooseGame','tKZJumping','tKZSliding','tKZExit','tKZByPass'};
png.set_of_As= {'tKZEnter','pKZEnterCountTemp',1,... %temp
    'tKZEnter','pKZQue',1,'pKZQue','tKZChooseGame',1,'tKZChooseGame','pKZPlayZone',1,...
    'pKZPlayZone','tKZJumping',1,'tKZJumping','pKZOutBuffer',1,...
    'pKZPlayZone','tKZSliding',1,'tKZSliding','pKZOutBuffer',1,...
    'pKZOutBuffer','tKZExit',1,...
    'tKZExit','pKZExitCountTemp',1,... %temp
    'pKZQue','tKZByPass',1,'tKZByPass','pKZOutBuffer',1,... %ByPass
    };
png.set_of_Ports = {'tKZEnter','tKZExit'};