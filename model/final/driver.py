


doc_ref = db.collection(u'testStocks').document(user)
doc = doc_ref.get()
doc_dict =  doc.to_dict()

maximum_spendable_amount = doc_dict['balance']
currentHoldings = doc_dict['currentHoldings']

portfolio = api.list_positions()

# Buy stocks deem to be purchased and modify currentHoldings
for tick in to_buy:
    # TODO : Write if condition to check if current price of Stock 
    # is < maximum_spendable_amount
    currentPrice = api.get_last_quote(tick).__dict__['_raw']['bidprice']

    # Checks if customer has balance
    if (maximum_spendable_amount >= currentPrice):
        # Places order with Alpaca
        place_order(tick, side='buy', qty=1)

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

doc_ref.update({
    'currentHolding':currentHoldings,
    'balance': float(api.get_account().__dict__['_raw']['buying_power']),
    'orders': list_orders 
    })

orders = api.list_orders(
    status='all',
    limit=10000,
    nested=True  # show nested multi-leg orders
)

