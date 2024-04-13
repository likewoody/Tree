import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:td_app/model/td_model.dart';

class DatabaseHandler{
  Future<Database> initializeDB() async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'td.db'),
      onCreate: (db, version) async{
        await db.execute(
          "create table td (id int primary key autoincrement, search_date datetime, user_email text, post_id int)"
        ); 
      },
      version: 1,
    );
  }

  Future<List<Td>> queryStudents() async{
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult 
      = await db.rawQuery('select * from td');
    // 맵 형식인 result를 List로 변환하여 card로 사용한다.
    return queryResult.map((e) => Td.fromMap(e)).toList();
  }

  Future<void> insertStudents(Td td) async{
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
      'insert into td(search_date, user_email, post_id) values(?,?,?)',
      // ?에 값 넣기
      [td.search_date, td.user_email, td.post_id]
    );
  }

  Future<void> updateStudents(Td td) async{
    final Database db = await initializeDB();
    await db.rawUpdate(
      'update td set search_date=?, user_email=?, post_id=? where id=?',
      // ?에 값 넣기
      [td.search_date, td.user_email, td.post_id, td.id]
    );
  }

  Future<void> deleteStudents(String code) async{
    final Database db = await initializeDB();
    await db.rawDelete(
      'delete from td where id = ?',
      // ?에 값 넣기
      [code]
    );
  }

}