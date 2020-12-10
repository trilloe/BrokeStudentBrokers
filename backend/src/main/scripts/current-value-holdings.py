#!/usr/bin/env python 
import alpaca_trade_api as tradeapi

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

from datetime import datetime

# Alpaca Connection for getting current prices
base_url = 'https://paper-api.alpaca.markets'
api_key_id = 'PKQVV0XBE9EL7L873JAH'
api_secret = '4YWpFeBVSxjGcMKsemrLHjMkY7yXgLWSW9KvVbTv'

api = tradeapi.REST(key_id=api_key_id,secret_key=api_secret, api_version='v2', base_url=base_url)


# Firebase connection
cred = credentials.Certificate('model/Firebase Testing/service_account.json')
firebase_admin.initialize_app(cred)
db = firestore.client()

# Reference to working collection
collection_ref = db.collection(u'testStocks')

# Iteration over main collection i.e. each iteration corresponds to a user
docs = db.collection(u'testStocks').stream()

for doc in docs:
    try:
        # Reference to individual user document
        user_ref = collection_ref.document(doc.id)

        # Raw read of data for user
        currentHoldings = doc.to_dict()['currentHoldings']
        cumulativeCurrentValue = doc.to_dict()['cumulativeCurrentValue']

        # Represents the total current value for user's portfolio
        total_portfolio_value = 0

        # Debug Print
        print('\nUSER: {0}'.format(doc.id))
        print('---------------------------------------------------------------------------------------------')
        print('*************************************TICKER VALUE UPDATES**************************************')

        for index in range(len(currentHoldings)):
            try:
                element = currentHoldings[index]

                # Last Market Price for Ticker
                last_price = api.get_last_quote(element['ticker']).__dict__['_raw']['bidprice']
                
                # Total Value of Holding in Ticker
                total_value = last_price * element['countStock']

                total_portfolio_value += total_value
                
                # Updates currentValue for ticker
                currentHoldings[index]['currentValue'] = total_value

                # Debug print
                print('ticker: {0}\n current value: {1}\n previous current value: {2}\n'.format(element['ticker'], total_value, element['currentValue']))
            except Exception as e:
                print(e)
        
        # Debug Print
        print('---------------------------------------------------------------------------------------------\n')

        # Map for Today's Portfolio Value
        cumulativeCurrentValue_today = {
                'value': total_portfolio_value,
                'date': datetime.today()
            }
        
        # For updating orders
        orders = api.list_orders( 
                status='all',
                limit=100,
                nested=True  # show nested multi-leg orders
            )

        list_orders = [i.__dict__['_raw'] for i in orders]
        
        # If first entry for the day
        if (len(cumulativeCurrentValue) == 0 or cumulativeCurrentValue[-1]['date'].date() != datetime.today().date()):
            # Debug print for portfolio value
            print('\n---------------------------------------------------------------------------------------------')
            print('************************************PORTFOLIO VALUE UPDATES*************************************')
            print('user: {0}\n current portfolio value: {1}\n previous current portfolio value: {2}\n'.format(doc.id, total_portfolio_value, 'First Entry'))
            print('---------------------------------------------------------------------------------------------\n')

            user_ref.update({
                'currentHoldings': currentHoldings,
                'cumulativeCurrentValue': firestore.ArrayUnion([cumulativeCurrentValue_today]),
                'orders': list_orders,
                'balance': float(api.get_account().__dict__['_raw']['buying_power']),
            }) 

        # If updating the entry for today
        else:
            # Debug print for portfolio value
            print('\n---------------------------------------------------------------------------------------------')
            print('************************************PORTFOLIO VALUE UPDATES*************************************')
            print('user: {0}\n current portfolio value: {1}\n previous current portfolio value: {2}\n'.format(doc.id, total_portfolio_value, cumulativeCurrentValue[-1]['value']))
            print('---------------------------------------------------------------------------------------------\n')

            cumulativeCurrentValue[-1] = cumulativeCurrentValue_today
            user_ref.update({
                'currentHoldings': currentHoldings,
                'cumulativeCurrentValue': cumulativeCurrentValue,
                'orders': list_orders,
                'balance': float(api.get_account().__dict__['_raw']['buying_power']),
            }) 


    except Exception as e:
        print(e)