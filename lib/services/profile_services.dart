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

  static Future<ApiReturnValue<List<Pictures>>> getSliders() async {
    var ref = firestore.collection('Sliders');

    try {
      var pictures = await ref.get().then((value) {
        return value.docs.map((e) => Pictures.fromMap(e.data())).toList();
      });
      return ApiReturnValue(value: pictures);
    } catch (e) {
      return ApiReturnValue(message: e);
    }
  }

  static Future<ApiReturnValue<bool>> updateProfile(Profile profile,
      {PickedFile file}) async {
    try {
      if (file != null) {
        ApiReturnValue<String> result = await Storage.uploadImage(file, 'logo');
        Profile value = profile.copyWith(picturePath: result.value);
        profileRef.doc('Company').set(value.toMap());
      } else {
        profileRef.doc('Company').set(profile.toMap());
      }

      return ApiReturnValue(
        value: true,
        message: 'Your company profile has been updated',
      );
    } catch (e) {
      return ApiReturnValue(message: e);
    }
  }
}
