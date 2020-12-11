import matplotlib.pyplot as plt
from datetime import datetime
import numpy as np
import pandas
import talib
import alpaca_trade_api as tradeapi
import pandas as pd
from get_all_tickers import get_tickers as gt
import random
import yfinance as yf

# plt.style.use('fivethirtyeight')

def random_color(number_of_colors):
	color = ["#"+''.join([random.choice('0123456789ABCDEF') for j in range(6)])
             for i in range(number_of_colors)]
	return color
	

base_url = 'https://paper-api.alpaca.markets'
api_key_id = 'PKQVV0XBE9EL7L873JAH'
api_secret = '4YWpFeBVSxjGcMKsemrLHjMkY7yXgLWSW9KvVbTv'


# api = tradeapi.REST(key_id=api_key_id,secret_key=api_secret, api_version='v2', base_url=base_url)

barTimeframe = "1D" # 1Min, 5Min, 15Min, 1H, 1D
assetsToDownload = ["AMZN"]
startDate = "2017-01-01T00:00:00.000Z" # Start date for the market data in ISO8601 format


# print(api.list_assets())

positionSizing = 0.25


# Tracks position in list of symbols to download
iteratorPos = 0 
assetListLen = len(assetsToDownload)


# symbol =  gt.get_biggest_n_tickers(200)[100:180] #['AMZN','FB','TSLA','MSFT','AAPL', 'GOOG']
# symbol = gt.get_tickers()
symbol = ['AMZN','FB',"TSLA","MSFT",'AAPL']


# returned_data = pd.DataFrame

# for i in range(0, len(symbol), 100):
# 	api = tradeapi.REST(key_id=api_key_id,secret_key=api_secret, api_version='v2', base_url=base_url)
# 	ob_data = api.get_barset(symbol[i:i+100],barTimeframe,start=startDate)
# 	print(ob_data.df)
# 	returned_data.append(ob_data.df)

# returned_data = api.get_barset(symbol,barTimeframe,start=startDate)

returned_data = yf.download(tickers=symbol, period='max', interval='1d', group_by='ticker')

store = pd.HDFStore('store.h5')
store['returned_data'] = returned_data
returned_data = store['returned_data']
# print(returned_data.iloc[-1:-300:-1])


tot_returns = [0,0,0,0,0,0,0,0,0,0,0]
global_x = []

# series = returned_data.df.resample('5min').min()

# print(series[series.index.floor('1D'):])



timeList = []
openList = []
highList = []
lowList = []
closeList = []
volumeList = []

# Reads, formats and stores the new bars
# for bar in returned_data:
# 	timeList.append(datetime.strptime(bar.time,'%Y-%m-%dT%H:%M:%SZ'))
# 	openList.append(bar.open)
# 	highList.append(bar.high)
# 	lowList.append(bar.low)
# 	closeList.append(bar.close)
# 	volumeList.append(bar.volume)

# Processes all data into numpy arrays for use by talib
timeList = np.array(timeList)
openList = np.array(openList,dtype=np.float64)
highList = np.array(highList,dtype=np.float64)
lowList = np.array(lowList,dtype=np.float64)
closeList = np.array(closeList,dtype=np.float64)
volumeList = np.array(volumeList,dtype=np.float64)

timeList = list(returned_data.index.values)# list(returned_data.df.index.values)
timeList = np.array(timeList)

colors = random_color(len(symbol)) #{'AMZN':'black','FB':'blue','TSLA':'red','MSFT':'orange','AAPL':'pink'}



for s in symbol:
	closeList = returned_data[(s,  'Close')]

	price = closeList[-1]

	# Calculated trading indicators
	# SMA20 = talib.SMA(closeList,20)
	# SMA50 = talib.SMA(closeList,50)
	try:

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
			# ax.plot(timeList,closeList,label=s,color="black", alpha=0.35)
			# ax.scatter(timeList,buy,label="buy",color="green", marker="^", alpha=0.45)
			# ax.scatter(timeList,sell,label="sell",color="red", marker="v",alpha = 0.45)
			# ax.plot(timeList,RSI,label=symbol,color="red")

		# Plots market data and indicators
		# 
		
		
		# ax.plot(timeList,RSI,label=symbol,color="red")

			X.append("[{0},{1}]".format(lower,upper))

			# try:
			# 	Y_Returns.append((((sum(money_returned)-sum(money_spent))/sum(money_spent))*100))
			# except(ZeroDivisionError):
			# 	Y_Returns.append(0)

			if sum(money_returned) == 0:
				Y_Returns.append(sum(money_spent))
			else:
				if sum(money_spent) != 0:
					Y_Returns.append((((sum(money_returned)-sum(money_spent))/sum(money_spent))*100))

			
			print([lower,upper])
			print("Total Investment in {0} : {1}".format(s,sum(money_spent)))
			print("Total Returns from {0} : {1}".format(s,sum(money_returned)))
			# print("Return Percentage : {0}".format((((sum(money_returned)-sum(money_spent))/sum(money_spent))*100)))
			print(" ")

			lower = lower + 1
			upper = upper - 1
	except:
		continue
	
	plt.suptitle("Returns")
	# print(colors)
	plt.plot(X,Y_Returns,color=colors[symbol.index(s)], alpha=0.5, label=s)

	for l in range(0,len(tot_returns)):
		tot_returns[l] = tot_returns[l] + Y_Returns[l]
	

	global_x = X
		# Fills the green region if SMA20 > SMA50 and red if SMA20 < SMA50
		# ax.fill_between(timeList, SMA50, SMA20, where=SMA20 >= SMA50, facecolor='green', alpha=0.5, interpolate=True)
		# ax.fill_between(timeList, SMA50, SMA20, where=SMA20 <= SMA50, facecolor='red', alpha=0.5, interpolate=True)

		# Adds the legend to the right of the chart
	plt.legend(loc='center left', bbox_to_anchor=(1.0,0.5))

#Replace 20 with Len(Symbols)
tot_returns = [i/len(symbol) for i in tot_returns]

print(tot_returns)
print(global_x)

plt.plot(global_x,tot_returns,label="Total Returns", color="orange")
plt.axhline(0, color='black')
plt.show()
		