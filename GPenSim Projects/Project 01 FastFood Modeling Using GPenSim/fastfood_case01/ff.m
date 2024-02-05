clear all; clc;
global global_info
%---------------------------------------CASE ID: 01

%Simulation Run Time
global_info.START_AT = 0;
global_info.STOP_AT = 300;

%Closing time of Restaurant, after which no new customer will be generated
%and no one will be allowed to enter any other module; but customers who
%are already inside different modules will finish their functionality as
%usual
global_info.ClosingTime = 240;              
global_info.TotalRunTime = global_info.STOP_AT - global_info.START_AT;

%--------------------------Initial IMC Module Conditions--------------------------
% The probability of which module should be used from IMC
% We are using randi([1,global_info.VARIABLE]) to determine probability
% So, the higher the number, the lesser the probability
global_info.CounterEnterProbability = 1;
global_info.TableEnterProbability = 2;
global_info.ToiletEnterProbability = 3;
global_info.KidsZoneEnterProbability = 5;
global_info.ChargDockEnterProbability = 5;
global_info.ExitProbability = 3;


%--------------------------Initial Entrance Module Conditions--------------------------
global_info.EntCustGenTime = 3;             %One Customer is being generated in every # Minutes


%--------------------------Initial Counter Module Conditions--------------------------
%Customer
global_info.CNewCounterThreshold = 5;       %Threshold for when one more counter should be used
global_info.CQueCap = 5;                    %Maximum Capacity of Counter Queue
global_info.CustRedirectBOBurgStock = 250;  %Burger Main stock's critical value based on which customer will be redirected to bypass


%Burger
global_info.CBurgIngReq = 50;              %Amount of ingredients required for a Burger 
global_info.CBurgIngSmlStock = global_info.CBurgIngReq * 10;       %Bruger Ingredients Kithcen Stock 
global_info.CBurgIngBigStock = global_info.CBurgIngReq * 170;      %Burger Ingredients Main Stock 
global_info.CBurgRefillAmnt = global_info.CBurgIngReq * 7;        %Burger Ingredients refill amount from Main to Kitchen Stock
global_info.CBurgRefillTriggerMark = global_info.CBurgIngReq * 3;  %Trigger Point When Burger Ingredients in Kitchen should be refilled from Main Storage

%Drink
global_info.CDrinkIngReq = 50;             %Amount of ingredients required for a Drink
global_info.CDrinkIngSmlStock = global_info.CDrinkIngReq * 10;      %Drink Ingredients Kithcen Stock
global_info.CDrinkIngBigStock = global_info.CDrinkIngReq * 170;     %Drink Ingredients Main Stock
global_info.CDrinkRefillAmnt = global_info.CDrinkIngReq * 7;       %Drink Ingredients refill amount from Main to Kitchen Stock
global_info.CDrinkRefillTriggerMark = global_info.CDrinkIngReq * 3;  %Trigger Point When Drink Ingredients in Kitchen should be refilled from Main Storage

%TakeAway Paper Bag (in pcs)
global_info.CTABagSmlStock = 40;            %TakeAway Bag Kithcen Stock
global_info.CTABagBigStock = 200;           %TakeAway Bag Main Stock
global_info.CTABagRefillAmnt = 35;          %TakeAway Bag refill amount from Main to Kitchen Stock
global_info.CTABagRefillTriggerMark = 5;    %Trigger Point When TakeAway Bags in Kitchen should be refilled from Main Storage

%DineIn Tray (in pcs)
global_info.CDITraySmlStock = 25;           %DineIn Tray Kithcen Stock
global_info.CDITrayBigStock = 50;          %DineIn Tray Main Stock
global_info.CDITrayRefillAmnt = 10;         %DineIn Tray refill amount from Main to Kitchen Stock
global_info.CDITrayRefillTriggerMark = 5;   %Trigger Point When DineIn Trays in Kitchen should be refilled from Main Storage
global_info.CDITrayCollect = 5;             %Trigger point when DineIn Trays should be collected from Used Tray
global_info.CTrayColTime = 1;               %Tray collection time
global_info.CDITrayClean = 10;              %Trigger point when Dirty Trays should be sent for cleaning
global_info.CTrayCleanTime = 2;             %Tray Clean Time

%Refill Time
global_info.CRefillTime = 2;                %Stock Refill Time

%Number of Counters based on Customer Arrival
if global_info.EntCustGenTime > global_info.CNewCounterThreshold
    global_info.OrderCounter = 1;
else
    global_info.OrderCounter = 2;
end

%Time Required for different Works 
if global_info.OrderCounter == 1
    global_info.COrderPlaceTime = 2;        %Order Placement Time
    global_info.CBurgMakeTime = 4;          %Burger Making Time
    global_info.CDrinkMakeTime = 2;         %Drink Making Time
    global_info.CRcvOrderTime = 2;          %Order Delivery Time
else
    global_info.COrderPlaceTime = 1;        %Order Placement Time
    global_info.CBurgMakeTime = 2;          %Burger Making Time
    global_info.CDrinkMakeTime = 1;         %Drink Making Time
    global_info.CRcvOrderTime = 1;          %Order Delivery Time
