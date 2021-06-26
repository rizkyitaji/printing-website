part of 'controllers.dart';

class OrderController extends GetxController {
  List<Order> orders = [];
  Rx<int> quantity = 100.obs;
  Rx<int> total = 0.obs;
  final _count = 0.obs;
  String message;

  int get count => this._count.value;
  set count(int value) => this._count.value = value;

  void clear() {
    _count.value = 0;
    quantity.value = 100;
    total.value = 0;
  }

  void minOrder() {
    quantity.value = max(100, quantity.value - 1);
    update();
  }

  void maxOrder() {
    quantity.value = min(10000, quantity.value + 1);
    update();
  }

  String totalPrice(int price) {
    total.value = quantity.value * price;
    return Currency.format(total.value);
  }

  Future<bool> submitOrder(Order order, PickedFile file) async {
    ApiReturnValue<Order> result = await OrderServices.submitOrder(order, file);

    if (result.value != null) {
      message = result.message;
      return true;
    } else {
      message = result.message;
      return false;
    }
  }

  void getCount() async {
    ApiReturnValue<int> result = await OrderServices.getCount();

    if (result.value != null) {
      _count.value = result.value;
    }
  }

  void getOrders() async {
    ApiReturnValue<List<Order>> result = await OrderServices.getOrders();

    if (result.value != null) {
      orders = result.value;
      update();
    } else {
      message = result.message;
    }
  }

  void search(String text) async {
    ApiReturnValue<List<Order>> result = await OrderServices.search(text);

    if (result.value != null) {
      orders = result.value;
      update();
    }
  }

  Future<bool> delete(String id) async {
    ApiReturnValue<bool> result = await OrderServices.delete(id);

    if (result.value != null) {
      update();
      return result.value;
    } else {
      message = result.message;
      return false;
    }
  }

  Future<bool> updateStatus(String id, String status) async {
    ApiReturnValue<bool> result = await OrderServices.updateStatus(id, status);

    if (result.value != null) {
      update();
      message = result.message;
      return result.value;
    } else {
      message = result.message;
      return false;
    }
  }
}
