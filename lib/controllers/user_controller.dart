part of 'controllers.dart';

class UserController extends GetxController {
  final _user = User().obs;
  final _login = false.obs;
  final _count = 0.obs;
  List<User> users = [];
  String message;

  User get user => this._user.value;
  set user(User value) => this._user.value = value;

  bool get login => this._login.value;
  set login(bool value) => this._login.value = value;

  int get count => this._count.value;
  set count(int value) => this._count.value = value;

  void clear() {
    users = [];
    _user.value = User();
    _login.value = false;
    _count.value = 0;
  }

  Future<bool> signUp(User user) async {
    ApiReturnValue<User> result = await UserServices.signUp(user);

    if (result.value != null) {
      _user.value = result.value;
      message = result.message;
      _login.value = true;
      return true;
    } else {
      message = result.message;
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    ApiReturnValue<User> result = await UserServices.signIn(email, password);

    if (result.value != null) {
      _user.value = result.value;
      message = result.message;
      _login.value = true;
      return true;
    } else {
      message = result.message;
      return false;
    }
  }

  void getCount() async {
    ApiReturnValue<int> result = await UserServices.getCount();

    if (result.value != null) {
      _count.value = result.value;
    }
  }

  void getUsers() async {
    ApiReturnValue<List<User>> result = await UserServices.getUsers();

    if (result.value != null) {
      users = result.value;
      update();
    } else {
      message = result.message;
    }
  }

  void search(String text) async {
    ApiReturnValue<List<User>> result = await UserServices.search(text);

    if (result.value != null) {
      users = result.value;
      update();
    }
  }

  Future<bool> delete(String email) async {
    ApiReturnValue<bool> result = await UserServices.delete(email);

    if (result.value != null) {
      users.removeWhere((element) => element.id == email);
      update();
      return result.value;
    } else {
      message = result.message;
      return false;
    }
  }
}
