class Post{
  int? id;
  String location, day1, day2;

  Post({
    this.id,
    required this.location,
    required this.day1,
    required this.day2
  });

  Post.fromMap(Map<String, dynamic> res)
    : id = res['id'],
      location = res['location'],
      day1 = res['day1'],
      day2 = res['day2'];
}