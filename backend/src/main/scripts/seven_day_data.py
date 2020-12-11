from threading import currentThread
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from datetime import datetime, timedelta
import alpaca_trade_api as tradeapi

import yfinance as yf

# Use a service account
cred = credentials.Certificate('service_account.json')
firebase_admin.initialize_app(cred)

db = firestore.client()

collection_ref = db.collection(u'testStocks')
docs = db.collection(u'testStocks').stream()

# Finds last 7 day data for all tickers and writes
for doc in docs:

    user_ref = collection_ref.document(doc.id)
    currentHoldings = doc.to_dict()['currentHoldings']
    
    for index in range(len(currentHoldings)):
        element = currentHoldings[index]

        data = yf.download(element['ticker'], period='1mo')
        last_7days = data.tail(7)['Close'].to_list()

        currentHoldings[index]['last_7days'] = last_7days

    user_ref.update({
            'currentHoldings': currentHoldings,
        }) 
