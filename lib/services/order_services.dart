part of 'services.dart';

class OrderServices {
  static Future<ApiReturnValue<Order>> submitOrder(
      Order order, PickedFile file) async {
    String id = '${order.user.email}_${order.date.millisecondsSinceEpoch}';

    try {
      ApiReturnValue<String> result = await Storage.uploadImage(file, id);

      orderRef.doc(id).set({
        'id': id,
        'product': order.product.copyWith(picturePath: result.value).toMap(),
        'quantity': order.quantity,
        'total': order.total,
        'date': order.date.millisecondsSinceEpoch,
        'user': order.user.toMap(),
        'status': 'PENDING',
      });
      return ApiReturnValue(value: order);
    } catch (e) {
      return ApiReturnValue(message: e);
    }
  }

  static Future<ApiReturnValue<int>> getCount() async {
    int length = await orderRef.get().then((value) => value.docs.length);

    return ApiReturnValue(value: length);
  }

  static Future<ApiReturnValue<List<Order>>> getOrders() async {
    try {
      List<Order> orders = await orderRef.get().then((value) {
        return value.docs.map((e) => Order.fromSnapshot(e)).toList();
      });
      return ApiReturnValue(value: orders);
    } catch (e) {
      return ApiReturnValue(message: e);
    }
  }

  static Future<ApiReturnValue<List<Order>>> search(String text) async {
    List<Order> orders = await orderRef.get().then((value) {
      return value.docs.map((e) => Order.fromSnapshot(e)).toList();
    });

    List<Order> query = orders
        .where((element) =>
            element.product.name.toLowerCase().contains(text.toLowerCase()))
        .toList();

    return ApiReturnValue(value: query);
  }

  static Future<ApiReturnValue<bool>> delete(String id) async {
    try {
      orderRef.doc(id).delete();
      Storage.ref(id).delete();

      return ApiReturnValue(value: true);
    } catch (e) {
      return ApiReturnValue(message: e);
    }
  }

  static Future<ApiReturnValue<bool>> updateStatus(
      String id, String status) async {
    try {
      orderRef.doc(id).update({'status': status});
      return ApiReturnValue(value: true, message: 'Status updated');
    } catch (e) {
      return ApiReturnValue(message: e);
    }
  }
}
