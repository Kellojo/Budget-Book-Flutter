import 'package:budget_book/models/Transaction.dart';
import 'package:budget_book/service/AuthService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionsService {

  static createTransaction(BPTransaction transaction) async {
    String userId = await AuthService.getUserUID();
    await Firestore.instance.collection("transactions/" + userId + "/synchronizable").add(transaction.toMap());
  }

  static updateTransaction(BPTransaction transaction) async {
    assert(transaction.id != null && transaction.id != "");
    String userId = await AuthService.getUserUID();
    await Firestore.instance.collection("transactions/" + userId + "/synchronizable").document(transaction.id).setData(transaction.toMap(), merge: false);
  }
}