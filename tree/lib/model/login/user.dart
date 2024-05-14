class User{
  int? id;
  String email, password;

  User({
    this.id,
    required this.email,
    required this.password
  });

  User.fromMap(Map<String, dynamic> res)
    : id = res['id'],
      email = res['email'],
      password = res['password'];
}