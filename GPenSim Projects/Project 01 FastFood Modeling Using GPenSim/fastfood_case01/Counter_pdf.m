function [png] = Counter_pdf()
global global_info

png.PN_name = 'Counter';

if global_info.OrderCounter == 1
    png.set_of_Ps = {'pCEnterCountTemp','pCExitCountTemp',... %temp
        'pC1PlaceOrder','pCBurgCount','pCDrinkCount','pC1RcvOrderCount','pCTakeAwayCount','pCDineInCount','pCByPassCount',... %temp places
        'pCQue','pCKitchen','pCBurgReady','pCDrinkReady','pC1WaitingOrder','pCRcvOrder','pCOutBuffer',... %order flow
        'pCBurgIng','pCStockBurgIng','pCDrinkIng','pCStockDrinkIng','pCTABag','pCTABagStock','pCDITray','pCDITrayStock',... %storage
        'pCDIUsedTray','pCDICollectedTray',... %reusability
        };
    png.set_of_Ts = {'tCEnter','tC1PlaceOrder','tCMakeBurg','tCMakeDrink','tC1RcvOrder','tCTakeAway','tCDineIn','tCExit',... %order flow
        'tCBurgStockRefill','tCDrinkStockRefill','tCBagStockRefill','tCTrayStockRefill',... %storage
        'tCCollectTray','tCCleanTray',... %reusability
        'tCByPass',... %ByPass
        };
    png.set_of_As = {'tCEnter','pCEnterCountTemp',1,... %temp
        'tCEnter','pCQue',1,'pCQue','tC1PlaceOrder',1,... %order flow
        'tC1PlaceOrder','pC1PlaceOrder',1,... %temp
        'tC1PlaceOrder','pCKitchen',1,'tC1PlaceOrder','pC1WaitingOrder',1,... %order flow
        'pCKitchen','tCMakeBurg',1,'pCBurgIng','tCMakeBurg',global_info.CBurgIngReq,'tCMakeBurg','pCBurgReady',1,... %Burger Making
        'pCStockBurgIng','tCBurgStockRefill',global_info.CBurgRefillAmnt,'tCBurgStockRefill','pCBurgIng',global_info.CBurgRefillAmnt,... %Burger Ingredients Storage
        'tCMakeBurg','pCBurgCount',1,... %temp
        'pCBurgReady','tCMakeDrink',1,'pCDrinkIng','tCMakeDrink',global_info.CDrinkIngReq,'tCMakeDrink','pCDrinkReady',1,... %Drink Making
        'pCStockDrinkIng','tCDrinkStockRefill',global_info.CDrinkRefillAmnt,'tCDrinkStockRefill','pCDrinkIng',global_info.CDrinkRefillAmnt,... %Drink Ingredients Storage
        'tCMakeDrink','pCDrinkCount',1,... %temp
        'pCDrinkReady','tC1RcvOrder',1,'pC1WaitingOrder','tC1RcvOrder',1,'tC1RcvOrder','pCRcvOrder',1,... %order flow
        'tC1RcvOrder','pC1RcvOrderCount',1,... %temp
        'pCRcvOrder','tCTakeAway',1,'pCRcvOrder','tCDineIn',1,... %takeaway or dinein
        'pCTABagStock','tCBagStockRefill',global_info.CTABagRefillAmnt,'tCBagStockRefill','pCTABag',global_info.CTABagRefillAmnt,... %TakeAway Bag Storage
        'tCTakeAway','pCTakeAwayCount',1,... %temp
        'pCDITrayStock','tCTrayStockRefill',global_info.CDITrayRefillAmnt,'tCTrayStockRefill','pCDITray',global_info.CDITrayRefillAmnt,... %DineIn Tray Storage
        'tCDineIn','pCDineInCount',1,... %temp
        'tCTakeAway','pCOutBuffer',1,'tCDineIn','pCOutBuffer',1,'pCOutBuffer','tCExit',1,... %order flow 
        'tCDineIn','pCDIUsedTray',1,'pCDIUsedTray','tCCollectTray',1,'tCCollectTray','pCDICollectedTray',1,... %DineIn Tray Flow
        'pCDICollectedTray','tCCleanTray',1,'tCCleanTray','pCDITray',1,... %DineIn Tray Flow
        'pCQue','tCByPass',1,'tCByPass','pCOutBuffer',1,'tCByPass','pCByPassCount',1,... %ByPass
        'tCExit','pCExitCountTemp',1,... %temp
        };

