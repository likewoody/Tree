class User{
  int? id;
  String email, password;
  int? active_state;

  User({
    this.id,
    this.active_state,
    required this.email,
    required this.password,
  });

  User.fromMap(Map<String, dynamic> res)
    : id = res['id'],
      email = res['email'],
      password = res['password'],
      active_state = res['active_state'];
}