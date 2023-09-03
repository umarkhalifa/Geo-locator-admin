import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/core/failure.dart';
import 'package:land_survey/core/use_case.dart';
import 'package:land_survey/features/map/data/repository/map_firestore_repo_impl.dart';
import 'package:land_survey/features/map/domain/repository/map_firestore_repo.dart';

class DeleteFireStorePointUseCase extends UseCase<bool, int> {
  final MapFirestoreRepository _mapRepository;

  DeleteFireStorePointUseCase(this._mapRepository);

  @override
  Future<Either<Failure, bool>> call(int params) async {
    return  _mapRepository.deletePoint(params);
  }
}

final deleteFirestorePointsUseCaseProvider = Provider((ref) {
  final repo = ref.read(mapFirestoreRepoProvider);
  return DeleteFireStorePointUseCase(repo);
});

