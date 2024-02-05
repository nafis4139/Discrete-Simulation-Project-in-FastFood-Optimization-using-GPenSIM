function [colormap_record] = get_current_colors ()
% [colormap_record] = get_current_colors ()
%               Reggie Davidrajuh (c) August 2011

global PN;

Ps = PN.No_of_places; 

colormap_record = [];
for placeI = 1:Ps,
    token_bank = PN.global_places(placeI).token_bank;
    if not(isempty(token_bank)),
        lenTB = length(token_bank);
        for tokenJ = 1:lenTB,
            if not(isempty(token_bank(tokenJ).color)),
                cm.time = PN.current_time;
                cm.place = placeI;
                cm.color = token_bank(tokenJ).color;
                cm.tokID = token_bank(tokenJ).tokID;
                colormap_record = [colormap_record  cm];
            end;
        end;
    end;
end;
