part of 'controllers.dart';

class ProductController extends GetxController {
  List<Product> products = <Product>[].obs;
  final _option = Option().obs;
  final _count = 0.obs;
  String message;

  int get count => this._count.value;
  set count(int value) => this._count.value = value;

  Option get option => this._option.value;
  set option(Option value) => this._option.value = value;

  void clear() {
    products = [];
    option = Option();
    _count.value = 0;
  }

  Future<bool> addProduct(Product product, PickedFile file) async {
    ApiReturnValue<Product> result =
        await ProductServices.addProduct(product, file);

    if (result.value != null) {
      products.add(result.value);
      message = result.message;
      return true;
    } else {
      message = result.message;
      return false;
    }
  }

  void getProducts() async {
    ApiReturnValue<List<Product>> result = await ProductServices.getProducts();

    if (result.value != null) {
      products = result.value;
      update();
    } else {
      message = result.message;
    }
  }

  void search(String text) async {
    ApiReturnValue<List<Product>> result = await ProductServices.search(text);

    if (result.value != null) {
      products = result.value;
      update();
    }
  }

  Future<bool> delete(String id) async {
    ApiReturnValue<bool> result = await ProductServices.delete(id);

    if (result.value != null) {
      products.removeWhere((element) => element.id == id);
      update();
      return result.value;
    } else {
      message = result.message;
      return false;
    }
  }

  void getCount() async {
    ApiReturnValue<int> result = await ProductServices.getCount();

    if (result.value != null) {
      _count.value = result.value;
    }
  }
}
