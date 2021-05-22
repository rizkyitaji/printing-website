part of 'models.dart';

class Profile extends Equatable {
  final String name;
  final String description;
  final String picturePath;
  final String phone;
  final String email;
  final String address;

  Profile({
    this.name,
    this.description,
    this.picturePath,
    this.phone,
    this.email,
    this.address,
  });

  factory Profile.fromDocSnapshot(DocumentSnapshot data) {
    return Profile(
      name: data['name'],
      description: data['description'],
      picturePath: data['picturePath'],
      phone: data['phone'],
      email: data['email'],
      address: data['address'],
    );
  }

  @override
  List<Object> get props =>
      [name, description, picturePath, phone, email, address];
}

class Client extends Equatable {
  final String id;
  final String picturePath;

  Client({this.id, this.picturePath});

  @override
  List<Object> get props => [id, picturePath];
}
