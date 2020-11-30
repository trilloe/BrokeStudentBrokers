import matplotlib.pyplot as plt
from datetime import datetime
import numpy as np
import talib
import alpaca_trade_api as tradeapi

base_url = 'https://paper-api.alpaca.markets'
api_key_id = 'PKQVV0XBE9EL7L873JAH'
api_secret = '4YWpFeBVSxjGcMKsemrLHjMkY7yXgLWSW9KvVbTv'


api = tradeapi.REST(key_id=api_key_id,secret_key=api_secret, api_version='v2', base_url=base_url)

barTimeframe = "minute" # 1Min, 5Min, 15Min, 1H, 1D
assetsToDownload = ["AMZN"]
startDate = "2020-01-01T00:00:00.000Z" # Start date for the market data in ISO8601 format


positionSizing = 0.25


# Tracks position in list of symbols to download
iteratorPos = 0 
assetListLen = len(assetsToDownload)


while iteratorPos < assetListLen:
	symbol = assetsToDownload[iteratorPos]
	
	returned_data = api.get_barset(symbol,barTimeframe,start=startDate)
    
	
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

	timeList = list(returned_data.df.index.values)
	timeList = np.array(timeList)
	closeList = returned_data.df[(symbol,  'close')]

	price = closeList[-1]

	# Calculated trading indicators
	SMA20 = talib.SMA(closeList,20)
	SMA50 = talib.SMA(closeList,50)

	print("Test - So far so good")

	mom = talib.MOM(closeList,20)

	# print(SMA20)
	# print(SMA50)

	# if SMA20 > SMA50:
	# 	openPosition = api.get_position(symbol)
		
	# 	# Opens new position if one does not exist
	# 	if openPosition == 0:
	# 		cashBalance = api.get_account().cash
		
	# 		targetPositionSize = cashBalance / (price / positionSizing) # Calculates required position size
	# 		print("Buy {0}".format(targetPositionSize))

	# 		# returned = api.submit_order(symbol,targetPositionSize,"buy","market","gtc") # Market order to open position
	# 		# print(returned)
			
	# else:
	# 	# Closes position if SMA20 is below SMA50
	# 	# openPosition = api.get_position(symbol)
		
	# 	print("Sell")

	# 	# returned = api.submit_order(symbol,openPosition,"sell","market","gtc") # Market order to fully close position
	# 	# print(returned)
		

	
	# Defines the plot for each trading symbol
	f, ax = plt.subplots()
	f.suptitle(symbol)
	
	# Plots market data and indicators
	ax.plot(timeList,closeList,label=symbol,color="black")
	# ax.plot(timeList,SMA20,label="SMA20",color="green")
	# ax.plot(timeList,SMA50,label="SMA50",color="red")
	ax.plot(timeList,mom,label=symbol,color="red")
	
	# Fills the green region if SMA20 > SMA50 and red if SMA20 < SMA50
	# ax.fill_between(timeList, SMA50, SMA20, where=SMA20 >= SMA50, facecolor='green', alpha=0.5, interpolate=True)
	# ax.fill_between(timeList, SMA50, SMA20, where=SMA20 <= SMA50, facecolor='red', alpha=0.5, interpolate=True)
	
	# Adds the legend to the right of the chart
	ax.legend(loc='center left', bbox_to_anchor=(1.0,0.5))
	
	iteratorPos += 1

# print(returned_data.df.columns)

plt.show()