import 'package:flutter/material.dart';
import 'package:todoey_flutter/models/cashout_provider.dart';
import 'package:todoey_flutter/models/cashout.dart';
import 'package:todoey_flutter/utilities/update_manager.dart';
import 'dart:core';

// Instance of the object responsible of persisting data
CashoutProvider cashoutProvider = CashoutProvider();

// Instance of the object responsible of updating the counters
UpdateManager updateManager = UpdateManager();

class AddCashoutScreen extends StatefulWidget {
  @override
  _AddCashoutScreenState createState() => _AddCashoutScreenState();
}

class _AddCashoutScreenState extends State<AddCashoutScreen> {
  TextEditingController amountEditingController = TextEditingController();
  TextEditingController noteEditingController = TextEditingController();
  double amount = 0.0;
  String note = '';
  bool isAmountDouble = true;
  String warningMessage = '';

  // Checks if a string has numeric type
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return (double.tryParse(s) != null);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'New cashout',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              'Amount (€)',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 22.0,
                color: Colors.black87,
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            TextField(
              controller: amountEditingController,
              // Tap resets the warning message to empty string
              onTap: () {
                setState(() {
                  warningMessage = '';
                });
              },
              onChanged: (value) {
                amount = double.tryParse(value) ?? 0.0;
                // Flag to be sure user has inserted a numeric value
                isAmountDouble = isNumeric(value);
              },
              decoration: InputDecoration(
                hintText: 'How much was the cashout?',
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.deepPurpleAccent, width: 1.5),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.deepPurpleAccent, width: 2.5),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              'Note',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 22.0,
                color: Colors.black87,
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            TextField(
              controller: noteEditingController,
              onChanged: (value) {
                note = value;
              },
              decoration: InputDecoration(
                hintText: 'What was it about?',
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.deepPurpleAccent, width: 1.5),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.deepPurpleAccent, width: 2.5),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              padding: EdgeInsets.only(top: 14.0, bottom: 14.0),
              onPressed: () async {
                // Check if user has inputted a number
                if (isAmountDouble) {
                  // Create new cashout object
                  Cashout cashout = Cashout(
                    amount: amount,
                    note: note,
                    date: DateTime.now().millisecondsSinceEpoch,
                  );
                  int _ = await cashoutProvider.insert(cashout);
                  noteEditingController.clear();
                  amountEditingController.clear();
                  await updateManager.updateCounters(context);
                  Navigator.pop(context);
                } else {
                  // User has not inputted a valid amount -> warning
                  setState(() {
                    warningMessage = 'Please enter a valid amount';
                  });
                }
              },
              color: Colors.deepPurpleAccent,
              child: Text(
                'Add cashout',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              warningMessage,
              style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0),
            )
          ],
        ),
      ),
    );
  }
}
