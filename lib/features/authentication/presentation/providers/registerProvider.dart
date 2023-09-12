import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/features/authentication/domain/useCase/sign_up_use_case.dart';

enum AuthState { idle, loading, error }

class AuthDataState {
  final AuthState status;
  final String errorMessage;

  AuthDataState(this.status, this.errorMessage);

  AuthDataState.initial({this.status = AuthState.idle, this.errorMessage = ''});

  AuthDataState copyWith({AuthState? status, String? errorMessage}) {
    return AuthDataState(
        status ?? this.status, errorMessage ?? this.errorMessage);
  }
}

class RegisterNotifier extends StateNotifier<AuthDataState> {
  RegisterNotifier(this._useCase) : super(AuthDataState.initial());

  final RegisterUseCase _useCase;

  Future<void> register(String email, String password) async {
    state = state.copyWith(status: AuthState.loading);
    final value =
        await _useCase.call(RegisterParams(email: email, password: password));
    state = value.fold(
      (l) {
        return state.copyWith(status: AuthState.error, errorMessage: l.message);
      },
      (r) {
        return state = state.copyWith(
          status: AuthState.idle,
        );
      },
    );
  }
}

final registerNotifier =
    StateNotifierProvider.autoDispose<RegisterNotifier, AuthDataState>((ref) {
  final useCase = ref.read(registerUseCase);
  return RegisterNotifier(useCase);
});
