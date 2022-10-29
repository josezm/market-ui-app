part of 'login_bloc.dart';

@immutable
abstract class LoginBlocState {}

class Initial extends LoginBlocState {}

class Loading extends LoginBlocState {}

class Loaded extends LoginBlocState {}
