class Td{
  int? id;
  late String search_date;
  late String user_email;
  int? post_id;

  Td({
    this.id,
    required this.search_date,
    required this.user_email,
    this.post_id
  });

  Td.fromMap(Map<String, dynamic> res)
    : id = res['id'],
      search_date = res['search_date'],
      user_email = res['user_email'],
      post_id = res['post_id'];
}