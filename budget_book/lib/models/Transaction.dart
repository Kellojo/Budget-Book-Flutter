
import 'package:cloud_firestore/cloud_firestore.dart';

class BPTransaction {
  String id;
  String title;
  double amount;
  String type;
  String category;
  DateTime occurredOn;
  bool isTransactionCompleted;

  BPTransaction({this.id, this.title, this.amount, this.type, this.category, this.occurredOn, this.isTransactionCompleted = true});

  static fromMap(DocumentSnapshot document) {
    return BPTransaction(
      id: document.documentID,
      title: document["title"],
      amount: document["amount"],
      category: document["category"],
      type: document["type"],
      isTransactionCompleted: document["isTransactionCompleted"],
      occurredOn: DateTime.fromMillisecondsSinceEpoch(document["occurredOn"].seconds * 1000),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> _map = Map();
    _map["type"] = type;
    _map["title"] = title;
    _map["amount"] = amount;
    _map["category"] = category;
    _map["occurredOn"] = occurredOn;
    _map["isTransactionCompleted"] = isTransactionCompleted;

    return _map;
  }
}