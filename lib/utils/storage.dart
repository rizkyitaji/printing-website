part of 'utils.dart';

class Storage {
  static Reference ref(String id) {
    return FirebaseStorage.instance.ref('images/$id.jpg');
  }

  static Future<ApiReturnValue<String>> uploadImage(
      PickedFile file, String name) async {
    var imageFile = await file.readAsBytes();

    UploadTask task = Storage.ref(name)
        .putData(imageFile, SettableMetadata(contentType: 'image/jpeg'));

    String url = await task.then((value) {
      return value.ref.getDownloadURL();
    });

    return ApiReturnValue(value: url);
  }

  static Future<ApiReturnValue<bool>> downloadImage(String url) async {
    try {
      launch(url);

      return ApiReturnValue(
        value: true,
        message: "Design has been successfully downloaded",
      );
    } catch (e) {
      return ApiReturnValue(value: false, message: e);
    }
  }
}
