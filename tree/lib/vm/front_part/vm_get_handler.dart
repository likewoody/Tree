import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:td_app/model/login/user.dart';
import 'package:td_app/model/post/post.dart';
import 'package:td_app/vm/database_handler.dart';

class VMGetHandler extends GetxController{
  
  String email = "";
  String password = "";
  String checkEmailReturn = "";
  int id = 0;
  bool checkPassword= false;
  bool checkActive = false;
  DatabaseHandler handler = DatabaseHandler();
  final box = GetStorage();

  // for post part 
  List<Post> posts = [];
  // List<String> day1 = [];
  // List<String> day2 = [];
  // List<String> location = [];




  Future<int> userResigeter() async{
    User user = User(email: email, password: password);
    int result = await handler.insertUser(user);
    return result;
  }


  // ---- Login ----
  checkEmailPasswordForLogin() async{
    User user = User(email: email, password: password);
    final result = await handler.queryUser(user);
    
    result.forEach((data) {
      // 비밀번호 체크
      checkPassword = data.email == email && data.password == password ? true : false;
      // 아이디 확인
      id = data.email == email && data.password == password ? data.id! : 0;
      // active 상태 확인
      checkActive = data.active_state == 1 ? true : false;
    });
  }


  // ---- Register ----
  checkEmailForRegister() async{
    // print("왜 email은 안들어올까? $email");
    List<Map> result;
    User user = User(email: email, password: password);
    result = await handler.queryFindEmail(user);
    try {
      // print("${result[0]["email"]}   result[0]['email']");
      // print(email);
      checkEmailReturn = result[0]["email"] == email ? result[0]["email"] : "";
    } catch (e){
      e.printError();
    }
  }


  // ---- Set Password ----
  changePassword() async{
    // print("check email 2 : $email");
    // print("check password2 : $password");
    // print("check id2 : ");
    User user = User(email: email, password: password);
    await handler.updatePassword(user);
    print("sucessful");
  }

  // ---- DeActive User ----
  deactiveUser() async{
    final userInfo = box.read("userInfo");
    await handler.deleteUser(userInfo['id']);
  }

  // ---- GetStorage stored datas ----
  changedStoredBox(userInfo) {
    Map<String, String> map;
    
    if (userInfo == null){
      // login시 보낼 정보
      map = {
        'id': id.toString(),
        'email':email,
        'password':password,
        'active_state':"1"
      };
    } else {
      email = userInfo['email'];

      map = {
        'id':userInfo['id'],
        'email':userInfo['email'],
        'password':password
      };
    }
    // 유저 정보 보내는 box
    box.write("userInfo", map); 
    // 이걸 안해주면 changePassword에 파라미터를 받아야 한다.
  }



  // ---- Search Post ----
  Future<List<Post>> searchPostDB() async{
    print("들어와?");
    
    posts = await handler.queryPost();
    // posts.forEach((element) {
    //   day1.add(element.day1);
    //   day2.add(element.day2);
    //   location.add(element.location);
    // });

    update();
    print("업데이트 실행ㅎ");
    
    return posts;

    // return posts;
  }

  // ---- Delete Post ----
  deletePost(id) async{
    print(id);
    await handler.deletePost(id);
    update();
  }
}
