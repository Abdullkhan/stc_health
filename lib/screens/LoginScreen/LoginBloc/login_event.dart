part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginData extends LoginEvent {
  final String email;
  final String password;
  LoginData({
    required this.email,
    required this.password,
  });
}
