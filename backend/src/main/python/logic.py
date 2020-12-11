import alpaca_trade_api as tradeapi

from datetime import datetime, timedelta
# from get_all_tickers import get_tickers as gt
import yfinance as yf

import talib

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore


# Returns api object connected to alpaca paper trading account
def alpaca_connection(API_KEY='PKQVV0XBE9EL7L873JAH', API_SECRET='4YWpFeBVSxjGcMKsemrLHjMkY7yXgLWSW9KvVbTv'):
    APCA_API_BASE_URL = "https://paper-api.alpaca.markets"

    api = tradeapi.REST(API_KEY, API_SECRET, base_url=APCA_API_BASE_URL) 
    return api

# Obtain data for past 30 days for all tickers
def get_data_month(tickers):
    end_date = datetime.today()
    start_date = end_date - timedelta(days=30)
    data = yf.download(tickers=tickers, start=start_date, end=end_date, interval='1d', group_by='ticker')

    return data

# Calculate RSI for DataFrame
def calculate_RSI(tickers, data):
    rsi = {}

    for symbol in tickers:
        try:
            RSI = talib.RSI(data[(symbol, 'Close')])[-1]

            rsi[symbol] = RSI
        except:
            continue

    return rsi

# Filter based on RSI conditions, returns to_buy and to_sell
def filter_RSI(tickers, data):
    rsi = calculate_RSI(tickers, data)

    to_buy = []
    to_sell = []
    for symbol in rsi.keys():
        if rsi[symbol] <= 30:
            to_buy.append(symbol)
        if rsi[symbol] >= 70:
            to_sell.append(symbol)

    return (to_buy, to_sell)


# Buy/Sell stocks, returns 1 if successfull
def place_order(api, symbol, side='buy', qty=1): 
	try:
		place_order = api.submit_order(
			symbol = symbol,
			qty = qty,
			side = side,
			type = 'market',
			time_in_force = 'day'
		)
	except:
		return 0
	return 1





