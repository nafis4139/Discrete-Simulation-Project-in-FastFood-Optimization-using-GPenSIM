function [fire, transition] = MOD_Counter_PRE (transition)
global global_info
global PN
fire = 1;
%disp(transition.name);
disp(['In Counter PRE enabled trans is: ', transition.name]);
disp(markings_string(PN.X));


% Assignining "Service Type" Color in tCounterEnter transition
if strcmp(transition.name, 'tC1PlaceOrder')
    if ntokens('pCStockBurgIng') > global_info.CustRedirectBOBurgStock
        %randomly generate service type: TakeAway or DineIn?
        randomService = randi([1,2]); 
        if randomService == 1
            ServiceChoice = 'TakeAway';
        else
            ServiceChoice = 'DineIn';
        end
        %Assign the randomly generated color to the token
        transition.new_color = {ServiceChoice};
        fire = requestSR({'Counter1Staff',1});
    else
        fire = 0;
    end

% Assignining "Service Type" Color in tCounterEnter transition    
elseif strcmp(transition.name, 'tC2PlaceOrder')
    if ntokens('pCStockBurgIng') > global_info.CustRedirectBOBurgStock
        %randomly generate service type: TakeAway or DineIn?
        randomService = randi([1,2]); 
        if randomService == 1
            ServiceChoice = 'TakeAway';
        else
            ServiceChoice = 'DineIn';
        end
        %Assign the randomly generated color to the token
        transition.new_color = {ServiceChoice};
        fire = requestSR({'Counter2Staff',1});
    else
        fire = 0;
    end
    
elseif strcmp(transition.name, 'tCMakeBurg')
    fire = requestSR({'BurgStaff',1});

elseif strcmp(transition.name, 'tCBurgStockRefill')
    fire = requestSR({'ExtraStaff',1}) && le(ntokens('pCBurgIng'),global_info.CBurgRefillTriggerMark);

elseif strcmp(transition.name, 'tCMakeDrink')
    fire = requestSR({'DrinkStaff',1});

elseif strcmp(transition.name, 'tCDrinkStockRefill')
    fire = requestSR({'ExtraStaff',1}) && le(ntokens('pCDrinkIng'),global_info.CDrinkRefillTriggerMark);

elseif strcmp(transition.name, 'tC1RcvOrder')
    fire = requestSR({'Counter1Staff',1});

elseif strcmp(transition.name, 'tC2RcvOrder')
    fire = requestSR({'Counter2Staff',1});

elseif strcmp(transition.name, 'tCBagStockRefill')
    fire = requestSR({'ExtraStaff',1}) && le(ntokens('pCTABag'),global_info.CTABagRefillTriggerMark);

elseif strcmp(transition.name, 'tCTrayStockRefill')
    fire = requestSR({'ExtraStaff',1}) && le(ntokens('pCDITray'),global_info.CDITrayRefillTriggerMark);

elseif strcmp(transition.name, 'tCCollectTray')
    fire = requestSR({'ExtraStaff',1}) && ge(ntokens('pCDIUsedTray'),global_info.CDITrayCollect);

elseif strcmp(transition.name, 'tCCleanTray')
    fire = requestSR({'ExtraStaff',1}) && ge(ntokens('pCDICollectedTray'),global_info.CDITrayClean);

% Checking if the service type is TakeAway
elseif strcmp(transition.name, 'tCTakeAway')
    tokIDOrderAtt = tokenAnyColor('pCRcvOrder',1,{'TakeAway'}); 
    if tokIDOrderAtt == 0
        fire=0;
    else
        transition.selected_tokens = tokIDOrderAtt;
        transition.override = 1;
        transition.new_color = {}; 
        fire = tokIDOrderAtt;
    end

% Checking if the service type is DineIn
elseif strcmp(transition.name, 'tCDineIn')
    tokIDOrderAtt = tokenAnyColor('pCRcvOrder',1,{'DineIn'}); 
    if tokIDOrderAtt == 0
        fire=0;
    else
        transition.selected_tokens = tokIDOrderAtt;
        transition.override = 1;
        transition.new_color = {'Tray'};
        fire = tokIDOrderAtt;
    end

%Checking Condition for ByPass to fire or not
elseif strcmp(transition.name, 'tCByPass')
    fire = ge(ntokens('pCQue'),global_info.CQueCap) || le(ntokens('pCStockBurgIng'),global_info.CustRedirectBOBurgStock);

end