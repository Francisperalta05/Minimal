part of 'auth_bloc.dart';

@immutable
class AuthState {
  final bool loading;
  final bool hidePassword;

  const AuthState({
    this.loading = false,
    this.hidePassword = true,
  });

  AuthState copyWith({
    bool? loading,
    bool? hidePassword,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      hidePassword: hidePassword ?? this.hidePassword,
    );
  }
}
