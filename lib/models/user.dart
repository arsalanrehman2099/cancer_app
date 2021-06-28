class User {
  String? id;
  String? name;
  String? email;
  String? password;
  String? contact;

  User({this.id, this.name, this.email,this.password, this.contact});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'contact': contact,
    };
  }

  User fromJson(Map<String,dynamic> user) {
    return User(
      id: user['id'],
      name: user['name'],
      email: user['email'],
      contact: user['contact'],
    );
  }
}
