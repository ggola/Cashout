import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CashoutItem extends StatelessWidget {
  CashoutItem(
      {@required this.dateInMilliseconds,
      @required this.amount,
      @required this.note,
      @required this.removeCashout});
  final int dateInMilliseconds;
  final double amount;
  final String note;
  final Function removeCashout;

  String getDate({int dateInMilliseconds}) {
    // Get message time in readable format
    DateTime date = DateTime.fromMillisecondsSinceEpoch(dateInMilliseconds);
    var format = DateFormat('d.M.y');
    return format.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: removeCashout,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            borderRadius: BorderRadius.all(Radius.circular(7.0))),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
        child: Row(
          children: <Widget>[
            Container(
              width: 70,
              child: Text(
                getDate(dateInMilliseconds: dateInMilliseconds),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(width: 5.0),
            Container(
              width: 80,
              child: Text(
                '$amount€',
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(width: 10.0),
            Text(
              note,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
