import datetime
from time import time
import yfinance as yf
from get_all_tickers import get_tickers as gt
from datetime import datetime, timedelta
import talib
import pandas as pd
import alpaca_trade_api as tradeapi

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# Alpaca Get Account
API_KEY = 'PKQVV0XBE9EL7L873JAH'
API_SECRET = '4YWpFeBVSxjGcMKsemrLHjMkY7yXgLWSW9KvVbTv'
APCA_API_BASE_URL = "https://paper-api.alpaca.markets"

api = tradeapi.REST(API_KEY, API_SECRET, base_url=APCA_API_BASE_URL) 
account = api.get_account()
portfolio = api.list_positions()

# Firebase Connection
cred = credentials.Certificate('./service-account.json')
firebase_admin.initialize_app(cred)

db = firestore.client()

# Fetch Data
# TODO: cache old data [remove old, add current day]
tickers = gt.get_tickers(NYSE=True, NASDAQ=True, AMEX=True)

# end_date = datetime.today()
# start_date = end_date - timedelta(days=30)
# data = yf.download(tickers=tickers, start=start_date, end=end_date, interval='1d', group_by='ticker')

# TEMP SAVE BLOCK
store = pd.HDFStore('data.h5')
# store['data'] = data
data = store['data']

# Calculate RSI
rsi = {}

for symbol in tickers:
    try:
        RSI = talib.RSI(data[(symbol, 'Close')])[-1]

        rsi[symbol] = RSI
    except:
        continue
# print(rsi)
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


# Purcase & Sell from Alpaca

# Buy/Sell stocks, returns 1 if successfull
def place_order(symbol, side='buy', qty=1): 
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
		return 0
	return 1

# Buy stocks deem to be purchased and modify currentHoldings
for tick in to_buy:
	place_order(tick)

# Sell stock deemed to be sold if in portfolio
for position in portfolio:
	if position.symbol in to_sell:
		place_order(position.symbol, side='sell', qty=position.qty)


	
