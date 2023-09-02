import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/core/failure.dart';
import 'package:land_survey/core/use_case.dart';
import 'package:land_survey/features/authentication/data/auth_repo_impl.dart';
import 'package:land_survey/features/authentication/domain/repository/auth_repository.dart';

class LoginUseCase extends UseCase<bool, LoginParams> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  Future<Either<Failure, bool>> call(LoginParams params) async {
    return await _authRepository.signIn(params.email, params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}

final loginUseCase = Provider(
  (ref) {
    final repo = ref.read(authRepositoryProvider);
    return LoginUseCase(repo);
  },
);
