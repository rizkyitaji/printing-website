part of 'models.dart';

class Profile extends Equatable {
  final String name;
  final String description;
  final String picturePath;
  final String phone;
  final String email;
  final String address;
  final Bank bank;

  Profile({
    this.name,
    this.description,
    this.picturePath,
    this.phone,
    this.email,
    this.address,
    this.bank,
  });

  factory Profile.fromSnapshot(DocumentSnapshot snapshot) {
    return Profile(
      name: snapshot['name'],
      description: snapshot['description'],
      picturePath: snapshot['picturePath'],
      phone: snapshot['phone'],
      email: snapshot['email'],
      address: snapshot['address'],
      bank: Bank.fromMap(snapshot['bank']),
    );
  }

  @override
  List<Object> get props =>
      [name, description, picturePath, phone, email, address, bank];
}

class Bank extends Equatable {
  final String name;
  final String account;

  Bank({
    this.name,
    this.account,
  });

  factory Bank.fromMap(Map<String, dynamic> map) {
    return Bank(
      name: map['name'],
      account: map['account'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'account': this.account,
    };
  }

  @override
  List<Object> get props => [name, account];
}
