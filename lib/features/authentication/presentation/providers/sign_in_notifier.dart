import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/features/authentication/domain/useCase/login_usecase.dart';
import 'package:land_survey/features/authentication/presentation/providers/registerProvider.dart';

class SignInNotifier extends StateNotifier<AuthDataState> {
  SignInNotifier(this._useCase) : super(AuthDataState.initial());

  final LoginUseCase _useCase;

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(status: AuthState.loading);
    final value =
        await _useCase.call(LoginParams(email: email, password: password));
    state = value.fold(
      (l) {
        return state.copyWith(
            status: AuthState.error,
            errorMessage: "Check credentials and try again");
      },
      (r) {
        return state = state.copyWith(
          status: AuthState.idle,
        );
      },
    );
  }
}

final signInNotifier =
    StateNotifierProvider.autoDispose<SignInNotifier, AuthDataState>((ref) {
  final useCase = ref.read(loginUseCase);
  return SignInNotifier(useCase);
});
