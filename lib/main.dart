import 'package:flutter/material.dart';
import 'package:todoey_flutter/screens/cashout_screen.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/cashout_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CashoutManager>(
      builder: (context) => CashoutManager(),
      child: MaterialApp(
        home: CashoutScreen(),
      ),
    );
  }
}
