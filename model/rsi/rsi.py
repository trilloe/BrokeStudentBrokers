import datetime
import yfinance as yf
import pandas as pd

import json

# tickers = pd.read_csv('model/rsi/tickerlist.csv')
# # print(list(tickers['Symbol']))

# # If you want to grab multiple stocks add more labels to this list
# stocks = list(tickers['Symbol'])
# # print(stocks)
# # Set start and end dates
# start = datetime.datetime(2020, 11, 1)
# end =  datetime.datetime(2020, 11, 30)
# # Grab data
# # data = yf.download(stocks, start=start, end=end)
# store = pd.HDFStore('model/rsi/store.h5')
# # store['data'] = data
# data = store['data']
# data = data['Close']
# print(data)
# print(yf.download(tickers=stocks, start=start, end=end, group_by='ticker'))

store = pd.HDFStore('store.h5')
data = store['data']

# rsi = pd.DataFrame()
rsi_period = 14
rsi_per_ticker = {}
for key in data['Adj Close']:
    temp =  data['Adj Close', key][-2:-rsi_period-3:-1]
    change = temp.diff(1)
    gain = change.mask(change < 0, 0)
    loss = change.mask(change > 0, 0)

    avg_gain = gain.ewm(com=rsi_period - 1, min_periods=rsi_period).mean()
    avg_loss = loss.ewm(com=rsi_period - 1, min_periods=rsi_period).mean()

    rs = abs(avg_gain/avg_loss)[-1]
    rsi = 100 - (100 / (1 + rs))

    rsi_per_ticker[key] = rsi
# for key in data.keys():
#     print(data[key])
#     rsi_period = 14
#     change = data[key].diff(1)
#     gain = change.mask(change < 0, 0)
#     data[key, 'gain'] = gain
#     loss = change.mask(change > 0, 0)
#     data[key, 'loss'] = loss

#     avg_gain = gain.ewm(com=rsi_period - 1, min_periods=rsi_period).mean()
#     avg_loss = loss.ewm(com=rsi_period - 1, min_periods=rsi_period).mean()

#     data[key, 'avg_gain'] = avg_gain
#     data[key, 'avg_loss'] = avg_loss

#     rs = abs(avg_gain/avg_loss)
#     rsi = 100 - (100 / (1 + rs))

#     data[key]['rsi'] = rsi
# data['COR']['rsi'] = 1
# print(data)
print(rsi_per_ticker)


with open('rsi_per_ticker.json', 'w') as file:
     file.write(json.dumps(rsi_per_ticker))
