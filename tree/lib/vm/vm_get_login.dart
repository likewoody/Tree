import 'package:get/get.dart';
import 'package:td_app/model/login/user.dart';
import 'package:td_app/vm/database_handler.dart';

class VMGetXLogin extends GetxController{
  
  String email = "";
  String password = "";
  String checkEmailReturn = "";
  int id = 0;
  bool checkRe = false;
  DatabaseHandler handler = DatabaseHandler();

  Future<int> userResigeter() async{
    User user = User(email: email, password: password);
    int result = await handler.insertUser(user);
    return result;

  }

  checkEmailPasswordForLogin() async{
    User user = User(email: email, password: password);
    final result = await handler.queryUser(user);
    
    result.forEach((data) {
      checkRe = data.email == email && data.password == password ? true : false;
      id = data.email == email && data.password == password ? data.id! : 0;
    });
  }

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
    // print("check EmailFor Register $checkEmailReturn");
    // print("${result[0]["email"]}");
    // print("${result[0]["email"]} Futre check Email FOr register");
    // print("return value $checkEmailReturn");
    // return returnValue;
  }

  changePassword() async{
    User user = User(email: email, password: password);
    await handler.updatePassword(user);
    print("sucessful");
  }

}