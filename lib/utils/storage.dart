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

  static Future<ApiReturnValue<bool>> downloadImage(String id) async {
    try {
      var file = await ref(id).getData();
      var base64 = base64Encode(file);
      AnchorElement anchor =
          AnchorElement(href: "data:application/octet-stream;base64,$base64")
            ..setAttribute("download", "${ref(id).name}");

      anchor.click();

      return ApiReturnValue(
        value: true,
        message: "Design has been successfully downloaded",
      );
    } catch (e) {
      return ApiReturnValue(value: false, message: e);
    }
  }
}
