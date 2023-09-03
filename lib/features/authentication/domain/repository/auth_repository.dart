import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:land_survey/core/failure.dart';

abstract class AuthRepository {
  Stream<User?> userData();

  Future<Either<Failure, bool>> signIn(String email, String password);

  Future<Either<Failure, bool>> register(String email, String password);
}
