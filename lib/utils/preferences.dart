import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instancia = new UserPreferences._internal();

  factory UserPreferences() {
    return _instancia;
  }

  UserPreferences._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  String get username {
    return _prefs.getString('user_name') ?? '';
  }

  set username(String value) {
    _prefs.setString('user_name', value);
  }

  String get userlastname {
    return _prefs.getString('user_lastname') ?? '';
  }

  set userlastname(String value) {
    _prefs.setString('user_lastname', value);
  }

  String get products {
    return _prefs.getString('products') ?? '';
  }

  set products(String value) {
    _prefs.setString('products', value);
  }

  bool get login {
    return _prefs.getBool('login') ?? false;
  }

  set login(bool value) {
    _prefs.setBool('login', value);
  }
}
