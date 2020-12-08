import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:broke_student_brokers/pages/models/stocks.dart';

class StocksList extends StatefulWidget {
  @override
  _StocksListState createState() => _StocksListState();
}

class _StocksListState extends State<StocksList> {
  @override
  Widget build(BuildContext context) {
    final stocks = Provider.of<List<Stocks>>(context);

    // stocks.forEach((stock) {
    //   print(stock.currentHoldings);
    //   print(stock.initialHoldings);
    //   print(stock.shareCount);
    //   print(stock.ticker);
    //   print(stock.userName);
    // });

    return Container();
  }
}
