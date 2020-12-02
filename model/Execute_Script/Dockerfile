FROM python:3.7.9-buster

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY Get_Buy_Sell.py .
CMD ["python", "Get_Buy_Sell.py"]