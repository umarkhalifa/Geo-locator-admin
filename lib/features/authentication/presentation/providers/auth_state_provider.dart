import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/features/authentication/data/auth_repo_impl.dart';
import 'package:land_survey/features/authentication/domain/repository/auth_repository.dart';

class AuthStateNotifier extends StateNotifier<bool> {
  AuthStateNotifier(this._authStateRepository) : super(false) {
    registerListener();
  }

  final AuthRepository _authStateRepository;

  void registerListener() {
    _authStateRepository.userData().listen((event) {
      if (event == null) {
        state = false;
      } else {
        state = true;
      }
    });
  }


}

final authStateNotifier = StateNotifierProvider<AuthStateNotifier, bool>(
  (ref) {
    final repo = ref.read(authRepositoryProvider);
    return AuthStateNotifier(repo);
  },
);
