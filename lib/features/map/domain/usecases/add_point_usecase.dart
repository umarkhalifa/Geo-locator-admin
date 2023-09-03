import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/core/failure.dart';
import 'package:land_survey/core/use_case.dart';
import 'package:land_survey/features/map/domain/entity/location_point.dart';
import 'package:land_survey/features/map/domain/repository/map_repository.dart';

class AddPointUseCase extends UseCase<bool, LocationPoint> {
  final MapRepository _mapRepository;

  AddPointUseCase(this._mapRepository);

  @override
  Future<Either<Failure, bool>> call(LocationPoint params) async {
    return await _mapRepository.addMapPoint(params);
  }
}

final addPointUseCaseProvider = Provider((ref) {
  final repo = ref.read(mapRepositoryProvider);
  return AddPointUseCase(repo);
});
