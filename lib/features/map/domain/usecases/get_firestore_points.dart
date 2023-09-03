import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/core/failure.dart';
import 'package:land_survey/core/use_case.dart';
import 'package:land_survey/features/map/data/repository/map_firestore_repo_impl.dart';
import 'package:land_survey/features/map/domain/entity/location_point.dart';
import 'package:land_survey/features/map/domain/repository/map_firestore_repo.dart';

class GetFirestorePointUseCase extends UseCaseStream<List<LocationPoint>, void> {
  final MapFirestoreRepository _mapRepository;

  GetFirestorePointUseCase(this._mapRepository);

  @override
  Stream<Either<Failure, List<LocationPoint>>> call(void params) async* {
    yield*  _mapRepository.watchPoint();
  }
}

final getFirestorePointsUseCaseProvider = Provider((ref) {
  final repo = ref.read(mapFirestoreRepoProvider);
  return GetFirestorePointUseCase(repo);
});
final getMapStreamProvider = StreamProvider((ref){
  final repo = ref.read(getFirestorePointsUseCaseProvider);
  return repo.call(null);
});