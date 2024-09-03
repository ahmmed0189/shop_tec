class User {
  String username;
  String email;
  String password;
  int id;
  String name;

  User({
    required this.username,
    required this.email,
    required this.password,
    required this.id,
    required this.name,
  });
  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "email": email,
      "password": password,
      "id": id,
      "name": name,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        username: map["username"],
        email: map["email"],
        password: map["password"],
        id: map["id"],
        name: map["name"]);
  }
}
