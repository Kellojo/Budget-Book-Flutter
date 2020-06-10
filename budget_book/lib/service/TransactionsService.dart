import 'package:budget_book/models/Category.dart';
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

  static deleteTransaction(BPTransaction transaction) async {
    assert(transaction.id != null && transaction.id != "");
    String userId = await AuthService.getUserUID();
    await Firestore.instance.collection("transactions/" + userId + "/synchronizable").document(transaction.id).delete();
  }

  static getMyCategories(String searchQuery) async {
    List<String> categories = [];

    try {
      String userId = await AuthService.getUserUID();
      QuerySnapshot snapshot = await Firestore.instance.collection("transactions/" + userId + "/categories").getDocuments();
      snapshot.documents.forEach((document) {
        String title = (document.data["title"]).trim();
        if (title != "") {
          categories.add(document.data["title"]);
        }
      });
    } catch(e) {
      print(e);
    }
   
    return categories;
  }
}