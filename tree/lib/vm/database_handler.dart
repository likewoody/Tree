import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:td_app/model/login/user.dart';
import 'package:td_app/model/post/post.dart';
import 'package:td_app/model/write/writeModel.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'user.db'),
      onCreate: (db, version) async {
        await db.execute(
            "create table user (id integer primary key autoincrement, email text, password text, active_state integer)");
        await db.execute(
            "create table write (id integer primary key autoincrement, location text, day1 text, day2 text, mate text, weather text, travelList text)");
        await db.execute(
            "create table enquire (id integer primary key autoincrement, title text, content text, insertDate date, image blob)");
      },
      version: 1,
    );
  }


  // ---- User ----
  Future<List<User>> queryUser(User user) async {
    // print("check database handler ㅣ이ㅣ이이이 ${user.email} 이메일 그리고 ${user.password} 패스워드 체크 ");
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
        'select * from user where email=? and password=?',
        [user.email, user.password]);
    // 맵 형식인 result를 List로 변환하여 card로 사용한다.
    return queryResult.map((e) => User.fromMap(e)).toList();
  }

  // 비밀번호 찾기에서 사용할 email 확인
  Future<List<Map<String, Object?>>> queryFindEmail(User user) async {
    final Database db = await initializeDB();
    final result =
        await db.rawQuery('select email from user where email=?', [user.email]);
    return result;
  }

  Future<int> insertUser(User user) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
        'insert into user(email, password, active_state) values(?,?, 1)',
        // ?에 값 넣기
        [user.email, user.password]);
    return result;
  }

  Future<void> updatePassword(User user) async {
    final Database db = await initializeDB();
    await db.rawUpdate(
        'update user set password=? where email = ?',
        // ?에 값 넣기
        [user.password, user.email]);
  }

  Future<void> deleteUser(String code) async {
    final Database db = await initializeDB();
    await db.rawDelete(
        'update user set active_state = 0 where id = ?',
        // ?에 값 넣기
        [code]);
  }



  // ---- Post ----
  Future<List<Post>> queryPost() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
        'select * from write',
    );
    // 맵 형식인 result를 List로 변환하여 card로 사용한다.
    return queryResult.map((e) => Post.fromMap(e)).toList();
  }

  Future<void> deletePost(int id) async {
    final Database db = await initializeDB();
    print("deletePOst Check inside db handler $id");
    await db.rawDelete(
        'delete from write where id = ?',
        // ?에 값 넣기
        [id]);
  }

  // -----------------------------------

  // Future<Database> createWriteTable() async {
  //   String path = await getDatabasesPath();
  //   return openDatabase(
  //     join(path, 'user.db'),
  //     onCreate: (db, version) async {
  //       await db.execute(
  //           "create table write (id integer primary key autoincrement, location text, day1 text, day2 text, mate text, weather text, travelList text)");
  //     },
  //     version: 1,
  //   );
  // }

  Future<int> insertWrite(WriteModel writeModel) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
      'insert into write(location,day1,day2,mate,weather,travelList) values(?,?,?,?,?,?)',
      // ?에 값 넣기
      [
        writeModel.location,
        writeModel.day1,
        writeModel.day2,
        writeModel.mate,
        writeModel.weather,
        writeModel.travelList,
      ],
    );
    return result;
  }

  // queryWrite() async {
  //   final Database db = await initializeDB();
  //   final queryResult = await db.rawQuery('select * from write where id = 1');
  //   // 맵 형식인 result를 List로 변환하여 card로 사용한다.
  //   print(queryResult);
  // }
}
