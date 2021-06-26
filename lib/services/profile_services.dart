part of 'services.dart';

class ProfileServices {
  static Future<ApiReturnValue<Profile>> getProfile() async {
    try {
      Profile profile = await profileRef.get().then((value) {
        return Profile.fromSnapshot(value.docs.first);
      });
      return ApiReturnValue(value: profile);
    } catch (e) {
      return ApiReturnValue(message: e);
    }
  }

  static Future<ApiReturnValue<bool>> updateProfile(Profile profile,
      {PickedFile file}) async {
    try {
      if (file != null) {
        ApiReturnValue<String> result = await uploadImage(file);

        profileRef.doc('Company').set({
          'name': profile.name,
          'description': profile.description,
          'picturePath': result.value,
          'phone': profile.phone,
          'email': profile.email,
          'address': profile.address,
          'bank': profile.bank.toMap(),
        });
      } else {
        profileRef.doc('Company').set({
          'name': profile.name,
          'description': profile.description,
          'phone': profile.phone,
          'email': profile.email,
          'address': profile.address,
          'bank': profile.bank.toMap(),
        });
      }

      return ApiReturnValue(
        value: true,
        message: 'Your company profile has been updated',
      );
    } catch (e) {
      return ApiReturnValue(message: e);
    }
  }

  static Future<ApiReturnValue<String>> uploadImage(PickedFile file) async {
    Reference ref = FirebaseStorage.instance.ref('images/logo.jpg');

    var imageFile = await file.readAsBytes();
    UploadTask task =
        ref.putData(imageFile, SettableMetadata(contentType: 'image/jpeg'));

    String url = await task.then((value) {
      return value.ref.getDownloadURL();
    });

    return ApiReturnValue(value: url);
  }
}
