part of 'models.dart';

class Profile extends Equatable {
  final String name;
  final String description;
  final String picturePath;
  final String phone;
  final String email;
  final String address;
  final String bankAccount;

  Profile({
    this.name,
    this.description,
    this.picturePath,
    this.phone,
    this.email,
    this.address,
    this.bankAccount,
  });

  factory Profile.fromSnapshot(DocumentSnapshot snapshot) {
    return Profile(
      name: snapshot['name'],
      description: snapshot['description'],
      picturePath: snapshot['picturePath'],
      phone: snapshot['phone'],
      email: snapshot['email'],
      address: snapshot['address'],
      bankAccount: snapshot['bankAccount'],
    );
  }

  @override
  List<Object> get props =>
      [name, description, picturePath, phone, email, address, bankAccount];
}
