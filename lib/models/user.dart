part of 'models.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String address;
  final String city;
  final String level;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.address,
    this.city,
    this.level,
  });

  factory User.fromDocSnapshot(DocumentSnapshot data) {
    return User(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      password: data['password'],
      phone: data['phone'],
      address: data['address'],
      city: data['city'],
      level: data['level'],
    );
  }

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      password: data['password'],
      phone: data['phone'],
      address: data['address'],
      city: data['city'],
      level: data['level'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'email': this.email,
      'password': this.password,
      'phone': this.phone,
      'address': this.address,
      'city': this.city,
      'level': this.level,
    };
  }

  @override
  List<Object> get props =>
      [id, name, email, password, phone, address, city, level];
}
