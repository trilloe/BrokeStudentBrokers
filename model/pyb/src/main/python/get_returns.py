from datetime import datetime
import numpy as np
import talib
import pandas as pd
import math

#YOLO


def get_returns(time_series_closelist):

    returns = []
   
    closeList = time_series_closelist
    timeList = time_series_closelist.index

    RSI = talib.RSI(closeList)
    
    lower = 30
    upper = 70

    buy = []
    sell = []
    flag = -1

    money_spent = []
    money_returned = []
    
    for i in RSI.index:
        if RSI[i] != np.NaN:
            if RSI[i] < lower:
                if flag != 1:
                    buy.append(closeList[i])
                    sell.append(np.NaN)
                    flag = 1
                    money_spent.append(closeList[i])
                else:
                    buy.append(np.NaN)
                    sell.append(np.NaN)
            elif RSI[i] > upper:
                if flag != 0 and flag != -1:
                    sell.append(closeList[i])
                    buy.append(np.NaN)
                    flag = 0
                    money_returned.append(closeList[i])
                else:
                    buy.append(np.NaN)
                    sell.append(np.NaN)
            else:
                buy.append(np.NaN)
                sell.append(np.NaN)
        else:
            print("False")
            buy.append(np.NaN)
            sell.append(np.NaN)
            
    buy = pd.DataFrame(buy,index=timeList)
    sell = pd.DataFrame(sell,index=timeList)

    if sum(money_returned) == 0:
        returns.append(sum(money_spent))
    else:
        if sum(money_spent) != 0:
            returns.append((((sum(money_returned)-sum(money_spent))/sum(money_spent))*100))

    return math.floor(returns[0])

close_prices_w_prof =  pd.DataFrame([746.4 , 737.75, 735.65, 699.25, 669.25, 640.9 , 609.75, 601.15, 623.7 , 602.9 , 566.3 , 561.  , 511.45, 502.4 , 497.75, 469.2 ,497.15, 504.05, 516.  , 619.2 , 578.75, 592.2 , 608.35, 602.3 ,   593.2 , 593.4 , 589.65, 597.75, 608.6 , 610.2 , 642.55, 637.4 , 626.35, 645.15, 665.85, 666.7 , 665.25, 712.15, 736.45, 740.6 , 760.15, 766.65, 754.4 , 757.9 , 768.5 , 781.5 , 783.75, 807.55, 792.85, 789.2 , 790.85, 775.6 , 884.05, 901.35, 884.4 , 853.65, 887.45, 873.05, 841.  , 834.85])[0]
print(get_returns(close_prices_w_prof))