end

%Resource Management
if global_info.OrderCounter == 1
    nCounter1Staff = 1;
    nBurgStaff = 1;
    nDrinkStaff = 1;
    nExtraStaff = 1;
else
    nCounter1Staff = 1;
    nCounter2Staff = 1;
    nBurgStaff = 2;
    nDrinkStaff = 2;
    nExtraStaff = 2;
end

%--------------------------Initial Table Module Conditions--------------------------
global_info.TabQueCap = 3;                  %Maximum Capacity of Table Queue
global_info.TabAvaialble = 2;               %Total number of Tables
global_info.TabUsageTime = 5;               %Table usage time for a customer

%--------------------------Initial Toilet Module Conditions--------------------------
global_info.TQueCap = 3;                    %Maximum Capacity of Table Queue
global_info.TAvaialble = 2;                 %Total number of Toilets
global_info.TUsageTime = 5;                 %Toitlet usage time for a customer

%--------------------------Initial KidsZone Module Conditions--------------------------
global_info.KZQueCap = 3;                   %Maximum Capacity of KidsZone Queue
global_info.KZAvaialble = 2;                %Total number of Empty Slots
global_info.KZUsageTime = 5;                %KidsZone usage time for a customer

%--------------------------Initial ChargingDock Module Conditions--------------------------
global_info.CDQueCap = 5;                  %Maximum Capacity of ChargingDock Queue
global_info.CDAvaialble = 10;              %Total number of Charging Dock
global_info.CDUsageTime = 5;               %Charging Dock usage time for a customer


%----------------Cost Variables----------------
% Ingredients Cost
Costs.Burger = 35;
Costs.Drink = 5;

%Employee Cost (Per Minute)
if global_info.OrderCounter == 1
    Costs.EmpCounter1Staff = 5;
else
    Costs.EmpCounter1Staff = 5;
    Costs.EmpCounter2Staff = 5;
end
Costs.EmpBurgStaff = 5;
Costs.EmpDrinkStaff = 5;
Costs.EmpExtraStaff = 5;

%Fixed Cost (Per Minute)
Costs.FixedCosts = 30;

%----------Income Variables-------------------
BurgerPrice = 250;
DrinkPrice = 80;

pns = pnstruct({'Entrance_pdf','IMC_pdf','Counter_pdf','Table_pdf','Toilet_pdf','Kidszone_pdf','Chargingdock_pdf'});

dyn.m0 = {'pCBurgIng', global_info.CBurgIngSmlStock, 'pCStockBurgIng', global_info.CBurgIngBigStock,...     %Burger Ingredients 
    'pCDrinkIng', global_info.CDrinkIngSmlStock, 'pCStockDrinkIng', global_info.CDrinkIngBigStock,...       %Drinks Ingredients
    'pCTABag', global_info.CTABagSmlStock, 'pCTABagStock', global_info.CTABagBigStock,...                   %TakeAway Bags
    'pCDITray', global_info.CDITraySmlStock, 'pCDITrayStock', global_info.CDITrayBigStock,...               %DineIn Tray
    };

if global_info.OrderCounter == 1
    dyn.ft = {'tEntEnter', global_info.EntCustGenTime,'tC1PlaceOrder',global_info.COrderPlaceTime,...
        'tCMakeBurg',global_info.CBurgMakeTime,'tCMakeDrink',global_info.CDrinkMakeTime,...
        'tCBurgStockRefill',global_info.CRefillTime,'tCDrinkStockRefill',global_info.CRefillTime,...
        'tCBagStockRefill',global_info.CRefillTime,'tCTrayStockRefill',global_info.CRefillTime,...
        'tCCollectTray',global_info.CTrayColTime,'tCCleanTray', global_info.CTrayCleanTime,...
        'tC1RcvOrder',global_info.CRcvOrderTime,...
        'tTabLeave',global_info.TabUsageTime,'tTIn',global_info.TUsageTime,...
        'tKZChooseGame',global_info.KZUsageTime,'tCDFindDock',global_info.CDUsageTime,...
        'allothers', 1};
else
    dyn.ft = {'tEntEnter', global_info.EntCustGenTime,'tC1PlaceOrder',global_info.COrderPlaceTime,'tC2PlaceOrder',global_info.COrderPlaceTime,...
        'tCMakeBurg',global_info.CBurgMakeTime,'tCMakeDrink',global_info.CDrinkMakeTime,...
        'tCBurgStockRefill',global_info.CRefillTime,'tCDrinkStockRefill',global_info.CRefillTime,...
        'tCBagStockRefill',global_info.CRefillTime,'tCTrayStockRefill',global_info.CRefillTime,...
        'tCCollectTray',global_info.CTrayColTime,'tCCleanTray', global_info.CTrayCleanTime,...
        'tC1RcvOrder',global_info.CRcvOrderTime,'tC2RcvOrder',global_info.CRcvOrderTime,...
        'tTabLeave',global_info.TabUsageTime,'tTIn',global_info.TUsageTime,...
        'tKZChooseGame',global_info.KZUsageTime,'tCDFindDock',global_info.CDUsageTime,...
        'allothers', 1};
