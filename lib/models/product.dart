part of 'models.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String picturePath;
  final List<Option> options;
  final Option option;

  Product({
    this.id,
    this.name,
    this.picturePath,
    this.options,
    this.option,
  });

  Product copyWith({
    String id,
    String name,
    String picturePath,
    List<Option> options,
    Option option,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        picturePath: picturePath ?? this.picturePath,
        options: options ?? this.options,
        option: option ?? this.option,
      );

  factory Product.fromSnapshot(DocumentSnapshot snapshot) {
    return Product.fromMap(snapshot.data());
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    List<Map> optionList = map['options'].cast<Map>();
    var options = optionList.map((e) => Option.fromMap(e)).toList();

    return Product(
      id: map['id'],
      name: map['name'],
      picturePath: map['picturePath'],
      options: options,
      option: map['option'] != null ? Option.fromMap(map['option']) : Option(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'picturePath': this.picturePath,
      'options': toListOfMap(),
      'option': this.option.toMap(),
    };
  }

  List<Map<String, dynamic>> toListOfMap() {
    List<Map<String, dynamic>> optionList = [];
    this.options.forEach((element) {
      optionList.add(element.toMap());
    });
    return optionList;
  }

  @override
  List<Object> get props => [id, name, picturePath, options];
}

enum Options { one, two, three }

class Option extends Equatable {
  final int id;
  final String variant;
  final int price;

  Option({this.id, this.variant, this.price});

  factory Option.fromMap(Map<String, dynamic> map) {
    return Option(
      id: map['id'],
      variant: map['variant'],
      price: map['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'variant': this.variant,
      'price': this.price,
    };
  }

  @override
  List<Object> get props => [id, price];
}
