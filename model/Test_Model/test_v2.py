import matplotlib.pyplot as plt
from datetime import datetime
import numpy as np
import pandas
import talib
import alpaca_trade_api as tradeapi
import pandas as pd


# plt.style.use('fivethirtyeight')

base_url = 'https://paper-api.alpaca.markets'
api_key_id = 'PKQVV0XBE9EL7L873JAH'
api_secret = '4YWpFeBVSxjGcMKsemrLHjMkY7yXgLWSW9KvVbTv'


api = tradeapi.REST(key_id=api_key_id,secret_key=api_secret, api_version='v2', base_url=base_url)

barTimeframe = "1D" # 1Min, 5Min, 15Min, 1H, 1D
assetsToDownload = ["AMZN"]
startDate = "2017-01-01T00:00:00.000Z" # Start date for the market data in ISO8601 format


# print(api.list_assets())

positionSizing = 0.25


# Tracks position in list of symbols to download
iteratorPos = 0 
assetListLen = len(assetsToDownload)


symbol = ['AMZN','FB','TSLA','MSFT','AAPL']

returned_data = api.get_barset(symbol,barTimeframe,start=startDate)


tot_returns = [0,0,0,0,0,0,0,0,0,0,0]
global_x = []

# series = returned_data.df.resample('5min').min()

# print(series[series.index.floor('1D'):])



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

colors = {'AMZN':'black','FB':'blue','TSLA':'red','MSFT':'orange','AAPL':'pink'}

for s in symbol:
	closeList = returned_data.df[(s,  'close')]

	price = closeList[-1]

	# Calculated trading indicators
	# SMA20 = talib.SMA(closeList,20)
	# SMA50 = talib.SMA(closeList,50)
	RSI = talib.RSI(closeList)

	lower = 30
	upper = 70


	X = []
	Y_Returns = []

	while lower <= 40:

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

		# print(RSI)
		# mom = talib.MOM(closeList,20)

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
		

		# Plots market data and indicators
		# 
		
		
		# ax.plot(timeList,RSI,label=symbol,color="red")


		X.append("[{0},{1}]".format(lower,upper))
		Y_Returns.append((((sum(money_returned)-sum(money_spent))/sum(money_spent))*100))

		print([lower,upper])
		print("Total Investment in {0} : {1}".format(s,sum(money_spent)))
		print("Total Returns from {0} : {1}".format(s,sum(money_returned)))
		print("Return Percentage : {0}".format((((sum(money_returned)-sum(money_spent))/sum(money_spent))*100)))
		print(" ")

		lower = lower + 1
		upper = upper - 1
	
	plt.suptitle("Returns")
	plt.plot(X,Y_Returns,color=colors[s], alpha=0.5, label=s)

	for l in range(0,len(tot_returns)):
		tot_returns[l] = tot_returns[l] + Y_Returns[l]

	global_x = X
		# Fills the green region if SMA20 > SMA50 and red if SMA20 < SMA50
		# ax.fill_between(timeList, SMA50, SMA20, where=SMA20 >= SMA50, facecolor='green', alpha=0.5, interpolate=True)
		# ax.fill_between(timeList, SMA50, SMA20, where=SMA20 <= SMA50, facecolor='red', alpha=0.5, interpolate=True)

		# Adds the legend to the right of the chart
	plt.legend(loc='center left', bbox_to_anchor=(1.0,0.5))


plt.plot(global_x,tot_returns,label="Total Returns", color="yellow")
plt.show()
		