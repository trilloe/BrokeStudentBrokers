import pandas as pd
import datetime
import yfinance as yf
import get_all_tickers.get_tickers as gt


# https://github.com/shilewenuw/get_all_tickers
tickers = gt.get_tickers(NYSE=True, NASDAQ=True, AMEX=True)
# tickers = gt.get_biggest_n_tickers(500)


store = pd.HDFStore('store.h5')

# data = store['data']
# print(data)


# # Write Data
# # tickers = pd.read_csv('model/rsi/tickerlist.csv')
# # stocks = list(tickers['Symbol'])

# # start = datetime.datetime(2020, 11, 20)
# # end =  datetime.datetime(2020, 11, 20)
data = yf.download(tickers=tickers, period='1mo', interval='1d')

# # rsi_period = 14
# # change = data.diff(1)
# # gain = change.mask(change < 0, 0)
# # data['gain'] = gain
# # loss = change.mask(change > 0, 0)
# # data['loss'] = loss
# data.drop(['Open', 'High', 'Low', 'Close'], axis=1, level=1, inplace=True)
# # print(data)
data.drop(['Open', 'High', 'Low', 'Close'], axis=1, inplace=True)
store['data'] = data

print(data)