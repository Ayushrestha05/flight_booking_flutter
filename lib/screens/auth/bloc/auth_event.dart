part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class CheckAuthEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class RegisterEvent extends AuthEvent {
  final String fullName;
  final String email;
  final String password;

  RegisterEvent(
      {required this.fullName, required this.email, required this.password});
}

class LogoutEvent extends AuthEvent {}
