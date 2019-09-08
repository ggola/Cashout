import 'package:flutter/material.dart';
import 'package:todoey_flutter/screens/cashout_details.dart';
import 'package:todoey_flutter/constants.dart';

class TotalCashoutWidget extends StatelessWidget {
  TotalCashoutWidget(
      {@required this.title,
      @required this.totalAmount,
      @required this.cashoutType});
  final String title;
  final double totalAmount;
  final CashoutType cashoutType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: MaterialButton(
        height: 80.0,
        minWidth: double.infinity,
        elevation: 10.0,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CashoutDetails(
                        cashoutType: cashoutType,
                      )));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  color: Colors.deepPurpleAccent,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600),
            ),
            Container(
              width: 190.0,
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Colors.deepPurpleAccent,
              ),
              child: Text(
                '$totalAmount€',
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 33.0,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
