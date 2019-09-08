import 'package:flutter/material.dart';
import 'package:todoey_flutter/widgets/total_cashout_widget.dart';
import 'package:todoey_flutter/screens/add_cashout_screen.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/cashout_manager.dart';
import 'package:todoey_flutter/models/cashout_provider.dart';
import 'package:todoey_flutter/utilities/update_manager.dart';
import 'package:todoey_flutter/constants.dart';

// Instance of the object responsible of persisting data
CashoutProvider cashoutProvider = CashoutProvider();
// Instance of the object responsible of managing the widgets state
CashoutManager cashoutManager = CashoutManager();
// Instance of the object responsible of updating the counters
UpdateManager updateManager = UpdateManager();

class CashoutScreen extends StatefulWidget {
  @override
  _CashoutScreenState createState() => _CashoutScreenState();
}

class _CashoutScreenState extends State<CashoutScreen> {
  @override
  void initState() {
    super.initState();
    // Before building the widget: ask cashout manager to update the counters
    updateManager.updateCounters(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddCashoutScreen(),
            // This pushes the Bottom Sheet to cover the whole screen
            isScrollControlled: true,
          );
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.deepPurpleAccent,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0, bottom: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30.0,
                child: Icon(
                  Icons.euro_symbol,
                  color: Colors.deepPurpleAccent,
                  size: 30.0,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Cashout',
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Keep track of your cash',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 40.0,
              ),
              TotalCashoutWidget(
                title: '24h',
                totalAmount: Provider.of<CashoutManager>(context).amountDaily,
                cashoutType: CashoutType.daily,
              ),
              SizedBox(height: 10.0),
              TotalCashoutWidget(
                title: '7 days',
                totalAmount: Provider.of<CashoutManager>(context).amountWeekly,
                cashoutType: CashoutType.weekly,
              ),
              SizedBox(height: 10.0),
              TotalCashoutWidget(
                title: '30 days',
                totalAmount: Provider.of<CashoutManager>(context).amountMonthly,
                cashoutType: CashoutType.monthly,
              )
            ],
          ),
        ),
      ),
    );
  }
}
