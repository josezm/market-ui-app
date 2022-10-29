part of 'login_bloc.dart';

@immutable
abstract class LoginBlocEvent {}

class LoginByName extends LoginBlocEvent {
  final String name, lastName;

  LoginByName({required this.name, required this.lastName});
}
