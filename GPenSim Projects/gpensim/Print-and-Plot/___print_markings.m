function [] = print_markings(markings)
%        [] = print_markings(markings)

%   Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) July 2012 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

if not(any(markings)),
    disp('NO tokens');
    return
end;

Ps = PN.No_of_places; % number of places
disp_str = '';

for i = 1:Ps,
    tokens = markings(i);
    if (tokens), 
        if eq(tokens, 1), 
            tokens_str = '';  % no need to say 1pBuff; just say pBuff
        else
            tokens_str = int2str(tokens);
        end;
        tokens_str = [tokens_str, PN.global_places(i).name];
        disp_str = [disp_str, tokens_str, ' + '];
    end;
end;

disp_str = disp_str(1:end-3); % remove the trailing ' + '

disp(disp_str); 