elseif global_info.OrderCounter == 2
    png.set_of_Ps = {'pCEnterCountTemp','pCExitCountTemp',... %temp
        'pC1PlaceOrder','pC2PlaceOrder','pCBurgCount','pCDrinkCount','pC1RcvOrderCount','pC2RcvOrderCount','pCTakeAwayCount','pCDineInCount','pCByPassCount',... %temp places
        'pCQue','pCKitchen','pCBurgReady','pCDrinkReady','pC1WaitingOrder','pC2WaitingOrder','pCRcvOrder','pCOutBuffer',... %order flow
        'pCBurgIng','pCStockBurgIng','pCDrinkIng','pCStockDrinkIng','pCTABag','pCTABagStock','pCDITray','pCDITrayStock',... %storage
        'pCDIUsedTray','pCDICollectedTray',... %reusability
        };
    png.set_of_Ts = {'tCEnter','tC1PlaceOrder','tC2PlaceOrder','tCMakeBurg','tCMakeDrink','tC1RcvOrder','tC2RcvOrder','tCTakeAway','tCDineIn','tCExit',... %order flow
        'tCBurgStockRefill','tCDrinkStockRefill','tCBagStockRefill','tCTrayStockRefill',... %storage
        'tCCollectTray','tCCleanTray',... %reusability
        'tCByPass',... %ByPass
        };
    png.set_of_As = {'tCEnter','pCEnterCountTemp',1,... %temp
        'tCEnter','pCQue',1,'pCQue','tC1PlaceOrder',1,'pCQue','tC2PlaceOrder',1,... %order flow
        'tC1PlaceOrder','pC1PlaceOrder',1,'tC2PlaceOrder','pC2PlaceOrder',1,... %temp
        'tC1PlaceOrder','pCKitchen',1,'tC1PlaceOrder','pC1WaitingOrder',1,... %order flow
        'tC2PlaceOrder','pCKitchen',1,'tC2PlaceOrder','pC2WaitingOrder',1,... %order flow
        'pCKitchen','tCMakeBurg',1,'pCBurgIng','tCMakeBurg',global_info.CBurgIngReq,'tCMakeBurg','pCBurgReady',1,... %Burger Making
        'pCStockBurgIng','tCBurgStockRefill',global_info.CBurgRefillAmnt,'tCBurgStockRefill','pCBurgIng',global_info.CBurgRefillAmnt,... %Burger Ingredients Storage
        'tCMakeBurg','pCBurgCount',1,... %temp
        'pCBurgReady','tCMakeDrink',1,'pCDrinkIng','tCMakeDrink',global_info.CDrinkIngReq,'tCMakeDrink','pCDrinkReady',1,... %Drink Making
        'pCStockDrinkIng','tCDrinkStockRefill',global_info.CDrinkRefillAmnt,'tCDrinkStockRefill','pCDrinkIng',global_info.CDrinkRefillAmnt,... %Drink Ingredients Storage
        'tCMakeDrink','pCDrinkCount',1,... %temp
        'pCDrinkReady','tC1RcvOrder',1,'pC1WaitingOrder','tC1RcvOrder',1,'tC1RcvOrder','pCRcvOrder',1,... %order flow
        'pCDrinkReady','tC2RcvOrder',1,'pC2WaitingOrder','tC2RcvOrder',1,'tC2RcvOrder','pCRcvOrder',1,... %order flow
        'tC1RcvOrder','pC1RcvOrderCount',1,'tC2RcvOrder','pC2RcvOrderCount',1,... %temp
        'pCRcvOrder','tCTakeAway',1,'pCTABag','tCTakeAway',1,'tCTakeAway','pCOutBuffer',1,... %TakeAway
        'pCTABagStock','tCBagStockRefill',global_info.CTABagRefillAmnt,'tCBagStockRefill','pCTABag',global_info.CTABagRefillAmnt,... %TakeAway Bag Storage
        'tCTakeAway','pCTakeAwayCount',1,... %temp
        'pCRcvOrder','tCDineIn',1,'pCDITray','tCDineIn',1,'tCDineIn','pCOutBuffer',1,... %DneIn
        'pCDITrayStock','tCTrayStockRefill',global_info.CDITrayRefillAmnt,'tCTrayStockRefill','pCDITray',global_info.CDITrayRefillAmnt,... %DineIn Tray Storage
        'tCDineIn','pCDineInCount',1,... %temp 
        'pCOutBuffer','tCExit',1,... %Order Flow
        'tCDineIn','pCDIUsedTray',1,'pCDIUsedTray','tCCollectTray',global_info.CDITrayCollect,'tCCollectTray','pCDICollectedTray',global_info.CDITrayCollect,... %DineIn Tray Flow
        'pCDICollectedTray','tCCleanTray',global_info.CDITrayClean,'tCCleanTray','pCDITray',global_info.CDITrayClean,... %DineIn Tray Flow
        'pCQue','tCByPass',1,'tCByPass','pCOutBuffer',1,'tCByPass','pCByPassCount',1,... %ByPass
        'tCExit','pCExitCountTemp',1,... %temp
        };
end

png.set_of_Ports = {'tCEnter','tCExit'};
