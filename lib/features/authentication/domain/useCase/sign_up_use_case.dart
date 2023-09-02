import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/core/failure.dart';
import 'package:land_survey/core/use_case.dart';
import 'package:land_survey/features/authentication/data/auth_repo_impl.dart';
import 'package:land_survey/features/authentication/domain/repository/auth_repository.dart';

class RegisterUseCase extends UseCase<bool, RegisterParams> {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  @override
  Future<Either<Failure, bool>> call(RegisterParams params) async {
    return await _authRepository.register(params.email, params.password);
  }
}

class RegisterParams {
  final String email;
  final String password;

  RegisterParams({required this.email, required this.password});
}

final registerUseCase = Provider(
      (ref) {
    final repo = ref.read(authRepositoryProvider);
    return RegisterUseCase(repo);
  },
);
