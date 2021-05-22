part of 'models.dart';

enum OrderStatus { pending, cancelled, on_process, on_delivery, delivered }

class Order extends Equatable {
  final String id;
  final Product product;
  final int quantity;
  final int total1;
  final int total2;
  final DateTime date;
  final User user;
  final OrderStatus status;

  Order({
    this.id,
    this.product,
    this.quantity,
    this.total1,
    this.total2,
    this.date,
    this.user,
    this.status,
  });

  factory Order.fromDocSnapshot(DocumentSnapshot data) {
    return Order(
      id: data['id'],
      product: Product.fromMap(data['product']),
      quantity: data['quantity'],
      total1: data['total1'],
      total2: data['total2'],
      date: DateTime.fromMillisecondsSinceEpoch(data['date']),
      user: User.fromMap(data['user']),
      status: (data['status'] == 'PENDING')
          ? OrderStatus.pending
          : (data['status'] == 'DELIVERED')
              ? OrderStatus.delivered
              : (data['status'] == 'CANCELLED')
                  ? OrderStatus.cancelled
                  : (data['status'] == 'ON DELIVERY')
                      ? OrderStatus.on_delivery
                      : OrderStatus.on_process,
    );
  }

  @override
  List<Object> get props =>
      [id, product, quantity, total1, total2, date, user, status];
}

List<Order> orders = [
  Order(
    id: '1',
    product: products[0],
    quantity: 1,
    total1: products[0].price1 * 1,
    total2: products[0].price2 * 1,
    date: DateTime.now(),
    user: User(),
    status: OrderStatus.cancelled,
  )
];
