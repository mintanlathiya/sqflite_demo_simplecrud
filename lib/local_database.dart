import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo_simplecrud/user_modal.dart';

class Localdatabase {
  static const String _userDb = 'user.db';
  static const String _userMst = 'user_mst';

  static Future<Database> get openDb async {
    return await openDatabase(
      join(await getDatabasesPath(), _userDb),
      version: 1,
      onCreate: (db, version) => db.execute(
          'CREATE TABLE $_userMst (id INTEGER PRIMARY KEY, fName TEXT NOT NULL,mName TEXT NOT NULL,lName TEXT NOT NULL)'),
    );
  }

  static Future<void> insertdata(UserDetailModel userDetailModel) async {
    final db = await openDb;
    db.insert(_userMst, userDetailModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
