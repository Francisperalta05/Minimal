import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tots_test/src/preferences/preferences.dart';

import '../../models/authentication.dart';
import '../../services/authentication.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationService _authenticationService;
  AuthBloc(this._authenticationService) : super(const AuthState()) {
    on<OnRequestInit>((event, emit) {
      emit.call(state.copyWith(loading: true));
    });
    on<OnRequestFinish>((event, emit) {
      emit.call(state.copyWith(loading: false));
    });
    on<OnShowPassword>((event, emit) {
      emit.call(state.copyWith(hidePassword: event.hidePassword));
    });
  }

  Future<AuthModel> loginUser(String email, String password) async {
    try {
      add(OnRequestInit());
      final result = await _authenticationService.loginUser(email, password);
      preferences.token = result.accessToken??"";

      return result;
    } on Exception catch (e) {
      throw e.toString();
    } finally {
      add(OnRequestFinish());
    }
  }
}
