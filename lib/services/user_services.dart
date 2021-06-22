part of 'services.dart';

class UserServices {
  static Future<ApiReturnValue<User>> signUp(User user) async {
    DocumentSnapshot data = await userRef.doc(user.email).get();
    if (data.exists) {
      return ApiReturnValue(message: 'Email ${user.email} is already exist');
    } else {
      try {
        await userRef.doc(user.email).set({
          'id': user.id,
          'name': user.name,
          'email': user.email,
          'password': user.password,
          'phone': user.phone,
          'address': user.address,
          'city': user.city,
          'level': user.level,
        });
        return ApiReturnValue(value: user, message: 'Welcome');
      } catch (e) {
        return ApiReturnValue(message: e);
      }
    }
  }

  static Future<ApiReturnValue<User>> signIn(
      String email, String password) async {
    DocumentSnapshot value = await userRef.doc(email).get();
    try {
      if (!value.exists) {
        return ApiReturnValue(message: 'Wrong email address');
      } else {
        if (password.compareTo(value.get('password')) == 0) {
          User user = User.fromSnapshot(value);
          return ApiReturnValue(value: user, message: 'Welcome');
        } else {
          return ApiReturnValue(message: 'Incorrect password');
        }
      }
    } catch (e) {
      return ApiReturnValue(message: e);
    }
  }

  static Future<ApiReturnValue<int>> getCount() async {
    int length = await userRef.get().then((value) => value.docs.length);

    return ApiReturnValue(value: length);
  }

  static Future<ApiReturnValue<List<User>>> getUsers() async {
    try {
      List<User> users = await userRef.get().then((value) {
        return value.docs.map((e) => User.fromSnapshot(e)).toList();
      });
      return ApiReturnValue(value: users);
    } catch (e) {
      return ApiReturnValue(message: e);
    }
  }

  static Future<ApiReturnValue<List<User>>> search(String text) async {
    List<User> users = await userRef.get().then((value) {
      return value.docs.map((e) => User.fromSnapshot(e)).toList();
    });

    List<User> query = users
        .where((element) =>
            element.name.toLowerCase().contains(text.toLowerCase()))
        .toList();

    return ApiReturnValue(value: query);
  }

  static Future<ApiReturnValue<bool>> delete(String email) async {
    try {
      userRef.doc(email).delete();
      return ApiReturnValue(value: true);
    } catch (e) {
      return ApiReturnValue(message: e);
    }
  }
}
