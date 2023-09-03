import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/core/failure.dart';
import 'package:land_survey/core/use_case.dart';
import 'package:land_survey/features/map/data/repository/map_firestore_repo_impl.dart';
import 'package:land_survey/features/map/domain/repository/map_firestore_repo.dart';

class AddFirestorePointUseCase extends UseCase<bool, AddFirestoreParams> {
  final MapFirestoreRepository _mapRepository;

  AddFirestorePointUseCase(this._mapRepository);

  @override
  Future<Either<Failure, bool>> call(AddFirestoreParams params) async {
    return  _mapRepository.addPoint(params.latitude, params.longitude);
  }
}

final addFirestorePointsUseCaseProvider = Provider((ref) {
  final repo = ref.read(mapFirestoreRepoProvider);
  return AddFirestorePointUseCase(repo);
});

class AddFirestoreParams{
  final double latitude;
  final double longitude;

  AddFirestoreParams(this.latitude, this.longitude);
}