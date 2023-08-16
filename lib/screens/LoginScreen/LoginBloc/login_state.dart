part of 'login_bloc.dart';

abstract class LoginState {}

class LoginSuccess extends LoginState {
  final String message;
  LoginSuccess({required this.message});
}

class LoadingLoginState extends LoginState {}

class InitialLoginState extends LoginState {}

class ErrorLoginState extends LoginState {
  final String error;
  ErrorLoginState({required this.error});
}
