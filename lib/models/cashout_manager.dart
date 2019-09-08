// Cashout Manager
// - extension of ChangeNotifier class
// - notifies listeners about changes occurring to the state of its variables

import 'package:flutter/material.dart';
import 'package:todoey_flutter/models/cashout.dart';
import 'dart:collection';

class CashoutManager extends ChangeNotifier {
  double _totalCashoutDaily;
  double _totalCashoutWeekly;
  double _totalCashoutMonthly;
  List<Cashout> _cashouts = [];

  // Returns list of cashouts (UnmodifiableListView comes form 'dart:collection')
  UnmodifiableListView<Cashout> get cashouts {
    return UnmodifiableListView(_cashouts);
  }

  // Returns cashouts retrieved from DB
  void addCashouts(List<Cashout> retrievedCashouts) {
    _cashouts = retrievedCashouts;
    notifyListeners();
  }

  // Removes cashout from list
  void removeCashout(Cashout cashout) {
    _cashouts.remove(cashout);
    notifyListeners();
  }

  // Returns total number of cashouts to show
  int get cashoutCount {
    return _cashouts.length;
  }

  // Receives the 24-h cashouts and computes total cashout
  void getTotalDaily(List<Cashout> cashouts) {
    _totalCashoutDaily = 0;
    for (Cashout cashout in cashouts) {
      _totalCashoutDaily = _totalCashoutDaily + cashout.amount;
    }
    notifyListeners();
  }

  // Receives the 7-day cashouts and computes total cashout
  void getTotalWeekly(List<Cashout> cashouts) {
    _totalCashoutWeekly = 0;
    for (Cashout cashout in cashouts) {
      _totalCashoutWeekly = _totalCashoutWeekly + cashout.amount;
    }
    notifyListeners();
  }

  // Receives the 30-day cashouts and computes total cashout
  void getTotalMonthly(List<Cashout> cashouts) {
    _totalCashoutMonthly = 0;
    for (Cashout cashout in cashouts) {
      _totalCashoutMonthly = _totalCashoutMonthly + cashout.amount;
    }
    notifyListeners();
  }

  // Returns the 24-h total amount
  double get amountDaily {
    return _totalCashoutDaily;
  }

  // Returns the 7-day total amount
  double get amountWeekly {
    return _totalCashoutWeekly;
  }

  // Returns the 30-day total amount
  double get amountMonthly {
    return _totalCashoutMonthly;
  }
}
