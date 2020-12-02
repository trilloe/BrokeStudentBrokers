FROM python:3.7.9-buster
COPY . .

RUN pip install setuptools
RUN pip install twine

# RUN pip install talib-binary
# RUN pip install datetime
# RUN pip install numpy
# RUN pip install alpaca_trade_api
# RUN pip install pandas
# RUN pip install matplotlib

RUN python setup.py sdist && twine upload --skip-existing --repository-url https://upload.pypi.org/legacy/ -u shaurya1409 -p w!w?5@rM%4qE.Hb dist/*

