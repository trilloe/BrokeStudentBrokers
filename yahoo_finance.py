# market data on Cryptocurrencies, regular currencies, stocks and bonds, fundamental and options data, and market analysis and news
# two modules - stock_info and options

from yahoo_fin.stock_info import get_data
amazon_weekly= get_data("amzn", start_date="01/01/2019", 
end_date="11/01/2020", index_as_date = True, interval="1wk")
print(amazon_weekly)





