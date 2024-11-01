part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class OnRequestInit extends AuthEvent {}

class OnRequestFinish extends AuthEvent {}

class OnShowPassword extends AuthEvent {
  final bool hidePassword;

  OnShowPassword(this.hidePassword);
}
