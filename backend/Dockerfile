FROM python:3.7.9-buster

COPY service_account.json .

RUN pip install talib-binary
RUN pip install --upgrade firebase-admin
RUN pip install --upgrade --no-cache-dir bsb_backend_pack

CMD ["driver.py"]