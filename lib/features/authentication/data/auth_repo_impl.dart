import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:land_survey/core/failure.dart';
import 'package:land_survey/features/authentication/data/data_source/auth_remote_source.dart';
import 'package:land_survey/features/authentication/domain/repository/auth_repository.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthRemoteSource _authRemoteSource;

  AuthRepoImpl(this._authRemoteSource);

  @override
  Future<Either<Failure, bool>> register(String email, String password) async {
    try {
      return Right(await _authRemoteSource.signUp(email, password));
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> signIn(String email, String password) async {
    try {
      return Right(await _authRemoteSource.signIn(email, password));
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Stream<User?> userData() {
    return _authRemoteSource.getUser();
  }
}

final authRepositoryProvider = Provider((ref) {
  final dataSource = ref.read(authDataSource);
  return AuthRepoImpl(dataSource);
});
