part of 'models.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final String picturePath;
  final int price1;
  final int price2;

  Product({
    this.id,
    this.name,
    this.description,
    this.picturePath,
    this.price1,
    this.price2,
  });

  factory Product.fromDocSnapshot(DocumentSnapshot data) {
    return Product(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      picturePath: data['picturePath'],
      price1: data['price1'],
      price2: data['price2'],
    );
  }

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      picturePath: data['picturePath'],
      price1: data['price1'],
      price2: data['price2'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
      'picturePath': this.picturePath,
      'price1': this.price1,
      'price2': this.price2,
    };
  }

  @override
  List<Object> get props =>
      [id, name, description, picturePath, price1, price2];
}

List<Product> products = [
  Product(
    id: '1',
    name: 'Brosur',
    description: lorem,
    picturePath: 'assets/brosur.jpg',
    price1: 20000,
    price2: 50000,
  ),
  Product(
    id: '2',
    name: 'Buku Laporan',
    description: lorem,
    picturePath: 'assets/buku_laporan.jpg',
    price1: 20000,
    price2: 50000,
  ),
  Product(
    id: '3',
    name: 'Agenda Kerja',
    description: lorem,
    picturePath: 'assets/agenda_kerja.jpg',
    price1: 20000,
    price2: 50000,
  ),
  Product(
    id: '4',
    name: 'Notes',
    description: lorem,
    picturePath: 'assets/notes.jpg',
    price1: 20000,
    price2: 50000,
  ),
  Product(
    id: '5',
    name: 'Map / Cover',
    description: lorem,
    picturePath: 'assets/map_cover.jpg',
    price1: 20000,
    price2: 50000,
  ),
  Product(
    id: '6',
    name: 'Paper Bag',
    description: lorem,
    picturePath: 'assets/paper_bag.jpg',
    price1: 20000,
    price2: 50000,
  ),
];
