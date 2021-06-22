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

  User copyWith({
    String id,
    String name,
    String email,
    String password,
    String phone,
    String address,
    String city,
    String level,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        city: city ?? this.city,
        level: level ?? this.level,
      );

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    return User.fromMap(snapshot.data());
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      phone: map['phone'],
      address: map['address'],
      city: map['city'],
      level: map['level'],
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
