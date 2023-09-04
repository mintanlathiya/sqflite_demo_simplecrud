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
          'CREATE TABLE $_userMst (id INTEGER PRIMARY KEY,fName TEXT NOT NULL,mName TEXT NOT NULL,lName TEXT NOT NULL,gender TEXT NOT NULL,age DOUBLE NOT NULL)'),
    );
  }

  static Future<void> insertdata(UserDetailModel userDetailModel) async {
    final db = await openDb;
    db.insert(_userMst, userDetailModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<UserDetailModel>> selectData() async {
    final db = await openDb;
    List<Map<String, dynamic>> data = await db.query(_userMst);
    return List.generate(
        data.length, (index) => UserDetailModel.fromJson(data[index]));
  }

  static Future<void> updateData(UserDetailModel userDetailModel) async {
    final db = await openDb;
    db.update(_userMst, userDetailModel.toJson(),
        where: 'id=?', whereArgs: [userDetailModel.id]);
  }

  static Future<void> deleteData(int id) async {
    final db = await openDb;
    db.delete(_userMst, where: 'id=?', whereArgs: [id]);
  }
}
