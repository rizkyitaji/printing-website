part of 'models.dart';

class Profile extends Equatable {
  final String name;
  final String description;
  final String picturePath;
  final String phone;
  final String email;
  final String address;
  final BankAccount bankAccount;

  Profile({
    this.name,
    this.description,
    this.picturePath,
    this.phone,
    this.email,
    this.address,
    this.bankAccount,
  });

  Profile copyWith({
    String name,
    String description,
    String picturePath,
    String phone,
    String email,
    String address,
    BankAccount bankAccount,
  }) =>
      Profile(
        name: name ?? this.name,
        description: description ?? this.description,
        picturePath: picturePath ?? this.picturePath,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        address: address ?? this.address,
        bankAccount: bankAccount ?? this.bankAccount,
      );

  factory Profile.fromSnapshot(DocumentSnapshot snapshot) {
    return Profile.fromMap(snapshot.data());
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      name: map['name'],
      description: map['description'],
      picturePath: map['picturePath'],
      phone: map['phone'],
      email: map['email'],
      address: map['address'],
      bankAccount: BankAccount.fromMap(map['bankAccount']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'description': this.description,
      'picturePath': this.picturePath,
      'phone': this.phone,
      'email': this.email,
      'address': this.address,
      'bankAccount': this.bankAccount.toMap(),
    };
  }

  @override
  List<Object> get props =>
      [name, description, picturePath, phone, email, address, bankAccount];
}

class BankAccount extends Equatable {
  final String owner;
  final String number;

  BankAccount({
    this.owner,
    this.number,
  });

  factory BankAccount.fromMap(Map<String, dynamic> map) {
    return BankAccount(
      owner: map['owner'],
      number: map['number'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'owner': this.owner,
      'number': this.number,
    };
  }

  @override
  List<Object> get props => [owner, number];
}

class Pictures extends Equatable {
  final int id;
  final String path;

  Pictures({this.id, this.path});

  factory Pictures.fromMap(Map<String, dynamic> map) {
    return Pictures(
      id: map['id'],
      path: map['path'],
    );
  }

  @override
  List<Object> get props => [id, path];
}
