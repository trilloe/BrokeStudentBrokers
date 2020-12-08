import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:broke_student_brokers/pages/models/stocks.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference stockCollection =
      FirebaseFirestore.instance.collection("testStocks");
  // final CollectionReference userCollection =
  //     FirebaseFirestore.instance.collection("userProfile");

  Future updateUserData(int currentHoldings, int initialHoldings,
      int shareCount, String ticker, String userName) async {
    return await stockCollection.doc(uid).set({
      'currentHoldings': currentHoldings,
      'initialHoldings': initialHoldings,
      'shareCount': shareCount,
      'ticker': ticker,
      'userName': userName,
    });
  }

  // stocks list from snapshot
  List<Stocks> _stocksListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Stocks(
          currentHoldings: doc.data()['currentHoldings'] ?? 0,
          initialHoldings: doc.data()['initialHoldings'] ?? 100,
          shareCount: doc.data()['shareCount'] ?? 0,
          ticker: doc.data()['ticker'] ?? 'AMZN',
          userName: doc.data()['userName'] ?? 'default user');
    }).toList();
  }

  // get stocks stream
  Stream<List<Stocks>> get stocks {
    return stockCollection.snapshots().map(_stocksListFromSnapshot);
  }
}
