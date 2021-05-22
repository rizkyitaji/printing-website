part of 'controllers.dart';

class ProfileController extends GetxController {
  final _profile = Profile().obs;
  String message;

  Profile get profile => this._profile.value;
  set profile(Profile value) => this._profile.value = value;

  void clear() => _profile.value = Profile();

  void getProfile() async {
    ApiReturnValue<Profile> result = await ProfileServices.getProfile();

    if (result.value != null) {
      _profile.value = result.value;
    } else {
      message = result.message;
    }
  }

  Future<bool> updateProfile(Profile profile, {PickedFile file}) async {
    ApiReturnValue<bool> result =
        await ProfileServices.updateProfile(profile, file: file);

    if (result.value != null) {
      message = result.message;
      return result.value;
    } else {
      message = result.message;
      return false;
    }
  }
}
