function [png] = Entrance_pdf()
global global_info

png.PN_name='Entrance';

png.set_of_Ps={'pEntBuffer',...
    'pEntCountTemp',... %temp
    };
png.set_of_Ts={'tEntEnter','tEntExit'};
png.set_of_As={'tEntEnter','pEntBuffer',1,'pEntBuffer','tEntExit',1,...
    'tEntEnter','pEntCountTemp',1,... %temp
    };
png.set_of_Ports = {'tEntEnter','tEntExit'};