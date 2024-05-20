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

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'day1': day1,
      'day2': day2,
      'mate': mate,
      'weather': weather,
      'travelList': travelList,
    };
  }
}
