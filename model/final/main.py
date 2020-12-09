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
cred = credentials.Certificate('./service_account.json')
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


# Filter based on RSI conditions
to_buy = []
to_sell = []
for symbol in rsi.keys():
    if rsi[symbol] <= 30:
        to_buy.append(symbol)
    if rsi[symbol] >= 70: #and (rsi[symbol] in currentHoldings):
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



# Getting user details from firebase 
doc_ref = db.collection(u'testStocks').document(u'j8zxU61MJcR4O8iym6RAttESM2k1')
doc = doc_ref.get()
doc_dict =  doc.to_dict()

maximum_spendable_amount = doc_dict['balance']
currentHoldings = doc_dict['currentHoldings']

# Buy stocks deem to be purchased and modify currentHoldings
for tick in to_buy:
	# TODO : Write if condition to check if current price of Stock 
	# is < maximum_spendable_amount
	currentPrice = api.get_last_quote(tick).__dict__['_raw']['bidprice']

	# Checks if customer has balance
	if (maximum_spendable_amount >= currentPrice):
		# Places order with Alpaca
		place_order(tick, side='buy', qty=1)

		tickExists = False # If customer currently owns the ticker

		# If currently owned
		for holding in currentHoldings:
			if tick in holding.keys():
				holding['countStock'] += 1
				holding['initalValue'] += currentPrice
				tickExists = True
				break
		# If currently not owned
		if (tickExists == False):
			currentHoldings.append({
				'countStock' : 1,
				'initialValue' : currentPrice,
				'ticker': tick})

# Sell stock deemed to be sold if in portfolio
for position in portfolio:
	if position.symbol in to_sell:
		place_order(position.symbol, side='sell', qty=position.qty)

		for holding_index in range(len(currentHoldings)):
			if position.symbol in currentHoldings[holding_index].keys():
				currentHoldings.pop(holding_index)

orders = api.list_orders( 
	status='all',
    limit=100,
    nested=True  # show nested multi-leg orders
)

list_orders = [i.__dict__['_raw'] for i in orders]

doc_ref.update({
	'currentHolding':currentHoldings,
	'balance': float(api.get_account().__dict__['_raw']['buying_power']),
	'orders': list_orders 
	})

orders = api.list_orders(
	status='all',
	limit=10000,
	nested=True  # show nested multi-leg orders
)

list_orders = [i.__dict__['_raw'] for i in orders]