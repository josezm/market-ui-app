import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/utils/preferences.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthCubit extends Cubit<AuthStatus> {
  AuthCubit() : super(AuthStatus.checking);
  UserPreferences _prefs = UserPreferences();

  void init() async {
    await Future.delayed(const Duration(seconds: 2));
    bool _islogin = _prefs.login;

    if (_islogin) {
      emit(AuthStatus.authenticated);
    } else {
      emit(AuthStatus.notAuthenticated);
    }
  }
}
