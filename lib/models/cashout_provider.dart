// CashoutProvider
// - responsible of managing the sqflite persisting operations

import 'package:sqflite/sqflite.dart';
import 'package:todoey_flutter/models/cashout.dart';
import 'package:path/path.dart';

final String tableCashout = 'cashouts';
final String columnId = '_id';
final String columnAmount = 'amount';
final String columnNote = 'note';
final String columnDate = 'date';

class CashoutProvider {
  Database _db;

  // Create DB
  Future _open({String name = 'cashouts.db'}) async {
    if (_db == null || !_db.isOpen) {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, name);
      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
          create table $tableCashout ( 
          $columnId integer primary key autoincrement, 
          $columnAmount double not null,
          $columnNote text not null,
          $columnDate int not null)
        ''');
        },
      );
    }
    print(_db);
  }

  // READ cashout from startingDateInMilliseconds
  Future<List<Cashout>> getCashouts({int startingDateInMilliseconds}) async {
    await _open();
    List<Map<String, dynamic>> savedCashouts = await _db.query(tableCashout,
        columns: [columnId, columnAmount, columnNote, columnDate],
        where:
            '$columnDate > ${DateTime.now().millisecondsSinceEpoch - startingDateInMilliseconds}');
    List<Cashout> cashouts = [];
    if (savedCashouts.length > 0) {
      for (var cashoutSaved in savedCashouts) {
        Cashout cashout = Cashout.fromMap(cashoutSaved);
        cashouts.add(cashout);
      }
    }
    await close();
    return cashouts;
  }

  // CREATE
  Future<int> insert(Cashout cashout) async {
    await _open();
    cashout.id = await _db.insert(tableCashout, cashout.toMap());
    await close();
    return cashout.id;
  }

  // UPDATE
  Future<int> update(Cashout cashout) async {
    await _open();
    int result = await _db.update(tableCashout, cashout.toMap(),
        where: '$columnId = ?', whereArgs: [cashout.id]);
    await close();
    return result;
  }

  // DELETE
  Future<int> delete(int id) async {
    await _open();
    int result =
        await _db.delete(tableCashout, where: '$columnId = ?', whereArgs: [id]);
    await close();
    return result;
  }

  // Close DB
  Future close() async => _db.close();
}
