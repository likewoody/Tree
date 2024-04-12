import 'package:sqflite/sqflite.dart';

class DatabaseHandler{
  Future<Database> initializeDB() async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'td.db'),
      onCreate: (db, version) async{
        await db.execute(
          "create table td ()"
          need to input datas
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

  Future<void> insertStudents(Td student) async{
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
      'insert into td() values(?,?,?,?)',
      // ?에 값 넣기
      [student.code, student.name, student.dept, student.phone]
    );
  }

  Future<void> updateStudents(Td student) async{
    final Database db = await initializeDB();
    await db.rawUpdate(
      'update td set ',
      // ?에 값 넣기
      [student.name, student.dept, student.phone, student.code]
    );
  }

  Future<void> deleteStudents(String code) async{
    final Database db = await initializeDB();
    await db.rawDelete(
      'delete from td where code = ?',
      // ?에 값 넣기
      [code]
    );
  }

}