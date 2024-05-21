import 'package:td_app/model/write/writeModel.dart';
import 'package:td_app/vm/database_handler.dart';

class WriteVm {
  insertWrite(String loc, String day1, String day2, String mate, String weather,
      String list) async {
    var dbHandler = DatabaseHandler();
    // await dbHandler.createWriteTable();
    await dbHandler.insertWrite(WriteModel(
        location: loc,
        day1: day1,
        day2: day2,
        mate: mate,
        weather: weather,
        travelList: list));
  }
}
