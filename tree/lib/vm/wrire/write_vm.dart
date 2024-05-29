import 'package:get/get.dart';
import 'package:td_app/model/write/writeModel.dart';
import 'package:td_app/vm/database_handler.dart';

class WriteVm extends GetxController {
  bool editingmode = true;
  String location = "";
  String day1 = "";
  String day2 = "";
  String mate = "";
  String weather = "";
  String travelList = "";
  int postId = 0;
  var dbHandler = DatabaseHandler();

  insertWrite(String loc, String day1, String day2, String mate, String weather,
      String list) async {
    // await dbHandler.createWriteTable();
    await dbHandler.insertWrite(WriteModel(
        location: loc,
        day1: day1,
        day2: day2,
        mate: mate,
        weather: weather,
        travelList: list));
  }

  detailView() async {
    final selectDB = await dbHandler.queryWrite(postId);
    selectDB.forEach((element) {
      location = element.location;
      day1 = element.day1;
      day2 = element.day2;
      mate = element.mate;
      weather = element.weather;
      travelList = element.travelList;
    });
    update();
  }

  updateWrite(String loc, String day1, String day2, String mate, String weather,
      String list) async {
    await dbHandler.updatetWrite(
        WriteModel(
          location: loc,
          day1: day1,
          day2: day2,
          mate: mate,
          weather: weather,
          travelList: list,
        ),
        postId);

    update();
  }

  editingMode() {
    editingmode = false;
    update();
  }
}
