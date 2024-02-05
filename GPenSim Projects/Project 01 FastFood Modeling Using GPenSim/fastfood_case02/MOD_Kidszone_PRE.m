function [fire, transition] = MOD_Kidszone_PRE (transition)
global global_info
global PN
fire = 1;
%disp(transition.name);
disp(['In KZ PRE enabled trans is: ', transition.name]);
disp(markings_string(PN.X));

if strcmp(transition.name, 'tKZChooseGame')
    %randomly generate service type: TakeAway or DineIn?
    Choosegame = randi([1,2]); 
    if Choosegame == 1
        game = 'jumping';
    else
        game = 'sliding';
    end
    %Assign the randomly generated color to the token
    transition.new_color = {game};
    fire = le(ntokens('pKZPlayZone'),global_info.KZAvaialble);
    
elseif strcmp(transition.name, 'tKZJumping')
    tokIDOrderAtt = tokenAnyColor('pKZPlayZone',1,{'jumping'}); 
    if tokIDOrderAtt == 0
        fire=0;
    else
        transition.selected_tokens = tokIDOrderAtt;
        transition.override = 1;
        transition.new_color = {}; 
        fire = tokIDOrderAtt;
    end

elseif strcmp(transition.name, 'tKZSliding')
    tokIDOrderAtt = tokenAnyColor('pKZPlayZone',1,{'sliding'}); 
    if tokIDOrderAtt == 0
        fire=0;
    else
        transition.selected_tokens = tokIDOrderAtt;
        transition.override = 1;
        transition.new_color = {}; 
        fire = tokIDOrderAtt;
    end

elseif strcmp(transition.name, 'tKZByPass')
    fire= ge(ntokens('pKZQue'),global_info.KZQueCap);
end