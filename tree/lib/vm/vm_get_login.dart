import 'package:get/get.dart';
import 'package:td_app/model/login/user.dart';
import 'package:td_app/vm/database_handler.dart';


class VMGetXLogin extends GetxController{
  
  String email = "";
  String password = "";
  int id = 0;
  bool checkRe = false;
  DatabaseHandler handler = DatabaseHandler();

  Future<int> userResigeter() async{
    User user = User(email: email, password: password);
    int result = await handler.insertUser(user);
    return result;

  }

  checkEmailPassword() async{
    User user = User(email: email, password: password);
    final result = await handler.queryUser(user);
    
    result.forEach((data) {
      checkRe = data.email == email && data.password == password ? true : false;
      id = data.email == email && data.password == password ? data.id! : 0;
    });
  }

}