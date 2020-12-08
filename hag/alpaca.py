import alpaca_trade_api as tradeapi
import threading

from numpy.lib.function_base import place

API_KEY = 'PKQVV0XBE9EL7L873JAH'
API_SECRET = '4YWpFeBVSxjGcMKsemrLHjMkY7yXgLWSW9KvVbTv'
APCA_API_BASE_URL = "https://paper-api.alpaca.markets"

api = tradeapi.REST(API_KEY, API_SECRET, base_url=APCA_API_BASE_URL) 
account = api.get_account()
portfolio = api.list_positions()

print('account: {0}\n\n'.format(account))
# print('pos: {0}\n\n'.format(pos))

for position in portfolio:
    print("{} shares of {}".format(position.qty, position.symbol))

'2359938f-e963-4b98-a2ae-ac9573f4d5e1'

def place_order(): # Buy/Sell stocks
	try:
		place_order = api.submit_order(
			symbol = 'AAPL',
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

# print(place_order())

# Get the last 100 of our closed orders
closed_orders = api.list_orders(
    status='all',
    limit=100,
    nested=True  # show nested multi-leg orders
)

closed_orders = [i.__dict__["_raw"] for i in closed_orders]


# closed_aapl_orders = [o for o in closed_orders if o.symbol == 'AAPL']
# print('\n\n\n\n\n\n\n\n')
# print(closed_orders)
# print(len(closed_orders))

print


