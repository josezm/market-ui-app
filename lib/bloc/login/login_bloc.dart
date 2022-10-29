import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/utils/preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  LoginBloc() : super(Initial());
  UserPreferences _prefs = UserPreferences();

  @override
  Stream<LoginBlocState> mapEventToState(
    LoginBlocEvent event,
  ) async* {
    if (event is LoginByName) {
      yield Loading();
      await Future.delayed(Duration(seconds: 2));
      _prefs.username = event.name;
      _prefs.userlastname = event.lastName;
      _prefs.login = true;
      yield Loaded();
    }
  }
}
