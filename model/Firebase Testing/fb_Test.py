from threading import currentThread
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import datetime
import alpaca_trade_api as tradeapi

# Use a service account
cred = credentials.Certificate('./service-account.json')
firebase_admin.initialize_app(cred)

db = firestore.client()


doc_ref = db.collection(u'testStocks').document(u'John Doe')

# print(doc_ref.get().to_dict())

# doc_ref.set({
#     'balance': 500,
#     'botState': False,
#     'cumulativeCurrentValue' : [{'currentValue' : 120, 'date': datetime.datetime.now()}, {'currentValue' : 124, 'date': datetime.datetime.now()}],
#     'currentHoldings' : [{'countStock' : 1, 'initialValue' : 100, 'ticker': 'AMZN'}],
#     'orders' : [{'ticker' : 'TSLA', 'timestamp': datetime.datetime.now()}],
#     'userDetails' : {'email':'john@gmail.com','name':'John Doe','phone':'+91 8860599488'}
# })

# # doc_ref.update({})

# doc = doc_ref.get()
# dicties =  doc.to_dict()
# ch = dicties['currentHoldings']
# ch.append({'countStock' : 1, 'initialValue' : 490, 'ticker': 'FB'})

# print(doc_ref.update({'currentHoldings':ch}))



# Update Order Section

API_KEY = 'PKQVV0XBE9EL7L873JAH'
API_SECRET = '4YWpFeBVSxjGcMKsemrLHjMkY7yXgLWSW9KvVbTv'
APCA_API_BASE_URL = "https://paper-api.alpaca.markets"

api = tradeapi.REST(API_KEY, API_SECRET, base_url=APCA_API_BASE_URL) 
account = api.get_account()
pos = api.list_positions()

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
		return(place_order)
	except:
		print("Something went wrong")
		return 0
	# print("Successful")
	# return 1

order_deets = place_order('AMZN','buy')

doc = doc_ref.get()
dicties =  doc.to_dict()
orders = dicties['orders']
orders.append(order_deets.__dict__['_raw'])
print(doc_ref.update({'orders':orders}))

