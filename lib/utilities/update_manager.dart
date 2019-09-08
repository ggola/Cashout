// Update manager
// - get daily, weekly, monthly cashouts and calls cashout manager to compute totals

import 'package:flutter/material.dart';
import 'package:todoey_flutter/constants.dart';
import 'package:todoey_flutter/models/cashout.dart';
import 'package:todoey_flutter/models/cashout_manager.dart';
import 'package:provider/provider.dart';

class UpdateManager {
  // Update the cashout counters
  Future updateCounters(BuildContext context) async {
    // Asks cashoutProvider to retrieve all the daily cashouts
    List<Cashout> cashoutsDaily = await cashoutProvider.getCashouts(
        startingDateInMilliseconds: kStartingDateInMillisecondsDaily);
    // Call the notifier provider to get the total daily cashout
    Provider.of<CashoutManager>(context).getTotalDaily(cashoutsDaily);

    List<Cashout> cashoutsWeekly = await cashoutProvider.getCashouts(
        startingDateInMilliseconds: kStartingDateInMillisecondsWeekly);
    Provider.of<CashoutManager>(context).getTotalWeekly(cashoutsWeekly);

    List<Cashout> cashoutsMonthly = await cashoutProvider.getCashouts(
        startingDateInMilliseconds: kStartingDateInMillisecondsMonthly);
    Provider.of<CashoutManager>(context).getTotalMonthly(cashoutsMonthly);
  }
}
