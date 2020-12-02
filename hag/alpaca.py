import alpaca_trade_api as tradeapi
import threading

from numpy.lib.function_base import place

API_KEY = 'PKQVV0XBE9EL7L873JAH'
API_SECRET = '4YWpFeBVSxjGcMKsemrLHjMkY7yXgLWSW9KvVbTv'
APCA_API_BASE_URL = "https://paper-api.alpaca.markets"

api = tradeapi.REST(API_KEY, API_SECRET, base_url=APCA_API_BASE_URL) 
account = api.get_account()
pos = api.list_positions()

def place_order(): # Buy/Sell stocks
	try:
		place_order = api.submit_order(
			symbol = 'AMZN',
			qty = 5,
			side = 'buy',
			type = 'market',
			time_in_force = 'day'
		)
		print(place_order)
	except:
		print("Something went wrong")
		return 0
	print("Successful")
	return 1

print(place_order())



