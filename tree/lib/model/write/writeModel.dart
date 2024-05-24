class WriteModel {
  int? id;
  String location;
  String day1;
  String day2;
  String mate;
  String weather;
  String travelList;

  WriteModel(
      {this.id,
      required this.location,
      required this.day1,
      required this.day2,
      required this.mate,
      required this.weather,
      required this.travelList});

  WriteModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        location = res['location'],
        day1 = res['day1'],
        day2 = res['day2'],
        mate = res['mate'],
        weather = res['weather'],
        travelList = res['travelList'];
}
