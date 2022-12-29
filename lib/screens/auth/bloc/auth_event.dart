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

class UpdateProfileEvent extends AuthEvent {
  final String fullName;
  final String password;
  final File? image;

  UpdateProfileEvent(
      {required this.fullName,
      required this.password,
      this.image});
}

class LogoutEvent extends AuthEvent {}
