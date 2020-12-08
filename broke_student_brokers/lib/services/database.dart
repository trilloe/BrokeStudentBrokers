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

  Future updateUserData(int balance, bool botState, List cumulativeCurrentValue,
      List currentHoldings, List orders, Map userDetails) async {
    return await stockCollection.doc(uid).set({
      'balance': balance,
      'botState': botState,
      'cumulativeCurrentValue': cumulativeCurrentValue,
      'currentHoldings': currentHoldings,
      'orders': orders,
      'userDetails': userDetails
    });
  }

  // stocks list from snapshot
  List<Stocks> _stocksListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Stocks(
        balance: doc.data()['balance'] ?? 500,
        botState: doc.data()['botState'] ?? true,
        cumulativeCurrentValue: doc.data()['cumulativeCurrentValue'] ?? [],
        currentHoldings: doc.data()['currentHoldings'] ?? [],
        orders: doc.data()['orders'] ?? [],
        userDetails: doc.data()['userDetails'] ?? {},
      );
    }).toList();
  }

  // get stocks stream
  Stream<List<Stocks>> get stocks {
    return stockCollection.snapshots().map(_stocksListFromSnapshot);
  }
}
