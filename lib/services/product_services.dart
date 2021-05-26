part of 'services.dart';

class ProductServices {
  static Future<ApiReturnValue<Product>> addProduct(
      Product product, PickedFile file) async {
    try {
      ApiReturnValue<String> result = await uploadImage(file, product.name);

      productRef.add({}).then(
        (value) => value.set({
          'id': value.id,
          'name': product.name,
          'description': product.description,
          'picturePath': result.value,
          'price1': product.price1,
          'price2': product.price2,
        }),
      );
      return ApiReturnValue(value: product, message: 'New product added!');
    } catch (e) {
      return ApiReturnValue(message: e);
    }
  }

  static Future<ApiReturnValue<List<Product>>> getProducts() async {
    try {
      List<Product> products = await productRef.get().then((value) {
        return value.docs.map((e) => Product.fromDocSnapshot(e)).toList();
      });
      return ApiReturnValue(value: products);
    } catch (e) {
      return ApiReturnValue(message: e);
    }
  }

  static Future<ApiReturnValue<List<Product>>> search(String text) async {
    List<Product> orders = await productRef.get().then((value) {
      return value.docs.map((e) => Product.fromDocSnapshot(e)).toList();
    });

    List<Product> query = orders
        .where((element) =>
            element.name.toLowerCase().contains(text.toLowerCase()))
        .toList();

    return ApiReturnValue(value: query);
  }

  static Future<ApiReturnValue<bool>> delete(String id) async {
    try {
      productRef.doc(id).delete();
      return ApiReturnValue(value: true);
    } catch (e) {
      return ApiReturnValue(message: e);
    }
  }

  static Future<ApiReturnValue<int>> getCount() async {
    int length = await productRef.get().then((value) => value.docs.length);

    return ApiReturnValue(value: length);
  }

  static Future<ApiReturnValue<String>> uploadImage(
      PickedFile file, String name) async {
    Reference ref = FirebaseStorage.instance.ref('images/$name.jpg');

    var imageFile = await file.readAsBytes();
    UploadTask task =
        ref.putData(imageFile, SettableMetadata(contentType: 'image/jpeg'));

    String url = await task.then((value) {
      return value.ref.getDownloadURL();
    });

    return ApiReturnValue(value: url);
  }
}