import datetime
from time import time
import yfinance as yf
from get_all_tickers import get_tickers as gt
from datetime import datetime, timedelta
import talib
import pandas as pd
import alpaca_trade_api as tradeapi

# Alpaca Get Account
API_KEY = 'PKQVV0XBE9EL7L873JAH'
API_SECRET = '4YWpFeBVSxjGcMKsemrLHjMkY7yXgLWSW9KvVbTv'
APCA_API_BASE_URL = "https://paper-api.alpaca.markets"

api = tradeapi.REST(API_KEY, API_SECRET, base_url=APCA_API_BASE_URL) 
account = api.get_account()
pos = api.list_positions()

# Fetch Data
# TODO: cache old data [remove old, add current day]
tickers = gt.get_tickers(NYSE=True, NASDAQ=True, AMEX=True)

end_date = datetime.today()
start_date = end_date - timedelta(days=30)
data = yf.download(tickers=tickers, start=start_date, end=end_date, interval='1d', group_by='ticker')

# TEMP SAVE BLOCK
store = pd.HDFStore('data.h5')
store['data'] = data

# Calculate RSI
rsi = {}

for symbol in tickers:
    try:
        RSI = talib.RSI(data[(symbol, 'Close')])[-1]

        rsi[symbol] = RSI
    except:
        continue
print(rsi)
# Filter based on RSI conditions
current_holdings = ['AMZN'] # Fetch from firebase
to_buy = []
to_sell = []
for symbol in rsi.keys():
    if rsi[symbol] <= 30:
        to_buy.append(symbol)
    if rsi[symbol] >= 70: #and (rsi[symbol] in current_holdings):
        to_sell.append(symbol)


# Filter to_buy (TODO)
# 1. Refer to algo.py conditions
# 2. Set spending limit based on user profile

print(to_buy)
print(to_sell)

# Purcase & Sell from Alpaca
def place_order(symbol, side, qty=5): # Buy/Sell stocks
	try:
		place_order = api.submit_order(
			symbol = symbol,
			qty = qty,
			side = side,
			type = 'market',
			time_in_force = 'day'
		)
		print(place_order)
	except:
		print("Something went wrong")
		return 0
	print("Successful")
	return 1
