import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/core/failure.dart';
import 'package:land_survey/core/use_case.dart';
import 'package:land_survey/features/map/data/repository/map_firestore_repo_impl.dart';
import 'package:land_survey/features/map/domain/entity/user.dart';
import 'package:land_survey/features/map/domain/repository/map_firestore_repo.dart';

class FetchUsersUseCase extends UseCase<List<LandUser>, void>{

  final MapFirestoreRepository _firestoreRepository;

  FetchUsersUseCase(this._firestoreRepository);
  @override
  Future<Either<Failure, List<LandUser>>> call(void params)async{
    return await _firestoreRepository.fetchUsers();
  }

}

final fetchUsersCaseProvider = Provider((ref) {
  final repo = ref.read(mapFirestoreRepoProvider);
  return FetchUsersUseCase(repo);
});