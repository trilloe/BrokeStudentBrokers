import matplotlib.pyplot as plt
from datetime import datetime
import numpy as np
import pandas as pd
from pandas.core.frame import DataFrame
import ta
import alpaca_trade_api as tradeapi
import threading


base_url = 'https://paper-api.alpaca.markets'
api_key_id = 'PKQVV0XBE9EL7L873JAH'
api_secret = '4YWpFeBVSxjGcMKsemrLHjMkY7yXgLWSW9KvVbTv'

api = tradeapi.REST(key_id=api_key_id, secret_key=api_secret, api_version='v2', base_url=base_url)


# print(api.list_positions())

arrays = [np.array(['bar', 'bar', 'baz', 'baz', 'foo', 'foo', 'qux', 'qux']), np.array(['one', 'two', 'one', 'two', 'one', 'two', 'one', 'two'])]



# ws_url = 'wss://data.alpaca.markets'

# conn = tradeapi.stream2.StreamConn(
#     api_key_id, api_secret, base_url=base_url, data_url=ws_url, data_stream='alpacadatav1'
# )


# print("So Far So Good")

# @conn.on(r'^T.AAPL$')
# async def trade_info(conn, channel, bar):
#     # print('bars', bar)
#     print(bar._raw)

# @conn.on(r'^AM.AAPL$')
# async def on_minute_bars(conn, channel, bar):
#     # print('bars', bar)
# 	print(bar._raw)

# conn.run(['AM.AAPL'])

