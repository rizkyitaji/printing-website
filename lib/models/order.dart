part of 'models.dart';

enum OrderStatus { pending, cancelled, on_process, on_delivery, delivered }

class Order extends Equatable {
  final String id;
  final Product product;
  final int quantity;
  final int total;
  final DateTime date;
  final User user;
  final OrderStatus status;

  Order({
    this.id,
    this.product,
    this.quantity,
    this.total,
    this.date,
    this.user,
    this.status,
  });

  factory Order.fromSnapshot(DocumentSnapshot snapshot) {
    return Order(
      id: snapshot['id'],
      product: Product.fromMap(snapshot['product']),
      quantity: snapshot['quantity'],
      total: snapshot['total'],
      date: DateTime.fromMillisecondsSinceEpoch(snapshot['date']),
      user: User.fromMap(snapshot['user']),
      status: (snapshot['status'] == 'PENDING')
          ? OrderStatus.pending
          : (snapshot['status'] == 'DELIVERED')
              ? OrderStatus.delivered
              : (snapshot['status'] == 'CANCELLED')
                  ? OrderStatus.cancelled
                  : (snapshot['status'] == 'ON DELIVERY')
                      ? OrderStatus.on_delivery
                      : OrderStatus.on_process,
    );
  }

  @override
  List<Object> get props => [id, product, quantity, total, date, user, status];
}
