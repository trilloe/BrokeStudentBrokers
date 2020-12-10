#!/usr/bin/env python3 
from logic import filter_RSI, get_data_month, place_order, alpaca_connection 

import pickle

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# from get_all_tickers import get_tickers as gt
import alpaca_trade_api as tradeapi
from numpy.lib.npyio import load

import pandas as pd
import numpy as np


APCA_API_BASE_URL = "https://paper-api.alpaca.markets"


# Initializing Firestore
cred = credentials.Certificate('service_account.json')
firebase_admin.initialize_app(cred)

db = firestore.client()

# Get all Tickers
# tickers = list(gt.get_tickers(NYSE=True, NASDAQ=True, AMEX=True))
f = load('tickers','rb')
tickers = pickle.load(f)
f.close()


# Get Data for the past 30 days for all tickers
data = get_data_month(tickers=tickers)

print(data)

# store = pd.HDFStore('data.h5')
# # store['new_data'] = data

# data = store['new_data']

last_empty = True

for symbol in tickers:
            if np.isnan(data[(symbol, 'Close')].iloc[-1]) == False:
                last_empty = False
                break

if last_empty:
    data.drop(data.tail(1).index,inplace=True)



# Calculating RSI for the DataFrame and Filtering Tickers based Upon RSI Conditions
to_buy, to_sell = filter_RSI(tickers=tickers, data=data)

print(to_buy)
print(to_sell)


# Running Script for Every User in the Database
user_collection = db.collection(u'testStocks')
user_references = user_collection.stream()

for user in user_references:

    try:
        # Create Reference To User's Document

        doc_ref = user_collection.document(user.id)
        doc_dict =  doc_ref.get().to_dict()

        if doc_dict['botState'] == True:

            print("Running Script for {0}".format(user.id))


            # Get Information about User
            maximum_spendable_amount = doc_dict['balance']
            currentHoldings = doc_dict['currentHoldings']
            userDetails = doc_dict['userDetails']

            # Use Alpacca API
            api = alpaca_connection(userDetails['API_KEY'],userDetails['API_SECRET'])
            portfolio = api.list_positions()

            # Buy stocks deem to be purchased and modify currentHoldings
            for tick in to_buy:

                print(tick)

                # TODO : Write if condition to check if current price of Stock 
                # is < maximum_spendable_amount
                currentPrice = api.get_last_quote(tick).__dict__['_raw']['bidprice']

                print(currentPrice)

                # Checks if customer has balance
                if (maximum_spendable_amount >= currentPrice):

                    print("Buyable")
                    # Places order with Alpaca
                    place_order(api,tick, side='buy', qty=1)

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

            # print(currentHoldings)
            # print(list_orders)

            doc_ref.update({
                'currentHoldings':currentHoldings,
                'balance': float(api.get_account().__dict__['_raw']['buying_power']),
                'orders': list_orders 
                })
        
        else:
            print("Skipped : {0}".format(user.id))
            continue

    except Exception as e:
        print('Error for {0}'.format(user.id))
        print(e)
    