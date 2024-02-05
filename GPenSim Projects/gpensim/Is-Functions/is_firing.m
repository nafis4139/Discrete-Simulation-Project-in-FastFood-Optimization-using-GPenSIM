function [firing_or_not] = is_firing(transition1)
% function [firing_or_not] = is_firing(transition1)

global PN

if not(nargin), % transition is not mentioned
    firing_or_not = false; % initial assumption
    Ts = ntrans(); % get the number of transitions 
    for t = 1:Ts,  % check every trans 
        if is_firing(t), % is this trans firing 
            firing_or_not = true;
            return;
        end
    end
    return % none is firing
end

% transition is given
% if transition name is given then convert into tid number
if ischar(transition1),
    transition1 = is_trans(transition1);
end

firing_or_not = PN.Firing_Transitions(transition1);

