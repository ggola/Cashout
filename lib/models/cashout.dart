// Cashout object

import 'package:flutter/material.dart';
import 'package:todoey_flutter/models/cashout_provider.dart';

// Instance of sqflite persisting manager
CashoutProvider cashoutProvider = CashoutProvider();

final String columnId = '_id';
final String columnAmount = 'amount';
final String columnNote = 'note';
final String columnDate = 'date';

class Cashout {
  int id;
  double amount;
  String note;
  int date;

  Cashout(
      {this.id,
      @required this.amount,
      @required this.note,
      @required this.date});

  // Turn cashout to map to add it to DB
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnAmount: amount,
      columnNote: note,
      columnDate: date
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  // Retrieve data from cashout in map format
  Cashout.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    amount = map[columnAmount];
    note = map[columnNote];
    date = map[columnDate];
  }
}
