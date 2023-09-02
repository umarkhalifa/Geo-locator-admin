import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/core/failure.dart';
import 'package:land_survey/core/use_case.dart';
import 'package:land_survey/features/map/domain/entity/location_point.dart';
import 'package:land_survey/features/map/domain/repository/map_repository.dart';

class GetPointUseCase extends UseCase<List<LocationPoint>, void> {
  final MapRepository _mapRepository;

  GetPointUseCase(this._mapRepository);

  @override
  Future<Either<Failure, List<LocationPoint>>> call(void params) async {
    return await _mapRepository.getMapPoints();
  }
}

final getPointsUseCaseProvider = Provider((ref) {
  final repo = ref.read(mapRepositoryProvider);
  return GetPointUseCase(repo);
});