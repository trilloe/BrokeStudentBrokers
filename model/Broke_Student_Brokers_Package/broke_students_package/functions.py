from datetime import datetime
import numpy as np
import talib
import alpaca_trade_api as tradeapi
import pandas as pd
import matplotlib.pyplot as plt

def run():

    base_url = 'https://paper-api.alpaca.markets'
    api_key_id = 'PKQVV0XBE9EL7L873JAH'
    api_secret = '4YWpFeBVSxjGcMKsemrLHjMkY7yXgLWSW9KvVbTv'


    api = tradeapi.REST(key_id=api_key_id,secret_key=api_secret, api_version='v2', base_url=base_url)

    barTimeframe = "1D" # 1Min, 5Min, 15Min, 1H, 1D
    assetsToTrade = ["ALG","CEL","CEN","CCS"]
    positionSizing = 0.25


    startDate = "2016-01-01T00:00:00.000Z"

    # Tracks position in list of symbols to download
    iteratorPos = 0 
    assetListLen = len(assetsToTrade)


    while iteratorPos < assetListLen:
        symbol = assetsToTrade[iteratorPos]
        
        returned_data = api.get_barset(symbol,barTimeframe,start=startDate)

        timeList = list(returned_data.df.index.values)
        timeList = np.array(timeList)

        closeList = returned_data.df[(symbol,  'close')]

        RSI = talib.RSI(closeList)
        
        lower = 30
        upper = 70


        
        # timeList = []
        # openList = []
        # highList = []
        # lowList = []
        # closeList = []
        # volumeList = []

        # # Reads, formats and stores the new bars
        # for bar in returned_data:
        # 	timeList.append(datetime.strptime(bar.time,'%Y-%m-%dT%H:%M:%SZ'))
        # 	openList.append(bar.open)
        # 	highList.append(bar.high)
        # 	lowList.append(bar.low)
        # 	closeList.append(bar.close)
        # 	volumeList.append(bar.volume)
        
        # # Processes all data into numpy arrays for use by talib
        # timeList = np.array(timeList)
        # openList = np.array(openList,dtype=np.float64)
        # highList = np.array(highList,dtype=np.float64)
        # lowList = np.array(lowList,dtype=np.float64)
        # closeList = np.array(closeList,dtype=np.float64)
        # volumeList = np.array(volumeList,dtype=np.float64)

        # # Calculated trading indicators
        # SMA20 = talib.SMA(closeList,20)[-1]
        # SMA50 = talib.SMA(closeList,50)[-1]

        
        # Calculates the trading signals
        # if SMA20 > SMA50:
        # 	openPosition = api.get_position(symbol)
            
        # 	# Opens new position if one does not exist
        # 	if openPosition == 0:
        # 		cashBalance = api.get_account().cash
            
        # 		targetPositionSize = cashBalance / (price / positionSizing) # Calculates required position size
                
        # 		returned = api.submit_order(symbol,targetPositionSize,"buy","market","gtc") # Market order to open position
        # 		print(returned)
            
        # else:
        # 	# Closes position if SMA20 is below SMA50
        # 	openPosition = api.get_position(symbol)
            
        # 	returned = api.submit_order(symbol,openPosition,"sell","market","gtc") # Market order to fully close position
        # 	print(returned)


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

        f, ax =  plt.subplots()

        ax.set_title(symbol)

        ax.plot(timeList,closeList,label=symbol,color="black", alpha=0.35)
        ax.scatter(timeList,buy,label="buy",color="green", marker="^", alpha=0.45)
        ax.scatter(timeList,sell,label="sell",color="red", marker="v",alpha = 0.45)
        ax.plot(timeList,RSI,label="RSI",color="blue",alpha = 0.45)
        
        iteratorPos += 1

    plt.show()
    return api.get_account()