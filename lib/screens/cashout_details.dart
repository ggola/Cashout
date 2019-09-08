import 'package:flutter/material.dart';
import 'package:todoey_flutter/models/cashout_provider.dart';
import 'package:todoey_flutter/models/cashout.dart';
import 'package:todoey_flutter/constants.dart';
import 'package:todoey_flutter/widgets/cashout_item_widget.dart';
import 'package:todoey_flutter/models/cashout_manager.dart';
import 'package:todoey_flutter/utilities/update_manager.dart';
import 'package:provider/provider.dart';

// Instance of the object responsible of persisting data
CashoutProvider cashoutProvider = CashoutProvider();
// Instance of the object responsible of updating the counters
UpdateManager updateManager = UpdateManager();

class CashoutDetails extends StatefulWidget {
  CashoutDetails({@required this.cashoutType});
  final CashoutType cashoutType;
  @override
  _CashoutDetailsState createState() => _CashoutDetailsState();
}

class _CashoutDetailsState extends State<CashoutDetails> {
  String title;
  List<Cashout> cashouts = [];

  void initializeScreen() async {
    switch (widget.cashoutType) {
      case CashoutType.daily:
        {
          title = 'Your 24h cashouts';
          cashouts = await cashoutProvider.getCashouts(
              startingDateInMilliseconds: kStartingDateInMillisecondsDaily);
          Provider.of<CashoutManager>(context).addCashouts(cashouts);
        }
        break;
      case CashoutType.weekly:
        {
          title = 'Your 7-day cashouts';
          cashouts = await cashoutProvider.getCashouts(
              startingDateInMilliseconds: kStartingDateInMillisecondsWeekly);
          Provider.of<CashoutManager>(context).addCashouts(cashouts);
        }
        break;
      case CashoutType.monthly:
        {
          title = 'Your 30-day cashouts';
          cashouts = await cashoutProvider.getCashouts(
              startingDateInMilliseconds: kStartingDateInMillisecondsMonthly);
          Provider.of<CashoutManager>(context).addCashouts(cashouts);
        }
        break;
      default:
        {
          title = 'Error loading cashouts';
          cashouts =
              await cashoutProvider.getCashouts(startingDateInMilliseconds: 0);
          Provider.of<CashoutManager>(context).addCashouts(cashouts);
        }
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    initializeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
        child: Consumer<CashoutManager>(
          builder: (context, cashoutData, child) {
            return ListView.builder(
                itemCount: cashoutData.cashoutCount,
                itemBuilder: (context, index) {
                  Cashout cashout = cashoutData.cashouts[index];
                  return CashoutItem(
                    dateInMilliseconds: cashout.date,
                    amount: cashout.amount,
                    note: cashout.note,
                    removeCashout: () {
                      cashoutProvider.delete(cashout.id);
                      cashoutData.removeCashout(cashout);
                      updateManager.updateCounters(context);
                    },
                  );
                });
          },
        ),
      ),
    );
  }
}
