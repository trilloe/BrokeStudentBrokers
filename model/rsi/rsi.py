import datetime
import yfinance as yf
import pandas as pd


tickers = pd.read_csv('tickerlist.csv')
# print(list(tickers['Symbol']))

# If you want to grab multiple stocks add more labels to this list
stocks = list(tickers['Symbol'])[:10]
# Set start and end dates
start = datetime.datetime(2020, 11, 20)
end =  datetime.datetime(2020, 11, 23)
# Grab data
# data = yf.download(stocks, start=start, end=end)

print(yf.download(tickers=stocks, start=start, end=end, group_by='ticker'))

# rsi_period = 14
# change = data['Close'].diff(1)
# gain = change.mask(change < 0, 0)
# data['gain'] = gain
# loss = change.mask(change > 0, 0)
# data['loss'] = loss

# avg_gain = gain.ewm(com=rsi_period - 1, min_periods=rsi_period).mean()
# avg_loss = loss.ewm(com=rsi_period - 1, min_periods=rsi_period).mean()

# data['avg_gain'] = avg_gain
# data['avg_loss'] = avg_loss

# rs = abs(avg_gain/avg_loss)
# rsi = 100 - (100 / (1 + rs))

# data['rsi'] = rsi
# print(data)