end

if global_info.OrderCounter == 1
    dyn.re = {'Counter1Staff',nCounter1Staff,inf,...
        'BurgStaff',nBurgStaff,inf,...
        'DrinkStaff',nDrinkStaff,inf,...
        'ExtraStaff',nExtraStaff,inf};
else
    dyn.re = {'Counter1Staff',nCounter1Staff,inf,'Counter2Staff',nCounter2Staff,inf,...
        'BurgStaff',nBurgStaff,inf,...
        'DrinkStaff',nDrinkStaff,inf,...
        'ExtraStaff',nExtraStaff,inf};
end

pni = initialdynamics(pns, dyn);
results = gpensim(pni);
prnschedule(results)
%prnss(results);

% -------------------Count Firing Time of Different Transition------------
nBurgCount = timesfired('tCMakeBurg')
nDrinkCount = timesfired('tCMakeDrink')

%----------------------Cost Calculations----------------------
TotalBurgCost = nBurgCount*Costs.Burger
TotalDrinkCost = nDrinkCount*Costs.Drink
if global_info.OrderCounter == 1
    TotalEmpCost = global_info.TotalRunTime*(nCounter1Staff*Costs.EmpCounter1Staff + nBurgStaff*Costs.EmpBurgStaff + nDrinkStaff*Costs.EmpDrinkStaff + nExtraStaff*Costs.EmpExtraStaff)
else
    TotalEmpCost = global_info.TotalRunTime*(nCounter1Staff*Costs.EmpCounter1Staff + nCounter2Staff*Costs.EmpCounter2Staff + nBurgStaff*Costs.EmpBurgStaff + nDrinkStaff*Costs.EmpDrinkStaff + nExtraStaff*Costs.EmpExtraStaff)
end
TotalFixCost = global_info.TotalRunTime*Costs.FixedCosts
TotalCost = TotalBurgCost + TotalDrinkCost + TotalEmpCost + TotalFixCost

%-----------------Income Calculations-------------------
Income.Burger = nBurgCount*BurgerPrice
Income.Drinks = nDrinkCount*DrinkPrice
TotalIncome = Income.Burger + Income.Drinks

%-------------------Profit Calculations------------------
Profit = TotalIncome - TotalCost

%----------------------------Plotting Graphs-------------------------

%%% Total Number of customers in different modules
figure(1), plotp(results,{'pEntCountTemp','pIMCExitCountTemp'});        %Total Customer Generate, Total Customer Exit
figure(2), plotp(results,{'pCEnterCountTemp','pCExitCountTemp'});       %Total Number of Customer In and Out from Counter
figure(3), plotp(results,{'pTabEnterCountTemp','pTabExitCountTemp'});   %Total Number of Customer In and Out from Table
figure(4), plotp(results,{'pTEnterCountTemp','pTExitCountTemp'});       %Total Number of Customer In and Out from Toilet
figure(5), plotp(results,{'pKZEnterCountTemp','pKZExitCountTemp'});     %Total Number of Customer In and Out from KidsZone
figure(6), plotp(results,{'pCDEnterCountTemp','pCDExitCountTemp'});     %Total Number of Customer In and Out from ChargingDock

%%%------------------Visulisation of Counter Module
%Current number of customers in Queue and waiting for orders
if global_info.OrderCounter == 1
    figure(7), plotp(results,{'pCQue','pC1WaitingOrder'});
else
    figure(7), plotp(results,{'pCQue','pC1WaitingOrder','pC2WaitingOrder'});
end
%Total Number of Order placed, received and bypassed customer
if global_info.OrderCounter == 1
    figure(8), plotp(results,{'pC1PlaceOrder','pC1RcvOrderCount','pCByPassCount'});
else
    figure(8), plotp(results,{'pC1PlaceOrder','pC2PlaceOrder','pC1RcvOrderCount','pC2RcvOrderCount','pCByPassCount'});
end
figure(9), plotp(results,{'pCStockBurgIng','pCBurgIng'});               %Burger Ingredients Stock
figure(10), plotp(results,{'pCStockDrinkIng','pCDrinkIng'});            %Drinks Ingredients Stock
figure(11), plotp(results,{'pCTakeAwayCount','pCDineInCount'});         %Total Number of TakeAway and DineIn orders
figure(12), plotp(results,{'pCTABagStock','pCTABag'});                  %Take Away Paper Bag Stock
figure(13), plotp(results,{'pCDITrayStock','pCDITray'});                %Dine In Tray Stock

%%%------------------Visulisation of current stats of other Modules 
figure(14), plotp(results,{'pTabQue','pTabInUse'});   
figure(15), plotp(results,{'pTQue','pTInUse','pTSinkQue','pTSinkUse'}); 
figure(16), plotp(results,{'pKZQue','pKZPlayZone'}); 
figure(17), plotp(results,{'pCDQue','pCDInUse'}); 

plotGC(results)

